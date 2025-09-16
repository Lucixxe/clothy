package com.clothy.myapp.service;

import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.service.dto.CartItemDTO;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.clothy.myapp.domain.CartItem}.
 */
public interface CartItemService {
    /**
     * Save a cartItem.
     *
     * @param cartItem the entity to save.
     * @return the persisted entity.
     */
    CartItem save(CartItem cartItem);

    /**
     * Updates a cartItem.
     *
     * @param cartItem the entity to update.
     * @return the persisted entity.
     */
    CartItem update(CartItem cartItem);

    /**
     * Partially updates a cartItem.
     *
     * @param cartItem the entity to update partially.
     * @return the persisted entity.
     */
    Optional<CartItem> partialUpdate(CartItem cartItem);

    /**
     * Get all the cartItems.
     *
     * @return the list of entities.
     */
    List<CartItem> findAll();

    /**
     * Get all the cartItems with eager load of many-to-many relationships.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<CartItem> findAllWithEagerRelationships(Pageable pageable);

    /**
     * Get the "id" cartItem.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<CartItem> findOne(Long id);

    /**
     * Delete the "id" cartItem.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);

    List<CartItem> findAllByCartId(Long cartId);

    CartItemDTO ajoutPanier(Cart cart, Long productId, Integer quantity);

    public List<CartItem> findAllForCartItem(Long cartId);

    void deleteAllByCartId(Long cartId);

    public List<CartItem> findAllForCartItemNotInOrder(Long cartId);
}
