package com.clothy.myapp.web.rest.errors;

public class CartNotFoundException extends RuntimeException {

    String cartId;

    public CartNotFoundException(String message, String cartId) {
        super(message);
        this.cartId = cartId;
    }

    public String getCartId() {
        return cartId;
    }
}
/**
 *
 *
 *
 * DONT LEAVE UR PC OPEN; WE WILL DELETE UR PROJECT NEXT TIME
 *
 *
 *
 *
 */
