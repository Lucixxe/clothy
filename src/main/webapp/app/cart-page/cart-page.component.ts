import { Component, OnInit, inject } from '@angular/core';
import { CartService, CartItem } from '../entities/cart/service/cart.service';
import { CommonModule } from '@angular/common';
import { RouterLink, Router } from '@angular/router';
import { AccountService } from 'app/core/auth/account.service';

@Component({
  selector: 'app-cart-page',
  templateUrl: './cart-page.component.html',
  imports: [CommonModule, RouterLink],
  standalone: true,
})
export class CartPageComponent implements OnInit {
  items: CartItem[] = [];
  total = 0;

  private accountService = inject(AccountService);
  private router = inject(Router);

  constructor(private cartService: CartService) {}

  ngOnInit(): void {
    this.loadCart();
  }

  loadCart(): void {
    if (!this.accountService.isAuthenticated()) {
      this.items = this.cartService.getItems();
      this.total = this.items.reduce((sum, item) => sum + item.price * item.quantity, 0);
    } else {
      // 1. Récupère le cartId du user connecté
      this.cartService.getCurrentUserCartId().subscribe({
        next: cartId => {
          if (cartId) {
            // 2. Récupère les CartItems liés à ce cartId
            this.cartService.getCartItemsByCartId(cartId).subscribe({
              next: cartItems => {
                this.items = cartItems ?? [];
                this.total = this.items.reduce((sum, item) => sum + (item.price ?? 0) * (item.quantity ?? 1), 0);
              },
              error: () => {
                this.items = [];
                this.total = 0;
              },
            });
          } else {
            this.items = [];
            this.total = 0;
          }
        },
        error: () => {
          this.items = [];
          this.total = 0;
        },
      });
    }
  }

  remove(id: number): void {
    this.items = this.items.filter(item => item.id !== id);
    this.cartService.updateItems(this.items);
    this.loadCart();
  }

  clear(): void {
    this.items = [];
    this.cartService.updateItems(this.items);
    this.loadCart();
  }

  goToPayment(): void {
    // Vérifie si l'utilisateur est connecté
    if (this.accountService.isAuthenticated()) {
      this.router.navigate(['/payement']); // connecté → paiement
    } else {
      alert('Vous devez être connecté pour passer au paiement.');
      this.router.navigate(['/login']); // non connecté → login
    }
  }
  increaseQty(item: CartItem): void {
    item.quantity++;
    this.cartService.updateItems(this.items);
    this.loadCart();
  }

  decreaseQty(item: CartItem): void {
    if (item.quantity > 1) {
      item.quantity--;
      this.cartService.updateItems(this.items);
      this.loadCart();
    }
  }
}
