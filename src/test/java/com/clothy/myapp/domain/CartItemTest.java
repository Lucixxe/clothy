package com.clothy.myapp.domain;

import static com.clothy.myapp.domain.CartItemTestSamples.*;
import static com.clothy.myapp.domain.CartTestSamples.*;
import static com.clothy.myapp.domain.CustomerOrderTestSamples.*;
import static com.clothy.myapp.domain.ProductTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.clothy.myapp.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class CartItemTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(CartItem.class);
        CartItem cartItem1 = getCartItemSample1();
        CartItem cartItem2 = new CartItem();
        assertThat(cartItem1).isNotEqualTo(cartItem2);

        cartItem2.setId(cartItem1.getId());
        assertThat(cartItem1).isEqualTo(cartItem2);

        cartItem2 = getCartItemSample2();
        assertThat(cartItem1).isNotEqualTo(cartItem2);
    }

    @Test
    void cartTest() {
        CartItem cartItem = getCartItemRandomSampleGenerator();
        Cart cartBack = getCartRandomSampleGenerator();

        cartItem.setCart(cartBack);
        assertThat(cartItem.getCart()).isEqualTo(cartBack);

        cartItem.cart(null);
        assertThat(cartItem.getCart()).isNull();
    }

    @Test
    void productTest() {
        CartItem cartItem = getCartItemRandomSampleGenerator();
        Product productBack = getProductRandomSampleGenerator();

        cartItem.setProduct(productBack);
        assertThat(cartItem.getProduct()).isEqualTo(productBack);

        cartItem.product(null);
        assertThat(cartItem.getProduct()).isNull();
    }

    @Test
    void customerOrderTest() {
        CartItem cartItem = getCartItemRandomSampleGenerator();
        CustomerOrder customerOrderBack = getCustomerOrderRandomSampleGenerator();

        cartItem.setCustomerOrder(customerOrderBack);
        assertThat(cartItem.getCustomerOrder()).isEqualTo(customerOrderBack);

        cartItem.customerOrder(null);
        assertThat(cartItem.getCustomerOrder()).isNull();
    }
}
