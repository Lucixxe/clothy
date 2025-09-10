package com.clothy.myapp.service.dto;

public class CheckOutResultDTO {

    private boolean success;
    private String message;

    // getters et setters
    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
