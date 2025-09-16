package com.clothy.myapp.repository;

import com.clothy.myapp.domain.Cart;
import com.clothy.myapp.domain.CartItem;
import com.clothy.myapp.domain.Product;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the CartItem entity.
 */
@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    default Optional<CartItem> findOneWithEagerRelationships(Long id) {
        return this.findOneWithToOneRelationships(id);
    }

    default List<CartItem> findAllWithEagerRelationships() {
        return this.findAllWithToOneRelationships();
    }

    default Page<CartItem> findAllWithEagerRelationships(Pageable pageable) {
        return this.findAllWithToOneRelationships(pageable);
    }

    @Query(
        value = "select cartItem from CartItem cartItem left join fetch cartItem.product left join fetch cartItem.customerOrder",
        countQuery = "select count(cartItem) from CartItem cartItem"
    )
    Page<CartItem> findAllWithToOneRelationships(Pageable pageable);

    @Query("select cartItem from CartItem cartItem left join fetch cartItem.product left join fetch cartItem.customerOrder")
    List<CartItem> findAllWithToOneRelationships();

    @Query(
        "select cartItem from CartItem cartItem left join fetch cartItem.product left join fetch cartItem.customerOrder where cartItem.id =:id"
    )
    Optional<CartItem> findOneWithToOneRelationships(@Param("id") Long id);

    //List<CartItem> findByCart_Id(Long cartId);

    @Query("select ci from CartItem ci where ci.cart.id = :cartId ")
    List<CartItem> findAllByCartId(@Param("cartId") Long cartId);

    Optional<CartItem> findByCartAndProduct(Cart cart, Product product);

    @Query("select c from CartItem c where c.cart.id =:id")
    List<CartItem> getAllCartItemsForCart(@Param("id") Long cartId);

    @Query("select c from CartItem c where c.cart.id =:id and c.isInOrder = false")
    List<CartItem> getAllCartItemsForCartNotInOrder(@Param("id") Long cartId);
}
