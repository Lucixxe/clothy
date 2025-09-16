package com.clothy.myapp.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
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
import com.clothy.myapp.service.impl.CartItemServiceImpl;
import java.util.Optional;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class CartItemServiceTest {

    @Mock
    private CartItemRepository cartItemRepository;

    @Mock
    private CartRepository cartRepository;

    @Mock
    private ProductRepository productRepository;

    @InjectMocks
    private CartItemServiceImpl cartItemServiceImpl;

    @Test
    public void testAddToCartwhenexists() {
        Product product = new Product();
        product.setId(5L);
        product.setSku(5);
        product.setPrice(new java.math.BigDecimal(150));
        Integer quantity = 2;

        Cart cart = new Cart();
        cart.setId(100L);
        cart.setIsCheckedOut(false);
        CartItem cartItem = new CartItem();
        cartItem.setQuantity(quantity);
        cartItem.setIsInOrder(false);

        when(productRepository.findById(5L)).thenReturn(Optional.of(product));
        when(cartItemRepository.findByCartAndProduct(cart, product)).thenReturn(Optional.of(cartItem));
        when(cartItemRepository.save(any(CartItem.class))).thenReturn(cartItem);

        CartItemDTO dto = cartItemServiceImpl.ajoutPanier(cart, product.getId(), quantity);

        assertEquals(4, cartItem.getQuantity());
        assertEquals(product.getId(), dto.getProductId());
    }

    @Test
    public void testNewItemInCart() {
        Product product = new Product();
        product.setId(5L);
        product.setSku(5);
        product.setPrice(new java.math.BigDecimal(150));
        Integer quantity = 2;

        Cart cart = new Cart();
        cart.setId(100L);
        cart.setIsCheckedOut(false);
        CartItem cartItem = new CartItem();
        cartItem.setQuantity(quantity);

        when(productRepository.findById(5L)).thenReturn(Optional.of(product));
        when(cartItemRepository.findByCartAndProduct(cart, product)).thenReturn(Optional.empty());
        when(cartItemRepository.save(any(CartItem.class))).thenAnswer(inv -> {
            CartItem item = inv.getArgument(0);
            cartItem.setCart(item.getCart());
            cartItem.setProduct(item.getProduct());
            return item;
        });

        CartItemDTO dto = cartItemServiceImpl.ajoutPanier(cart, product.getId(), quantity);

        assertEquals(2, cartItem.getQuantity());
        assertEquals(product.getId(), dto.getProductId());
        assertEquals(cartItem.getProduct(), product);
    }
}
