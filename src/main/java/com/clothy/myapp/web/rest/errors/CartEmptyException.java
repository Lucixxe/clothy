package com.clothy.myapp.web.rest.errors;

public class CartEmptyException extends RuntimeException {

    private String cartId;

    public CartEmptyException(String message, String cartId) {
        super(message);
        this.cartId = cartId;
    }

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }
}
