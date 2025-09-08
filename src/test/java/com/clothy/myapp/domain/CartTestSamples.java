package com.clothy.myapp.domain;

import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

public class CartTestSamples {

    private static final Random random = new Random();
    private static final AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    public static Cart getCartSample1() {
        return new Cart().id(1L).cartKey(UUID.fromString("23d8dc04-a48b-45d9-a01d-4b728f0ad4aa"));
    }

    public static Cart getCartSample2() {
        return new Cart().id(2L).cartKey(UUID.fromString("ad79f240-3727-46c3-b89f-2cf6ebd74367"));
    }

    public static Cart getCartRandomSampleGenerator() {
        return new Cart().id(longCount.incrementAndGet()).cartKey(UUID.randomUUID());
    }
}
