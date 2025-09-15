package com.clothy.myapp.web.rest;

import com.clothy.myapp.service.PayementService;
import com.stripe.model.checkout.Session;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/payment")
public class PaymentController {

    private final PayementService paymentService;

    public PaymentController(PayementService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/create-checkout-session")
    public String createCheckoutSession(@RequestParam Long amount) throws Exception {
        Session session = paymentService.createCheckoutSession(amount);
        return session.getUrl(); // On retourne l’URL Stripe Checkout
    }
}
