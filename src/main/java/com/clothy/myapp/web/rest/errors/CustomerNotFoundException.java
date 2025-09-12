package com.clothy.myapp.web.rest.errors;

public class CustomerNotFoundException extends RuntimeException {

    String customerId;

    public CustomerNotFoundException(String message, String customerId) {
        super(message);
        this.customerId = customerId;
    }

    public CustomerNotFoundException(String message) {
        super(message);
    }

    public String getCartId() {
        return customerId;
    }
}
