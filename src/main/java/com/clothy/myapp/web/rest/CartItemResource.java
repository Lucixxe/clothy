package com.clothy.myapp.web.rest;

import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.domain.Customer;
import com.clothy.myapp.domain.User;
import com.clothy.myapp.repository.CartItemRepository;
import com.clothy.myapp.repository.CartRepository;
import com.clothy.myapp.repository.CustomerRepository;
import com.clothy.myapp.repository.UserRepository;
import com.clothy.myapp.security.SecurityUtils;
import com.clothy.myapp.service.CartItemService;
import com.clothy.myapp.service.dto.CartItemDTO;
import com.clothy.myapp.service.mapper.CartItemMapper;
import com.clothy.myapp.web.rest.errors.BadRequestAlertException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.clothy.myapp.domain.CartItem}.
 */
@RestController
@RequestMapping("/api/cart-items")
public class CartItemResource {

    private static final Logger LOG = LoggerFactory.getLogger(CartItemResource.class);

    private static final String ENTITY_NAME = "cartItem";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final CartItemService cartItemService;

    private final CartItemRepository cartItemRepository;

    private final UserRepository userRepository;

    private final CustomerRepository customerRepository;

    private final CartRepository cartRepository;

    private final CartItemMapper cartItemMapper;

    public CartItemResource(
        CartItemService cartItemService,
        CartItemRepository cartItemRepository,
        UserRepository usrRepo,
        CustomerRepository custRepo,
        CartRepository crtRepo,
        CartItemMapper crtMapper
    ) {
        this.cartItemService = cartItemService;
        this.cartItemRepository = cartItemRepository;
        this.userRepository = usrRepo;
        this.customerRepository = custRepo;
        this.cartRepository = crtRepo;
        this.cartItemMapper = crtMapper;
    }

    /**
     * {@code POST  /cart-items} : Create a new cartItem.
     *
     * @param cartItem the cartItem to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new cartItem, or with status {@code 400 (Bad Request)} if the cartItem has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<CartItem> createCartItem(@Valid @RequestBody CartItem cartItem) throws URISyntaxException {
        LOG.debug("REST request to save CartItem : {}", cartItem);
        if (cartItem.getId() != null) {
            throw new BadRequestAlertException("A new cartItem cannot already have an ID", ENTITY_NAME, "idexists");
        }
        cartItem = cartItemService.save(cartItem);
        return ResponseEntity.created(new URI("/api/cart-items/" + cartItem.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, cartItem.getId().toString()))
            .body(cartItem);
    }

    @GetMapping("/by-cart/{id}")
    public List<CartItem> getAllCartItemsForCartId(@PathVariable("id") Long cartId) {
        return cartItemService.findAllForCartItem(cartId);
    }

    @PostMapping("/creation-cartItem")
    public ResponseEntity<CartItemDTO> ajoutPanier(@RequestBody CartItemDTO cartItemDTO) {
        String login = SecurityUtils.getCurrentUserLogin().orElseThrow();
        User user = userRepository.findOneByLogin(login).orElseThrow();
        Customer customer = customerRepository.findOneByUser(user).orElseThrow();

        Cart cart = cartRepository.findByCustomer(customer).orElseThrow();

        CartItemDTO cartDTO = cartItemService.ajoutPanier(cart, cartItemDTO.getProductId(), cartItemDTO.getQuantity());
        return ResponseEntity.ok(cartDTO);
    }

    /**
     * {@code PUT  /cart-items/:id} : Updates an existing cartItem.
     *
     * @param id the id of the cartItem to save.
     * @param cartItem the cartItem to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated cartItem,
     * or with status {@code 400 (Bad Request)} if the cartItem is not valid,
     * or with status {@code 500 (Internal Server Error)} if the cartItem couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<CartItem> updateCartItem(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody CartItem cartItem
    ) throws URISyntaxException {
        LOG.debug("REST request to update CartItem : {}, {}", id, cartItem);
        if (cartItem.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, cartItem.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!cartItemRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        cartItem = cartItemService.update(cartItem);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, cartItem.getId().toString()))
            .body(cartItem);
    }

    /**
     * {@code PATCH  /cart-items/:id} : Partial updates given fields of an existing cartItem, field will ignore if it is null
     *
     * @param id the id of the cartItem to save.
     * @param cartItem the cartItem to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated cartItem,
     * or with status {@code 400 (Bad Request)} if the cartItem is not valid,
     * or with status {@code 404 (Not Found)} if the cartItem is not found,
     * or with status {@code 500 (Internal Server Error)} if the cartItem couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<CartItem> partialUpdateCartItem(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody CartItem cartItem
    ) throws URISyntaxException {
        LOG.debug("REST request to partial update CartItem partially : {}, {}", id, cartItem);
        if (cartItem.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, cartItem.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!cartItemRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<CartItem> result = cartItemService.partialUpdate(cartItem);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, cartItem.getId().toString())
        );
    }

    /**
     * {@code GET  /cart-items} : get all the cartItems.
     *
     * @param eagerload flag to eager load entities from relationships (This is applicable for many-to-many).
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of cartItems in body.
     */
    @GetMapping("")
    public List<CartItem> getAllCartItems(@RequestParam(name = "eagerload", required = false, defaultValue = "true") boolean eagerload) {
        LOG.debug("REST request to get all CartItems");
        return cartItemService.findAll();
    }

    /**
     * {@code GET  /cart-items/:id} : get the "id" cartItem.
     *
     * @param id the id of the cartItem to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the cartItem, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<CartItem> getCartItem(@PathVariable("id") Long id) {
        LOG.debug("REST request to get CartItem : {}", id);
        Optional<CartItem> cartItem = cartItemService.findOne(id);
        return ResponseUtil.wrapOrNotFound(cartItem);
    }

    /**
     * {@code DELETE  /cart-items/:id} : delete the "id" cartItem.
     *
     * @param id the id of the cartItem to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCartItem(@PathVariable("id") Long id) {
        LOG.debug("REST request to delete CartItem : {}", id);
        cartItemService.delete(id);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }

    @GetMapping("/cart-items/by-cart/{cartId}")
    public List<CartItem> getCartItemsByCartId(@PathVariable Long cartId) {
        return cartItemService.findAllByCartId(cartId);
    }

    @DeleteMapping("/cart-items/empty-cart/{id}")
    public ResponseEntity<Void> emptyCart(@PathVariable Long cartId) {
        LOG.debug("REST request to delete cartItem : {" + cartId + "}");
        cartItemService.deleteAllByCartId(cartId);
        return ResponseEntity.noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, cartId.toString()))
            .build();
    }
}
