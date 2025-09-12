package com.clothy.myapp.web.rest.errors;

public class OutOfStockException extends RuntimeException {

    String productId;
    String quantity;

    public OutOfStockException(String message, String productId, String quantity) {
        super(message);
        this.productId = productId;
        this.quantity = quantity;
    }

    public String getproductId() {
        return productId;
    }

    public String getQuantity() {
        return quantity;
    }
}
