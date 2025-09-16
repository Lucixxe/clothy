package com.clothy.myapp.service;

import com.stripe.Stripe;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import java.util.*;
import org.springframework.stereotype.Service;

@Service
public class PayementService {

    public Session createCheckoutSession(Long amount) throws Exception {
        Stripe.apiKey = "clé stripe";

        SessionCreateParams params = SessionCreateParams.builder()
            .setMode(SessionCreateParams.Mode.PAYMENT)
            .setSuccessUrl("http://localhost:8080/payment-success")
            .setCancelUrl("http://localhost:8080/payment-cancel")
            .addLineItem(
                SessionCreateParams.LineItem.builder()
                    .setQuantity(1L)
                    .setPriceData(
                        SessionCreateParams.LineItem.PriceData.builder()
                            .setCurrency("eur")
                            .setUnitAmount(amount) // montant en centimes
                            .setProductData(SessionCreateParams.LineItem.PriceData.ProductData.builder().setName("Commande Clothy").build())
                            .build()
                    )
                    .build()
            )
            .build();

        return Session.create(params);
    }
}
