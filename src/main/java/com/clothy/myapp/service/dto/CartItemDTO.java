package com.clothy.myapp.service.dto;

import com.clothy.myapp.domain.CartItem;
import java.io.Serializable;
import java.util.UUID;

public class CartItemDTO implements Serializable {

    private Long productId;
    private Integer quantity;
    private CartItem cartItem;

    public CartItemDTO() {}

    public CartItemDTO(CartItem crtItem) {
        this.cartItem = crtItem;
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
