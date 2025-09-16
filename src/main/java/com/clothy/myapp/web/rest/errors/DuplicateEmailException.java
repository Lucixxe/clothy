package com.clothy.myapp.web.rest.errors;

public class DuplicateEmailException extends RuntimeException {

    String email;

    public DuplicateEmailException(String message, String email) {
        super(message);
        this.email = email;
    }

    public String getEmail() {
        return email;
    }
}
