package com.clothy.myapp.service;

import com.clothy.myapp.domain.Cart;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.clothy.myapp.domain.Cart}.
 */
public interface CartService {
    /**
     * Save a cart.
     *
     * @param cart the entity to save.
     * @return the persisted entity.
     */
    Cart save(Cart cart);

    /**
     * Updates a cart.
     *
     * @param cart the entity to update.
     * @return the persisted entity.
     */
    Cart update(Cart cart);

    /**
     * Partially updates a cart.
     *
     * @param cart the entity to update partially.
     * @return the persisted entity.
     */
    Optional<Cart> partialUpdate(Cart cart);

    /**
     * Get all the carts.
     *
     * @return the list of entities.
     */
    List<Cart> findAll();

    /**
     * Get all the carts with eager load of many-to-many relationships.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<Cart> findAllWithEagerRelationships(Pageable pageable);

    /**
     * Get the "id" cart.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<Cart> findOne(Long id);

    /**
     * Delete the "id" cart.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
