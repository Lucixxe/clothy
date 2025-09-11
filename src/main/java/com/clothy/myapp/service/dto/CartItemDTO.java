package com.clothy.myapp.service.dto;

import com.clothy.myapp.domain.CartItem;
import java.io.Serializable;

public class CartItemDTO implements Serializable {

    private Long cartId; // Ajouter cette propriété manquante
    private Long productId;
    private Integer quantity;
    private CartItem cartItem;

    public CartItemDTO() {}

    public CartItemDTO(CartItem crtItem) {
        this.cartItem = crtItem;
        if (crtItem != null) {
            this.cartId = crtItem.getCart() != null ? crtItem.getCart().getId() : null;
            this.productId = crtItem.getProduct() != null ? crtItem.getProduct().getId() : null;
            this.quantity = crtItem.getQuantity();
        }
    }

    public Long getCartId() { // Ajouter ce getter manquant
        return cartId;
    }

    public void setCartId(Long cartId) { // Ajouter ce setter
        this.cartId = cartId;
    }

    public Long getProductId() {
        return productId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setProductId(Long id) {
        this.productId = id;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
