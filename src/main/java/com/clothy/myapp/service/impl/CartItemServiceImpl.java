package com.clothy.myapp.service.impl;

import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.repository.CartItemRepository;
import com.clothy.myapp.service.CartItemService;
import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.clothy.myapp.domain.CartItem}.
 */
@Service
@Transactional
public class CartItemServiceImpl implements CartItemService {

    private static final Logger LOG = LoggerFactory.getLogger(CartItemServiceImpl.class);

    private final CartItemRepository cartItemRepository;

    public CartItemServiceImpl(CartItemRepository cartItemRepository) {
        this.cartItemRepository = cartItemRepository;
    }

    @Override
    public CartItem save(CartItem cartItem) {
        LOG.debug("Request to save CartItem : {}", cartItem);
        return cartItemRepository.save(cartItem);
    }

    @Override
    public CartItem update(CartItem cartItem) {
        LOG.debug("Request to update CartItem : {}", cartItem);
        return cartItemRepository.save(cartItem);
    }

    @Override
    public Optional<CartItem> partialUpdate(CartItem cartItem) {
        LOG.debug("Request to partially update CartItem : {}", cartItem);

        return cartItemRepository
            .findById(cartItem.getId())
            .map(existingCartItem -> {
                if (cartItem.getQuantity() != null) {
                    existingCartItem.setQuantity(cartItem.getQuantity());
                }
                if (cartItem.getUnitPrice() != null) {
                    existingCartItem.setUnitPrice(cartItem.getUnitPrice());
                }
                if (cartItem.getLineTotal() != null) {
                    existingCartItem.setLineTotal(cartItem.getLineTotal());
                }
                if (cartItem.getIsInOrder() != null) {
                    existingCartItem.setIsInOrder(cartItem.getIsInOrder());
                }

                return existingCartItem;
            })
            .map(cartItemRepository::save);
    }

    @Override
    @Transactional(readOnly = true)
    public List<CartItem> findAll() {
        LOG.debug("Request to get all CartItems");
        return cartItemRepository.findAll();
    }

    public Page<CartItem> findAllWithEagerRelationships(Pageable pageable) {
        return cartItemRepository.findAllWithEagerRelationships(pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<CartItem> findOne(Long id) {
        LOG.debug("Request to get CartItem : {}", id);
        return cartItemRepository.findOneWithEagerRelationships(id);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete CartItem : {}", id);
        cartItemRepository.deleteById(id);
    }
}
