package com.clothy.myapp.web.rest.errors;

public class OutOfStockException extends RuntimeException {

    String productId;
    String quantity;
    String productName;

    public OutOfStockException(String message, String productId, String quantity, String name) {
        super(message);
        this.productId = productId;
        this.quantity = quantity;
        this.productName = name;
    }

    public String getproductId() {
        return productId;
    }

    public String getQuantity() {
        return quantity;
    }

    public String getName() {
        return productName;
    }
}
