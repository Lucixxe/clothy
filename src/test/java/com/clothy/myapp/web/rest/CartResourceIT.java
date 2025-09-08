package com.clothy.myapp.web.rest;

import static com.clothy.myapp.domain.CartAsserts.*;
import static com.clothy.myapp.web.rest.TestUtil.createUpdateProxyForBean;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.clothy.myapp.IntegrationTest;
import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.domain.Customer;
import com.clothy.myapp.repository.CartRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityManager;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

/**
 * Integration tests for the {@link CartResource} REST controller.
 */
@IntegrationTest
@ExtendWith(MockitoExtension.class)
@AutoConfigureMockMvc
@WithMockUser
class CartResourceIT {

    private static final UUID DEFAULT_CART_KEY = UUID.randomUUID();
    private static final UUID UPDATED_CART_KEY = UUID.randomUUID();

    private static final Instant DEFAULT_CREATED_AT = Instant.ofEpochMilli(0L);
    private static final Instant UPDATED_CREATED_AT = Instant.now().truncatedTo(ChronoUnit.MILLIS);

    private static final Boolean DEFAULT_IS_CHECKED_OUT = false;
    private static final Boolean UPDATED_IS_CHECKED_OUT = true;

    private static final String ENTITY_API_URL = "/api/carts";
    private static final String ENTITY_API_URL_ID = ENTITY_API_URL + "/{id}";

    private static Random random = new Random();
    private static AtomicLong longCount = new AtomicLong(random.nextInt() + (2 * Integer.MAX_VALUE));

    @Autowired
    private ObjectMapper om;

    @Autowired
    private CartRepository cartRepository;

    @Mock
    private CartRepository cartRepositoryMock;

    @Autowired
    private EntityManager em;

    @Autowired
    private MockMvc restCartMockMvc;

    private Cart cart;

    private Cart insertedCart;

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Cart createEntity(EntityManager em) {
        Cart cart = new Cart().cartKey(DEFAULT_CART_KEY).createdAt(DEFAULT_CREATED_AT).isCheckedOut(DEFAULT_IS_CHECKED_OUT);
        // Add required entity
        Customer customer;
        if (TestUtil.findAll(em, Customer.class).isEmpty()) {
            customer = CustomerResourceIT.createEntity();
            em.persist(customer);
            em.flush();
        } else {
            customer = TestUtil.findAll(em, Customer.class).get(0);
        }
        cart.setCustomer(customer);
        return cart;
    }

    /**
     * Create an updated entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Cart createUpdatedEntity(EntityManager em) {
        Cart updatedCart = new Cart().cartKey(UPDATED_CART_KEY).createdAt(UPDATED_CREATED_AT).isCheckedOut(UPDATED_IS_CHECKED_OUT);
        // Add required entity
        Customer customer;
        if (TestUtil.findAll(em, Customer.class).isEmpty()) {
            customer = CustomerResourceIT.createUpdatedEntity();
            em.persist(customer);
            em.flush();
        } else {
            customer = TestUtil.findAll(em, Customer.class).get(0);
        }
        updatedCart.setCustomer(customer);
        return updatedCart;
    }

    @BeforeEach
    void initTest() {
        cart = createEntity(em);
    }

    @AfterEach
    void cleanup() {
        if (insertedCart != null) {
            cartRepository.delete(insertedCart);
            insertedCart = null;
        }
    }

    @Test
    @Transactional
    void createCart() throws Exception {
        long databaseSizeBeforeCreate = getRepositoryCount();
        // Create the Cart
        var returnedCart = om.readValue(
            restCartMockMvc
                .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(cart)))
                .andExpect(status().isCreated())
                .andReturn()
                .getResponse()
                .getContentAsString(),
            Cart.class
        );

        // Validate the Cart in the database
        assertIncrementedRepositoryCount(databaseSizeBeforeCreate);
        assertCartUpdatableFieldsEquals(returnedCart, getPersistedCart(returnedCart));

        insertedCart = returnedCart;
    }

    @Test
    @Transactional
    void createCartWithExistingId() throws Exception {
        // Create the Cart with an existing ID
        cart.setId(1L);

        long databaseSizeBeforeCreate = getRepositoryCount();

        // An entity with an existing ID cannot be created, so this API call must fail
        restCartMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(cart)))
            .andExpect(status().isBadRequest());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    void checkCartKeyIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        cart.setCartKey(null);

        // Create the Cart, which fails.

        restCartMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(cart)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkCreatedAtIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        cart.setCreatedAt(null);

        // Create the Cart, which fails.

        restCartMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(cart)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void checkIsCheckedOutIsRequired() throws Exception {
        long databaseSizeBeforeTest = getRepositoryCount();
        // set the field null
        cart.setIsCheckedOut(null);

        // Create the Cart, which fails.

        restCartMockMvc
            .perform(post(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(cart)))
            .andExpect(status().isBadRequest());

        assertSameRepositoryCount(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    void getAllCarts() throws Exception {
        // Initialize the database
        insertedCart = cartRepository.saveAndFlush(cart);

        // Get all the cartList
        restCartMockMvc
            .perform(get(ENTITY_API_URL + "?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(cart.getId().intValue())))
            .andExpect(jsonPath("$.[*].cartKey").value(hasItem(DEFAULT_CART_KEY.toString())))
            .andExpect(jsonPath("$.[*].createdAt").value(hasItem(DEFAULT_CREATED_AT.toString())))
            .andExpect(jsonPath("$.[*].isCheckedOut").value(hasItem(DEFAULT_IS_CHECKED_OUT)));
    }

    @SuppressWarnings({ "unchecked" })
    void getAllCartsWithEagerRelationshipsIsEnabled() throws Exception {
        when(cartRepositoryMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        restCartMockMvc.perform(get(ENTITY_API_URL + "?eagerload=true")).andExpect(status().isOk());

        verify(cartRepositoryMock, times(1)).findAllWithEagerRelationships(any());
    }

    @SuppressWarnings({ "unchecked" })
    void getAllCartsWithEagerRelationshipsIsNotEnabled() throws Exception {
        when(cartRepositoryMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        restCartMockMvc.perform(get(ENTITY_API_URL + "?eagerload=false")).andExpect(status().isOk());
        verify(cartRepositoryMock, times(1)).findAll(any(Pageable.class));
    }

    @Test
    @Transactional
    void getCart() throws Exception {
        // Initialize the database
        insertedCart = cartRepository.saveAndFlush(cart);

        // Get the cart
        restCartMockMvc
            .perform(get(ENTITY_API_URL_ID, cart.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
            .andExpect(jsonPath("$.id").value(cart.getId().intValue()))
            .andExpect(jsonPath("$.cartKey").value(DEFAULT_CART_KEY.toString()))
            .andExpect(jsonPath("$.createdAt").value(DEFAULT_CREATED_AT.toString()))
            .andExpect(jsonPath("$.isCheckedOut").value(DEFAULT_IS_CHECKED_OUT));
    }

    @Test
    @Transactional
    void getNonExistingCart() throws Exception {
        // Get the cart
        restCartMockMvc.perform(get(ENTITY_API_URL_ID, Long.MAX_VALUE)).andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    void putExistingCart() throws Exception {
        // Initialize the database
        insertedCart = cartRepository.saveAndFlush(cart);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the cart
        Cart updatedCart = cartRepository.findById(cart.getId()).orElseThrow();
        // Disconnect from session so that the updates on updatedCart are not directly saved in db
        em.detach(updatedCart);
        updatedCart.cartKey(UPDATED_CART_KEY).createdAt(UPDATED_CREATED_AT).isCheckedOut(UPDATED_IS_CHECKED_OUT);

        restCartMockMvc
            .perform(
                put(ENTITY_API_URL_ID, updatedCart.getId())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(updatedCart))
            )
            .andExpect(status().isOk());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertPersistedCartToMatchAllProperties(updatedCart);
    }

    @Test
    @Transactional
    void putNonExistingCart() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        cart.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restCartMockMvc
            .perform(put(ENTITY_API_URL_ID, cart.getId()).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(cart)))
            .andExpect(status().isBadRequest());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithIdMismatchCart() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        cart.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restCartMockMvc
            .perform(
                put(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType(MediaType.APPLICATION_JSON)
                    .content(om.writeValueAsBytes(cart))
            )
            .andExpect(status().isBadRequest());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void putWithMissingIdPathParamCart() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        cart.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restCartMockMvc
            .perform(put(ENTITY_API_URL).contentType(MediaType.APPLICATION_JSON).content(om.writeValueAsBytes(cart)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void partialUpdateCartWithPatch() throws Exception {
        // Initialize the database
        insertedCart = cartRepository.saveAndFlush(cart);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the cart using partial update
        Cart partialUpdatedCart = new Cart();
        partialUpdatedCart.setId(cart.getId());

        partialUpdatedCart.isCheckedOut(UPDATED_IS_CHECKED_OUT);

        restCartMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedCart.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedCart))
            )
            .andExpect(status().isOk());

        // Validate the Cart in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertCartUpdatableFieldsEquals(createUpdateProxyForBean(partialUpdatedCart, cart), getPersistedCart(cart));
    }

    @Test
    @Transactional
    void fullUpdateCartWithPatch() throws Exception {
        // Initialize the database
        insertedCart = cartRepository.saveAndFlush(cart);

        long databaseSizeBeforeUpdate = getRepositoryCount();

        // Update the cart using partial update
        Cart partialUpdatedCart = new Cart();
        partialUpdatedCart.setId(cart.getId());

        partialUpdatedCart.cartKey(UPDATED_CART_KEY).createdAt(UPDATED_CREATED_AT).isCheckedOut(UPDATED_IS_CHECKED_OUT);

        restCartMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, partialUpdatedCart.getId())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(partialUpdatedCart))
            )
            .andExpect(status().isOk());

        // Validate the Cart in the database

        assertSameRepositoryCount(databaseSizeBeforeUpdate);
        assertCartUpdatableFieldsEquals(partialUpdatedCart, getPersistedCart(partialUpdatedCart));
    }

    @Test
    @Transactional
    void patchNonExistingCart() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        cart.setId(longCount.incrementAndGet());

        // If the entity doesn't have an ID, it will throw BadRequestAlertException
        restCartMockMvc
            .perform(patch(ENTITY_API_URL_ID, cart.getId()).contentType("application/merge-patch+json").content(om.writeValueAsBytes(cart)))
            .andExpect(status().isBadRequest());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithIdMismatchCart() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        cart.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restCartMockMvc
            .perform(
                patch(ENTITY_API_URL_ID, longCount.incrementAndGet())
                    .contentType("application/merge-patch+json")
                    .content(om.writeValueAsBytes(cart))
            )
            .andExpect(status().isBadRequest());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void patchWithMissingIdPathParamCart() throws Exception {
        long databaseSizeBeforeUpdate = getRepositoryCount();
        cart.setId(longCount.incrementAndGet());

        // If url ID doesn't match entity ID, it will throw BadRequestAlertException
        restCartMockMvc
            .perform(patch(ENTITY_API_URL).contentType("application/merge-patch+json").content(om.writeValueAsBytes(cart)))
            .andExpect(status().isMethodNotAllowed());

        // Validate the Cart in the database
        assertSameRepositoryCount(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    void deleteCart() throws Exception {
        // Initialize the database
        insertedCart = cartRepository.saveAndFlush(cart);

        long databaseSizeBeforeDelete = getRepositoryCount();

        // Delete the cart
        restCartMockMvc
            .perform(delete(ENTITY_API_URL_ID, cart.getId()).accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isNoContent());

        // Validate the database contains one less item
        assertDecrementedRepositoryCount(databaseSizeBeforeDelete);
    }

    protected long getRepositoryCount() {
        return cartRepository.count();
    }

    protected void assertIncrementedRepositoryCount(long countBefore) {
        assertThat(countBefore + 1).isEqualTo(getRepositoryCount());
    }

    protected void assertDecrementedRepositoryCount(long countBefore) {
        assertThat(countBefore - 1).isEqualTo(getRepositoryCount());
    }

    protected void assertSameRepositoryCount(long countBefore) {
        assertThat(countBefore).isEqualTo(getRepositoryCount());
    }

    protected Cart getPersistedCart(Cart cart) {
        return cartRepository.findById(cart.getId()).orElseThrow();
    }

    protected void assertPersistedCartToMatchAllProperties(Cart expectedCart) {
        assertCartAllPropertiesEquals(expectedCart, getPersistedCart(expectedCart));
    }

    protected void assertPersistedCartToMatchUpdatableProperties(Cart expectedCart) {
        assertCartAllUpdatablePropertiesEquals(expectedCart, getPersistedCart(expectedCart));
    }
}
