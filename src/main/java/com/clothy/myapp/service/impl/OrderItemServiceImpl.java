package com.clothy.myapp.service.impl;

import com.clothy.myapp.domain.OrderItem;
import com.clothy.myapp.repository.OrderItemRepository;
import com.clothy.myapp.service.OrderItemService;
import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.clothy.myapp.domain.OrderItem}.
 */
@Service
@Transactional
public class OrderItemServiceImpl implements OrderItemService {

    private static final Logger LOG = LoggerFactory.getLogger(OrderItemServiceImpl.class);

    private final OrderItemRepository orderItemRepository;

    public OrderItemServiceImpl(OrderItemRepository orderItemRepository) {
        this.orderItemRepository = orderItemRepository;
    }

    @Override
    public OrderItem save(OrderItem orderItem) {
        LOG.debug("Request to save OrderItem : {}", orderItem);
        return orderItemRepository.save(orderItem);
    }

    @Override
    public OrderItem update(OrderItem orderItem) {
        LOG.debug("Request to update OrderItem : {}", orderItem);
        return orderItemRepository.save(orderItem);
    }

    @Override
    public Optional<OrderItem> partialUpdate(OrderItem orderItem) {
        LOG.debug("Request to partially update OrderItem : {}", orderItem);

        return orderItemRepository
            .findById(orderItem.getId())
            .map(existingOrderItem -> {
                if (orderItem.getQuantity() != null) {
                    existingOrderItem.setQuantity(orderItem.getQuantity());
                }
                if (orderItem.getUnitPrice() != null) {
                    existingOrderItem.setUnitPrice(orderItem.getUnitPrice());
                }
                if (orderItem.getLineTotal() != null) {
                    existingOrderItem.setLineTotal(orderItem.getLineTotal());
                }

                return existingOrderItem;
            })
            .map(orderItemRepository::save);
    }

    @Override
    @Transactional(readOnly = true)
    public List<OrderItem> findAll() {
        LOG.debug("Request to get all OrderItems");
        return orderItemRepository.findAll();
    }

    public Page<OrderItem> findAllWithEagerRelationships(Pageable pageable) {
        return orderItemRepository.findAllWithEagerRelationships(pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<OrderItem> findOne(Long id) {
        LOG.debug("Request to get OrderItem : {}", id);
        return orderItemRepository.findOneWithEagerRelationships(id);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete OrderItem : {}", id);
        orderItemRepository.deleteById(id);
    }
}
