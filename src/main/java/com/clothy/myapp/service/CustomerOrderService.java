package com.clothy.myapp.service;

import com.clothy.myapp.domain.CustomerOrder;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service Interface for managing {@link com.clothy.myapp.domain.CustomerOrder}.
 */
public interface CustomerOrderService {
    /**
     * Save a customerOrder.
     *
     * @param customerOrder the entity to save.
     * @return the persisted entity.
     */
    CustomerOrder save(CustomerOrder customerOrder);

    /**
     * Updates a customerOrder.
     *
     * @param customerOrder the entity to update.
     * @return the persisted entity.
     */
    CustomerOrder update(CustomerOrder customerOrder);

    /**
     * Partially updates a customerOrder.
     *
     * @param customerOrder the entity to update partially.
     * @return the persisted entity.
     */
    Optional<CustomerOrder> partialUpdate(CustomerOrder customerOrder);

    /**
     * Get all the customerOrders.
     *
     * @return the list of entities.
     */
    List<CustomerOrder> findAll();

    /**
     * Get all the customerOrders with eager load of many-to-many relationships.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<CustomerOrder> findAllWithEagerRelationships(Pageable pageable);

    /**
     * Get the "id" customerOrder.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<CustomerOrder> findOne(Long id);

    /**
     * Delete the "id" customerOrder.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);
}
