package com.clothy.myapp.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.domain.Product;
import com.clothy.myapp.repository.CartItemRepository;
import com.clothy.myapp.repository.CartRepository;
import com.clothy.myapp.repository.ProductRepository;
import com.clothy.myapp.service.dto.CartItemDTO;
import com.clothy.myapp.web.rest.CartResource;
import java.math.BigDecimal;
import java.util.Optional;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(MockitoExtension.class)
public class CartItemServiceIT {

    @Mock
    private CartRepository cartRepository;

    @Mock
    private CartItemRepository cartItemRepository;

    @Mock
    private ProductRepository productRepository;

    @InjectMocks
    private CartItemService cartItemService;

    @Test
    public void addToCart() {
        Product product = new Product();
        product.setId(1L);
        product.setSku(5);
        product.setPrice(BigDecimal.valueOf(250.000));

        Cart cart = new Cart();
        cart.setId(100L);
        cart.setIsCheckedOut(false);

        CartItem CartItem;
        CartItemDTO cartItemDTO = cartItemService.ajoutPanier(cart, product.getId(), 2);

        verify(cartItemRepository).save(any(CartItem.class));
    }

    @Test
    public void incrementQuantityWhenExists() {
        Product product = new Product();
        product.setId(1L);
        product.setSku(5);
        product.setPrice(BigDecimal.valueOf(250.000));
        Cart cart = new Cart();
        cart.setId(100L);
        cart.setIsCheckedOut(false);
        CartItem CartItem = new CartItem();
        CartItem.setProduct(product);
        CartItem.setCart(cart);
        CartItem.setQuantity(2);
        when(cartItemRepository.findByCartAndProduct(cart, product)).thenReturn(Optional.of(CartItem));
        when(cartItemRepository.save(any(CartItem.class))).thenAnswer(inv -> inv.getArgument(0));
        CartItemDTO cartItemDTO = cartItemService.ajoutPanier(cart, product.getId(), 2);
        assertEquals(4, cartItemDTO.getQuantity());
    }
}
