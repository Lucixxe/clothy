package com.clothy.myapp.service.mapper;

import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.domain.Product;
import com.clothy.myapp.service.dto.CartItemDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CartItemMapper {
    @Mapping(source = "product.id", target = "productId")
    @Mapping(source = "cart.id", target = "cartId")
    @Mapping(source = "customerOrder.id", target = "customerOrderId")
    CartItemDTO toDto(CartItem cartItem);

    // convenience method
    default CartItem fromId(Long id) {
        if (id == null) return null;
        CartItem cartItem = new CartItem();
        cartItem.setId(id);
        return cartItem;
    }
}
