package com.clothy.myapp.web.rest.errors;

public class ProductNotFoundException extends RuntimeException {

    private final String productId;

    public ProductNotFoundException(String productID, String message) {
        super(message);
        this.productId = productID;
    }

    public ProductNotFoundException(String message) {
        super(message);
        this.productId = "";
    }

    public String getProductId() {
        return productId;
    }
}
