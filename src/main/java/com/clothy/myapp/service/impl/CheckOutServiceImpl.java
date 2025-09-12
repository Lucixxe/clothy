package com.clothy.myapp.service.impl;

import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.domain.Customer;
import com.clothy.myapp.domain.CustomerOrder;
import com.clothy.myapp.domain.Product;
import com.clothy.myapp.repository.CartItemRepository;
import com.clothy.myapp.repository.CartRepository;
import com.clothy.myapp.repository.ProductRepository;
import com.clothy.myapp.service.CartItemService;
import com.clothy.myapp.service.CheckOutService;
import com.clothy.myapp.service.CustomerOrderService;
import com.clothy.myapp.service.dto.CartItemDTO;
import com.clothy.myapp.service.dto.CheckOutResultDTO;
import com.clothy.myapp.web.rest.errors.AssociateCartItemsException;
import com.clothy.myapp.web.rest.errors.CartNotFoundException;
import com.clothy.myapp.web.rest.errors.CustomerNotFoundException;
import com.clothy.myapp.web.rest.errors.OutOfStockException;
import com.clothy.myapp.web.rest.errors.ProductNotFoundException;
import com.clothy.myapp.web.rest.errors.UpdateStockException;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CheckOutServiceImpl implements CheckOutService {

    private final CartRepository cartRepository;
    private final ProductRepository productRepository;

    @Autowired
    private CartItemService cartItemService;

    @Autowired
    private CustomerOrderService customerOrderService;

    @Autowired
    private CartItemRepository cartItemRepository;

    public CheckOutServiceImpl(CartRepository cartRepository, ProductRepository productRepository) {
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
    }

    public List<CartItemDTO> getCartItemDTOsForCart(Long cartId, List<CartItemDTO> allItems) {
        return allItems.stream().filter(item -> item.getCartId() != null && item.getCartId().equals(cartId)).collect(Collectors.toList());
    }

    private CustomerOrder createCustomerOrder(Long cartId, List<CartItemDTO> cartItems, Customer customer) {
        CustomerOrder order = new CustomerOrder();

        // Générer un numéro de commande unique
        order.setOrderNumber("ORD-" + System.currentTimeMillis() + "-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());

        // Définir la date de création
        order.setCreatedAt(Instant.now());

        // Fixer le prix à 0 pour l'instant
        order.setTotal(BigDecimal.ZERO);

        // Associer le customer à la commande
        order.setCustomer(customer);

        return customerOrderService.save(order);
    }

    private void associateCartItemsToOrder(Long cartId, Long customerOrderId) {
        // Récupérer la CustomerOrder
        CustomerOrder customerOrder = customerOrderService
            .findOne(customerOrderId)
            .orElseThrow(() -> new RuntimeException("CustomerOrder non trouvée avec l'ID: " + customerOrderId));

        // Récupérer tous les cart_items associés à ce cart
        List<CartItem> cartItems = cartItemRepository
            .findAll()
            .stream()
            .filter(item -> item.getCart() != null && item.getCart().getId().equals(cartId))
            .collect(Collectors.toList());

        System.out.println("Associating " + cartItems.size() + " cart items to order " + customerOrderId);

        // Pour chaque cart_item, setter le customerOrder et marquer comme étant dans une commande
        for (CartItem cartItem : cartItems) {
            cartItem.setCustomerOrder(customerOrder);
            cartItem.setIsInOrder(true); // Marquer comme étant dans une commande
            cartItemRepository.save(cartItem);
            System.out.println("Cart item " + cartItem.getId() + " associé à la commande " + customerOrderId);
        }
    }

    @Override
    @Transactional
    public CheckOutResultDTO checkOut(Long cartId) {
        List<CartItemDTO> allItems = cartItemService.findAll().stream().map(CartItemDTO::new).collect(Collectors.toList());
        List<CartItemDTO> cartItems = getCartItemDTOsForCart(cartId, allItems);

        StringBuilder detailsBuilder = new StringBuilder("Détails du checkout : ");
        boolean success = true;
        String errorMessage = "";

        // Récupérer le cart et son customer associé
        Cart cart = cartRepository
            .findById(cartId)
            .orElseThrow(() -> new CartNotFoundException("Cart non trouvé avec l'ID: " + cartId, Long.toString(cartId)));
        Customer customer = cart.getCustomer();

        if (customer == null) {
            throw new CustomerNotFoundException("Aucun customer associé au cart ID: " + cartId);
        }

        //Obtenir tous les produits TRIÈS du panier
        List<Long> productIds = cartItems.stream().map(CartItemDTO::getProductId).distinct().sorted().collect(Collectors.toList());

        Map<Long, Integer> productQuantityMap = cartItems
            .stream()
            .collect(Collectors.groupingBy(CartItemDTO::getProductId, Collectors.summingInt(CartItemDTO::getQuantity)));

        try {
            //Obtention de tous les produits TRIES et VERROUILLES
            List<Product> lockedProducts = productRepository.findAndLockProductsByIdsOrderedById(productIds);
            //Si le nombre de product obtenu n'est pas egale au nombre de product dans le panier
            if (lockedProducts.size() != productIds.size()) {
                Set<Long> foundIds = lockedProducts.stream().map(Product::getId).collect(Collectors.toSet());
                List<Long> missingIds = productIds.stream().filter(id -> !foundIds.contains(id)).collect(Collectors.toList());
                throw new ProductNotFoundException("Produits non trouvés: " + missingIds);
            }

            //Verification du stock pour chaque produit
            for (Product product : lockedProducts) {
                Long productId = product.getId();
                Integer requestedQuantity = productQuantityMap.get(productId);

                if (product.getSku() < requestedQuantity) {
                    errorMessage =
                        "Stock insuffisant pour le produit " +
                        productId +
                        " (disponible: " +
                        product.getSku() +
                        ", demandé: " +
                        requestedQuantity +
                        ")";
                    detailsBuilder.append("Échec - Produit ").append(productId).append(" : stock insuffisant; ");
                    throw new OutOfStockException(errorMessage, Long.toString(productId), Integer.toString(requestedQuantity));
                }
            }

            //Tous les produits ont un stock suffisant, maintenant mise à jour
            for (Product product : lockedProducts) {
                Long productId = product.getId();
                Integer quantityToDeduct = productQuantityMap.get(productId);

                System.out.println("Mise à jour stock pour produit=" + productId + ", quantité=" + quantityToDeduct);
                product.setSku(product.getSku() - quantityToDeduct);
                productRepository.save(product);

                System.out.println("Stock mis à jour pour le produit " + productId + " (quantité retirée=" + quantityToDeduct + ")");
                detailsBuilder.append("Produit ").append(productId).append(" : -").append(quantityToDeduct).append(" unités; ");
            }

            // Créer la commande client après la mise à jour réussie du stock
            CustomerOrder order = createCustomerOrder(cartId, cartItems, customer);
            System.out.println("Commande créée avec l'ID: " + order.getId() + " pour le customer ID: " + customer.getId());
            detailsBuilder
                .append("Commande #")
                .append(order.getId())
                .append(" créée pour customer #")
                .append(customer.getId())
                .append("; ");

            // Associer tous les cart_items à la commande créée
            associateCartItemsToOrder(cartId, order.getId());
            System.out.println("Cart items associés à la commande " + order.getId());
            detailsBuilder.append("Cart items associés à la commande; ");

            CheckOutResultDTO result = new CheckOutResultDTO();
            result.setSuccess(true);
            result.setMessage("Checkout effectué, stock mis à jour, commande créée et cart items associés.");
            return result;
        } catch (OutOfStockException | ProductNotFoundException e) {
            // Re-throw business logic exceptions
            throw e;
        } catch (Exception e) {
            errorMessage = "Erreur lors de la mise à jour du stock: " + e.getMessage();
            System.err.println(errorMessage);
            throw new UpdateStockException(errorMessage);
        }
        /* 
        // Mise à jour du stock
        for (CartItemDTO item : cartItems) {
            Long productId = item.getProductId();
            Integer quantity = item.getQuantity();
            System.out.println("Tentative MAJ stock pour produit=" + productId + ", quantité demandée=" + quantity);
            try {
                int updated = productRepository.decrementStockAtomic(productId, quantity);
                System.out.println("Résultat MAJ=" + updated);

                if (updated == 0) {
                    System.out.println("Stock insuffisant pour le produit " + productId + " (demande=" + quantity + ")");
                    success = false;
                    errorMessage = "Stock insuffisant pour le produit " + productId + "et avec quantite " + quantity;
                    detailsBuilder.append("Échec - Produit ").append(productId).append(" : stock insuffisant; ");
                    throw new OutOfStockException(errorMessage, Long.toString(productId), Integer.toString(quantity));
                } else {
                    System.out.println("Stock mis à jour pour le produit " + productId + " (quantité retirée=" + quantity + ")");
                    detailsBuilder.append("Produit ").append(productId).append(" : -").append(quantity).append(" unités; ");
                }
            } catch (Exception e) {
                success = false;
                errorMessage = "Erreur lors de la mise à jour du stock: " + e.getMessage();
                System.err.println(errorMessage);
                throw new UpdateStockException(errorMessage);
            }
        }

        // Créer la commande client après la mise à jour réussie du stock
        CustomerOrder order;
        try {
            order = createCustomerOrder(cartId, cartItems, customer);
            System.out.println("Commande créée avec l'ID: " + order.getId() + " pour le customer ID: " + customer.getId());
            detailsBuilder
                .append("Commande #")
                .append(order.getId())
                .append(" créée pour customer #")
                .append(customer.getId())
                .append("; ");
        } catch (Exception e) {
            System.err.println("Erreur lors de la création de la commande: " + e.getMessage());
            throw new UpdateStockException("Erreur lors de la création de la commande: " + e.getMessage());
        }

        // Associer tous les cart_items à la commande créée
        try {
            associateCartItemsToOrder(cartId, order.getId());
            System.out.println("Cart items associés à la commande " + order.getId());
            detailsBuilder.append("Cart items associés à la commande; ");
        } catch (Exception e) {
            System.err.println("Erreur lors de l'association des cart items: " + e.getMessage());
            throw new AssociateCartItemsException("Erreur lors de l'association des cart items: " + e.getMessage());
        }

        CheckOutResultDTO result = new CheckOutResultDTO();
        result.setSuccess(true);
        result.setMessage("Checkout effectué, stock mis à jour, commande créée et cart items associés.");
        return result;
        */
    }
}
