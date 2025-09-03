package com.clothy.myapp.domain;

import static com.clothy.myapp.domain.CartTestSamples.*;
import static com.clothy.myapp.domain.CustomerTestSamples.*;
import static org.assertj.core.api.Assertions.assertThat;

import com.clothy.myapp.web.rest.TestUtil;
import org.junit.jupiter.api.Test;

class CustomerTest {

    @Test
    void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Customer.class);
        Customer customer1 = getCustomerSample1();
        Customer customer2 = new Customer();
        assertThat(customer1).isNotEqualTo(customer2);

        customer2.setId(customer1.getId());
        assertThat(customer1).isEqualTo(customer2);

        customer2 = getCustomerSample2();
        assertThat(customer1).isNotEqualTo(customer2);
    }

    @Test
    void cartTest() {
        Customer customer = getCustomerRandomSampleGenerator();
        Cart cartBack = getCartRandomSampleGenerator();

        customer.setCart(cartBack);
        assertThat(customer.getCart()).isEqualTo(cartBack);
        assertThat(cartBack.getCustomer()).isEqualTo(customer);

        customer.cart(null);
        assertThat(customer.getCart()).isNull();
        assertThat(cartBack.getCustomer()).isNull();
    }
}
