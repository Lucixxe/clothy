package com.clothy.myapp.service.impl;

import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.domain.Product;
import com.clothy.myapp.repository.CartItemRepository;
import com.clothy.myapp.repository.CartRepository;
import com.clothy.myapp.repository.ProductRepository;
import com.clothy.myapp.service.CartItemService;
import com.clothy.myapp.service.CheckOutService;
import com.clothy.myapp.service.dto.CartItemDTO;
import com.clothy.myapp.web.rest.errors.BadRequestAlertException;
import com.clothy.myapp.web.rest.errors.OutOfStockException;
import com.clothy.myapp.web.rest.errors.OutOfStockException;
import com.clothy.myapp.web.rest.errors.ProductNotFoundException;
import jakarta.persistence.EntityNotFoundException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.clothy.myapp.domain.CartItem}.
 */
@Service
@Transactional
public class CartItemServiceImpl implements CartItemService {

    private static final Logger LOG = LoggerFactory.getLogger(CartItemServiceImpl.class);

    private final CartItemRepository cartItemRepository;

    private final CartRepository cartRepository;

    private final ProductRepository productRepository;

    public CartItemServiceImpl(CartItemRepository cartItemRepository, CartRepository crtRepo, ProductRepository prdRepo) {
        this.cartItemRepository = cartItemRepository;
        this.cartRepository = crtRepo;
        this.productRepository = prdRepo;
    }

    @Override
    public CartItem save(CartItem cartItem) {
        LOG.debug("Request to save CartItem : {}", cartItem);
        return cartItemRepository.save(cartItem);
    }

    @Override
    public CartItem update(CartItem cartItem) {
        LOG.debug("Request to update CartItem : {}", cartItem);
        return cartItemRepository.save(cartItem);
    }

    @Override
    public List<CartItem> findAllForCartItem(Long cartId) {
        return cartItemRepository.getAllCartItemsForCart(cartId);
    }

    @Override
    public Optional<CartItem> partialUpdate(CartItem cartItem) {
        LOG.debug("Request to partially update CartItem : {}", cartItem);

        return cartItemRepository
            .findById(cartItem.getId())
            .map(existingCartItem -> {
                if (cartItem.getQuantity() != null) {
                    // Vérifier le stock du produit
                    int stockDisponible = existingCartItem.getProduct().getSku();
                    int newQuantity = cartItem.getQuantity();

                    if (newQuantity > stockDisponible) {
                        throw new BadRequestAlertException(
                            "Quantité demandée supérieure au stock disponible (" + stockDisponible + ")",
                            "cartItem",
                            "stockinsuffisant"
                        );
                    }

                    existingCartItem.setQuantity(newQuantity);
                    existingCartItem.setLineTotal(existingCartItem.getUnitPrice().multiply(BigDecimal.valueOf(newQuantity)));
                }

                if (cartItem.getUnitPrice() != null) {
                    existingCartItem.setUnitPrice(cartItem.getUnitPrice());
                }
                if (cartItem.getLineTotal() != null) {
                    existingCartItem.setLineTotal(cartItem.getLineTotal());
                }
                if (cartItem.getIsInOrder() != null) {
                    existingCartItem.setIsInOrder(cartItem.getIsInOrder());
                }

                return existingCartItem;
            })
            .map(cartItemRepository::save);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CartItem> findAll() {
        LOG.debug("Request to get all CartItems");
        return cartItemRepository.findAll();
    }

    public Page<CartItem> findAllWithEagerRelationships(Pageable pageable) {
        return cartItemRepository.findAllWithEagerRelationships(pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<CartItem> findOne(Long id) {
        LOG.debug("Request to get CartItem : {}", id);
        return cartItemRepository.findOneWithEagerRelationships(id);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete CartItem : {}", id);
        cartItemRepository.deleteById(id);
    }

    @Override
    public List<CartItem> findAllByCartId(Long cartId) {
        return cartItemRepository.findAllByCartId(cartId);
    }

    @Override
    public CartItemDTO ajoutPanier(Cart cart, Long productId, Integer quantity) {
        Product product = productRepository
            .findById(productId)
            .orElseThrow(() -> new ProductNotFoundException(Long.toString(productId), "Produit non trouvé : " + productId));

        if (product.getSku() == null || product.getSku() <= 0) {
            throw new OutOfStockException("Produit en rupture de stock", Long.toString(productId), Integer.toString(quantity));
        }
        Optional<CartItem> existingItem = cartItemRepository.findByCartAndProduct(cart, product);
        CartItem cartItem = existingItem.orElse(createNewCartItem(cart, product, quantity));

        if (existingItem.isPresent() && existingItem.get().getIsInOrder() == false) {
            // Only update if it was an existing item

            int newQuantity = cartItem.getQuantity() + quantity;
            if (newQuantity > product.getSku()) {
                throw new OutOfStockException("Produit en rupture de stock", Long.toString(productId), Integer.toString(quantity));
            }
            cartItem.setQuantity(newQuantity);
            cartItem.setLineTotal(product.getPrice().multiply(BigDecimal.valueOf(newQuantity)));
        } else {
            if (quantity > product.getSku()) {
                throw new OutOfStockException("Produit en rupture de stock", Long.toString(productId), Integer.toString(quantity));
            }
            cartItem = createNewCartItem(cart, product, quantity);
        }
        /*

        

        if (existingItem.isPresent()) {
            cartItem = existingItem.get();
            int newQuantity = cartItem.getQuantity() + quantity;
            cartItem.setQuantity(newQuantity);
            cartItem.setLineTotal(product.getPrice().multiply(BigDecimal.valueOf(newQuantity)));
        } else {
            cartItem = new CartItem();
            cartItem.setCart(cart);
            cartItem.setProduct(product);
            cartItem.setQuantity(quantity);
            cartItem.setUnitPrice(product.getPrice());
            cartItem.setLineTotal(product.getPrice().multiply(BigDecimal.valueOf(quantity)));
            cartItem.setIsInOrder(false);
        }
            */
        cartItem = cartItemRepository.save(cartItem);
        CartItemDTO res = new CartItemDTO();
        res.setProductId(product.getId());
        res.setQuantity(cartItem.getQuantity());
        return res;
    }

    private CartItem createNewCartItem(Cart cart, Product product, int quantity) {
        CartItem newItem = new CartItem();
        newItem.setCart(cart);
        newItem.setProduct(product);
        newItem.setQuantity(quantity);
        newItem.setUnitPrice(product.getPrice());
        newItem.setLineTotal(product.getPrice().multiply(BigDecimal.valueOf(quantity)));
        newItem.setIsInOrder(false);
        return newItem;
    }

    @Override
    @Transactional
    public void deleteAllByCartId(Long cartId) {
        List<CartItem> listOfCustomerItems = cartItemRepository.getAllCartItemsForCart(cartId);
        for (CartItem c : listOfCustomerItems) {
            delete(c.getId());
        }
    }

    @Override
    public List<CartItem> findAllForCartItemNotInOrder(Long cartId) {
        return cartItemRepository.getAllCartItemsForCartNotInOrder(cartId);
    }
}
