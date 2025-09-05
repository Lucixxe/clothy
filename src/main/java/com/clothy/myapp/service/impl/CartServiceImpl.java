package com.clothy.myapp.service.impl;

import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.repository.CartRepository;
import com.clothy.myapp.service.CartService;
import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.clothy.myapp.domain.Cart}.
 */
@Service
@Transactional
public class CartServiceImpl implements CartService {

    private static final Logger LOG = LoggerFactory.getLogger(CartServiceImpl.class);

    private final CartRepository cartRepository;

    public CartServiceImpl(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
    }

    @Override
    public Cart save(Cart cart) {
        LOG.debug("Request to save Cart : {}", cart);
        return cartRepository.save(cart);
    }

    @Override
    public Cart update(Cart cart) {
        LOG.debug("Request to update Cart : {}", cart);
        return cartRepository.save(cart);
    }

    @Override
    public Optional<Cart> partialUpdate(Cart cart) {
        LOG.debug("Request to partially update Cart : {}", cart);

        return cartRepository
            .findById(cart.getId())
            .map(existingCart -> {
                if (cart.getCartKey() != null) {
                    existingCart.setCartKey(cart.getCartKey());
                }
                if (cart.getCreatedAt() != null) {
                    existingCart.setCreatedAt(cart.getCreatedAt());
                }
                if (cart.getIsCheckedOut() != null) {
                    existingCart.setIsCheckedOut(cart.getIsCheckedOut());
                }

                return existingCart;
            })
            .map(cartRepository::save);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Cart> findAll() {
        LOG.debug("Request to get all Carts");
        return cartRepository.findAll();
    }

    public Page<Cart> findAllWithEagerRelationships(Pageable pageable) {
        return cartRepository.findAllWithEagerRelationships(pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Cart> findOne(Long id) {
        LOG.debug("Request to get Cart : {}", id);
        return cartRepository.findOneWithEagerRelationships(id);
    }

    @Override
    public void delete(Long id) {
        LOG.debug("Request to delete Cart : {}", id);
        cartRepository.deleteById(id);
    }
}
