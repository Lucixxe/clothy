package com.clothy.myapp.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.time.Instant;
import java.util.UUID;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A Cart.
 */
@Entity
@Table(name = "cart")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class Cart implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "cart_key", nullable = false, unique = true)
    private UUID cartKey;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @NotNull
    @Column(name = "is_checked_out", nullable = false)
    private Boolean isCheckedOut;

    @JsonIgnoreProperties(value = { "user", "cart" }, allowSetters = true)
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @NotNull
    @JoinColumn(unique = true)
    private Customer customer;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public Cart id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public UUID getCartKey() {
        return this.cartKey;
    }

    public Cart cartKey(UUID cartKey) {
        this.setCartKey(cartKey);
        return this;
    }

    public void setCartKey(UUID cartKey) {
        this.cartKey = cartKey;
    }

    public Instant getCreatedAt() {
        return this.createdAt;
    }

    public Cart createdAt(Instant createdAt) {
        this.setCreatedAt(createdAt);
        return this;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public Boolean getIsCheckedOut() {
        return this.isCheckedOut;
    }

    public Cart isCheckedOut(Boolean isCheckedOut) {
        this.setIsCheckedOut(isCheckedOut);
        return this;
    }

    public void setIsCheckedOut(Boolean isCheckedOut) {
        this.isCheckedOut = isCheckedOut;
    }

    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Cart customer(Customer customer) {
        this.setCustomer(customer);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Cart)) {
            return false;
        }
        return getId() != null && getId().equals(((Cart) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "Cart{" +
            "id=" + getId() +
            ", cartKey='" + getCartKey() + "'" +
            ", createdAt='" + getCreatedAt() + "'" +
            ", isCheckedOut='" + getIsCheckedOut() + "'" +
            "}";
    }
}
