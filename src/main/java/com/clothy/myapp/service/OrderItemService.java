package com.clothy.myapp.service;

import com.clothy.myapp.domain.OrderItem;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.clothy.myapp.domain.OrderItem}.
 */
public interface OrderItemService {
    /**
     * Save a orderItem.
     *
     * @param orderItem the entity to save.
     * @return the persisted entity.
     */
    OrderItem save(OrderItem orderItem);

    /**
     * Updates a orderItem.
     *
     * @param orderItem the entity to update.
     * @return the persisted entity.
     */
    OrderItem update(OrderItem orderItem);

    /**
     * Partially updates a orderItem.
     *
     * @param orderItem the entity to update partially.
     * @return the persisted entity.
     */
    Optional<OrderItem> partialUpdate(OrderItem orderItem);

    /**
     * Get all the orderItems.
     *
     * @return the list of entities.
     */
    List<OrderItem> findAll();

    /**
     * Get all the orderItems with eager load of many-to-many relationships.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<OrderItem> findAllWithEagerRelationships(Pageable pageable);

    /**
     * Get the "id" orderItem.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<OrderItem> findOne(Long id);

    /**
     * Delete the "id" orderItem.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
