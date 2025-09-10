package com.clothy.myapp.service.impl;

import com.clothy.myapp.repository.CartRepository;
import com.clothy.myapp.repository.ProductRepository;
import com.clothy.myapp.service.CheckOutService;
import com.clothy.myapp.service.dto.CheckOutResultDTO;
import org.springframework.stereotype.Service;

@Service
public class CheckOutServiceImpl implements CheckOutService {

    private final CartRepository cartRepository;
    private final ProductRepository productRepository;

    public CheckOutServiceImpl(CartRepository cartRepository, ProductRepository productRepository) {
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
    }

    @Override
    public CheckOutResultDTO checkOut(Long cartId) {
        var cart = cartRepository.findById(cartId).orElseThrow(() -> new RuntimeException("Panier non trouvé"));

        // On suppose que cart.getItems() retourne la liste des CartItem
        /* 
        cart.getItems().forEach(cartItem -> {
                var product = cartItem.getProduct();
                int quantity = cartItem.getQuantity();

                if (product.getStock() < quantity) {
                    throw new RuntimeException("Stock insuffisant pour le produit " + product.getName());
                }

                product.setStock(product.getStock() - quantity);
                productRepository.save(product);
            });

        CheckOutResultDTO result = new CheckOutResultDTO();
        result.setSuccess(true);
        result.setMessage("Checkout effectué, stock mis à jour.");
        return result;
        */
        return null;
    }
}
