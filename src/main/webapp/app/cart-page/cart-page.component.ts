import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink, Router } from '@angular/router';

import { CartService, CartItem } from '../entities/cart/service/cart.service';
import { AccountService } from 'app/core/auth/account.service';
import { ProductService } from 'app/entities/product/service/product.service';
import { ICartItem } from '../entities/cart-item/cart-item.model';
import { IProduct } from 'app/entities/product/product.model';

@Component({
  selector: 'app-cart-page',
  templateUrl: './cart-page.component.html',
  imports: [CommonModule, RouterLink],
  standalone: true,
})
export class CartPageComponent implements OnInit {
  // Pour les utilisateurs non connectés
  items: CartItem[] = [];

  // Pour les utilisateurs connectés
  itemsICart: ICartItem[] = [];

  total = 0;

  private accountService = inject(AccountService);
  private router = inject(Router);
  private productService = inject(ProductService);

  constructor(private cartService: CartService) {}

  ngOnInit(): void {
    this.loadCart();
  }

  loadCart(): void {
    if (!this.accountService.isAuthenticated()) {
      this.items = this.cartService.getItems();
      this.total = this.items.reduce((sum, item) => sum + item.price * item.quantity, 0);
    } else {
      this.cartService.getCurrentUserCartId().subscribe({
        next: cartId => {
          if (!cartId) {
            this.itemsICart = [];
            this.total = 0;
            return;
          }

          this.cartService.getCartItemsByCartId(cartId).subscribe({
            next: cartItems => {
              if (!cartItems || cartItems.length === 0) {
                this.itemsICart = [];
                this.total = 0;
                return;
              }

              // On utilise directement product de cartItem
              this.itemsICart = cartItems.map(item => ({
                ...item,
                unitPrice: item.price ?? 0,
                lineTotal: (item.price ?? 0) * (item.quantity ?? 1),
              }));
              this.updateTotalICart();
            },
            error: () => {
              this.itemsICart = [];
              this.total = 0;
            },
          });
        },
        error: () => {
          this.itemsICart = [];
          this.total = 0;
        },
      });
    }
  }

  private updateTotalICart(): void {
    this.total = this.itemsICart.reduce((sum, item) => sum + (item.lineTotal ?? 0), 0);
  }

  // Actions sur le panier
  remove(id: number): void {
    if (!this.accountService.isAuthenticated()) {
      this.items = this.items.filter(item => item.id !== id);
      this.cartService.updateItems(this.items);
    } else {
      this.itemsICart = this.itemsICart.filter(item => item.id !== id);
    }
    this.updateTotalICart();
  }

  clear(): void {
    if (!this.accountService.isAuthenticated()) {
      this.items = [];
      this.cartService.updateItems([]);
    } else {
      this.itemsICart = [];
    }
    this.total = 0;
  }

  goToPayment(): void {
    if (this.accountService.isAuthenticated()) {
      this.router.navigate(['/payement']);
    } else {
      alert('Vous devez être connecté pour passer au paiement.');
      this.router.navigate(['/login']);
    }
  }

  increaseQty(item: CartItem | ICartItem): void {
    if ('quantity' in item && item.quantity) item.quantity++;
    if ('lineTotal' in item && 'unitPrice' in item) {
      item.lineTotal = (item.unitPrice ?? 0) * (item.quantity ?? 1);
    }
    if (!this.accountService.isAuthenticated()) {
      this.cartService.updateItems(this.items);
    }
    this.updateTotalICart();
  }

  decreaseQty(item: CartItem | ICartItem): void {
    if ('quantity' in item && item.quantity && item.quantity > 1) item.quantity--;
    if ('lineTotal' in item && 'unitPrice' in item) {
      item.lineTotal = (item.unitPrice ?? 0) * (item.quantity ?? 1);
    }
    if (!this.accountService.isAuthenticated()) {
      this.cartService.updateItems(this.items);
    }
    this.updateTotalICart();
  }
}
