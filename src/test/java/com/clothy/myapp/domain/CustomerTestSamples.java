package com.clothy.myapp.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class CustomerTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static Customer getCustomerSample1() {
        return new Customer().id(1L).email("email1").fullName("fullName1").passwordHash("passwordHash1");
    }

    public static Customer getCustomerSample2() {
        return new Customer().id(2L).email("email2").fullName("fullName2").passwordHash("passwordHash2");
    }

    public static Customer getCustomerRandomSampleGenerator() {
        return new Customer()
            .id(longCount.incrementAndGet())
            .email(UUID.randomUUID().toString())
            .fullName(UUID.randomUUID().toString())
            .passwordHash(UUID.randomUUID().toString());
    }
}
