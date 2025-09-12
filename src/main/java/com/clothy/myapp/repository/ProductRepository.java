package com.clothy.myapp.repository;

import com.clothy.myapp.domain.Product;
import jakarta.persistence.LockModeType;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * Spring Data JPA repository for the Product entity.
 *
 * When extending this class, extend ProductRepositoryWithBagRelationships too.
 * For more information refer to https://github.com/jhipster/generator-jhipster/issues/17990.
 */
@Repository
public interface ProductRepository extends ProductRepositoryWithBagRelationships, JpaRepository<Product, Long> {
    default Optional<Product> findOneWithEagerRelationships(Long id) {
        return this.fetchBagRelationships(this.findById(id));
    }

    default List<Product> findAllWithEagerRelationships() {
        return this.fetchBagRelationships(this.findAll());
    }

    default Page<Product> findAllWithEagerRelationships(Pageable pageable) {
        return this.fetchBagRelationships(this.findAll(pageable));
    }

    @Modifying
    @Query("UPDATE Product p SET p.sku = p.sku - :quantity WHERE p.id = :productId AND p.sku >= :quantity")
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    int decrementStockAtomic(@Param("productId") Long productId, @Param("quantity") Integer quantity);

    @Modifying
    @Query("UPDATE Product p SET p.sku = p.sku + :quantity WHERE p.id = :productId")
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    int incrementStockAtomic(@Param("productId") Long productId, @Param("quantity") Integer quantity);

    @Query("SELECT p FROM Product p WHERE p.id IN :productIds ORDER BY p.id ASC")
    @Lock(LockModeType.PESSIMISTIC_WRITE)
    List<Product> findAndLockProductsByIdsOrderedById(@Param("productIds") List<Long> productIds);
}
/*
 * TRIER DONNESS POUR EVITER DEADLOCK
 */
/*
  * FONCTIONNALITES
  * ARCHI, MODELE DE DONNEES
  * CHOIX DE TECHNO (JUSTIFICATIONS)
  BILAN DU PROJET
  QUESTCE QUE VS AVZ APPRIS
  ((5PAGES))
  */
