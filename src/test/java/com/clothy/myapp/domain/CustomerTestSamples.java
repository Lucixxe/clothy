package com.clothy.myapp.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class CustomerTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static Customer getCustomerSample1() {
        return new Customer()
            .id(1L)
            .email("email1")
            .firstName("firstName1")
            .name("name1")
            .passwordHash("passwordHash1")
            .address("address1");
    }

    public static Customer getCustomerSample2() {
        return new Customer()
            .id(2L)
            .email("email2")
            .firstName("firstName2")
            .name("name2")
            .passwordHash("passwordHash2")
            .address("address2");
    }

    public static Customer getCustomerRandomSampleGenerator() {
        return new Customer()
            .id(longCount.incrementAndGet())
            .email(UUID.randomUUID().toString())
            .firstName(UUID.randomUUID().toString())
            .name(UUID.randomUUID().toString())
            .passwordHash(UUID.randomUUID().toString())
            .address(UUID.randomUUID().toString());
    }
}
