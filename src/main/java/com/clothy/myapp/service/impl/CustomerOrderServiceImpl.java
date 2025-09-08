package com.clothy.myapp.service.impl;

import com.clothy.myapp.domain.CustomerOrder;
import com.clothy.myapp.repository.CustomerOrderRepository;
import com.clothy.myapp.service.CustomerOrderService;
import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.clothy.myapp.domain.CustomerOrder}.
 */
@Service
@Transactional
public class CustomerOrderServiceImpl implements CustomerOrderService {

    private static final Logger LOG = LoggerFactory.getLogger(CustomerOrderServiceImpl.class);

    private final CustomerOrderRepository customerOrderRepository;

    public CustomerOrderServiceImpl(CustomerOrderRepository customerOrderRepository) {
        this.customerOrderRepository = customerOrderRepository;
    }

    @Override
    public CustomerOrder save(CustomerOrder customerOrder) {
        LOG.debug("Request to save CustomerOrder : {}", customerOrder);
        return customerOrderRepository.save(customerOrder);
    }

    @Override
    public CustomerOrder update(CustomerOrder customerOrder) {
        LOG.debug("Request to update CustomerOrder : {}", customerOrder);
        return customerOrderRepository.save(customerOrder);
    }

    @Override
    public Optional<CustomerOrder> partialUpdate(CustomerOrder customerOrder) {
        LOG.debug("Request to partially update CustomerOrder : {}", customerOrder);

        return customerOrderRepository
            .findById(customerOrder.getId())
            .map(existingCustomerOrder -> {
                if (customerOrder.getOrderNumber() != null) {
                    existingCustomerOrder.setOrderNumber(customerOrder.getOrderNumber());
                }
                if (customerOrder.getCreatedAt() != null) {
                    existingCustomerOrder.setCreatedAt(customerOrder.getCreatedAt());
                }
                if (customerOrder.getTotal() != null) {
                    existingCustomerOrder.setTotal(customerOrder.getTotal());
                }

                return existingCustomerOrder;
            })
            .map(customerOrderRepository::save);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CustomerOrder> findAll() {
        LOG.debug("Request to get all CustomerOrders");
        return customerOrderRepository.findAll();
    }

    public Page<CustomerOrder> findAllWithEagerRelationships(Pageable pageable) {
        return customerOrderRepository.findAllWithEagerRelationships(pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<CustomerOrder> findOne(Long id) {
        LOG.debug("Request to get CustomerOrder : {}", id);
        return customerOrderRepository.findOneWithEagerRelationships(id);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete CustomerOrder : {}", id);
        customerOrderRepository.deleteById(id);
    }
}
