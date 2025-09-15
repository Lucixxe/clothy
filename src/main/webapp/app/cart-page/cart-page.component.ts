import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink, Router } from '@angular/router';

import { CartService, CartItem } from '../entities/cart/service/cart.service';
import { AccountService } from 'app/core/auth/account.service';
import { ProductService } from 'app/entities/product/service/product.service';
import { ICartItem } from '../entities/cart-item/cart-item.model';
import { IProduct } from 'app/entities/product/product.model';
import { CartItemService } from 'app/entities/cart-item/service/cart-item.service';
import { loadStripe } from '@stripe/stripe-js';
import { HttpClient } from '@angular/common/http';

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
  IdCart: number = 0;
  total = 0;
  constructor(private http: HttpClient) {}

  public accountService = inject(AccountService);
  private router = inject(Router);
  private productService = inject(ProductService);
  private cartService = inject(CartService);
  // Pour les mises à jour de qty
  private cartItemService = inject(CartItemService);

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
          this.IdCart = cartId;
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
                unitPrice: item.unitPrice ?? 0,
                lineTotal: (item.unitPrice ?? 0) * (item.quantity ?? 1),
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
      // Utilisateur non connecté → panier local
      this.items = this.items.filter(item => item.id !== id);
      this.cartService.updateItems(this.items);
      this.updateTotalICart();
    } else {
      // Utilisateur connecté → suppression via API
      this.cartItemService.delete(id).subscribe({
        next: () => {
          // Mise à jour du tableau local après suppression
          this.itemsICart = this.itemsICart.filter(item => item.id !== id);
          this.updateTotalICart();
        },
        error: err => console.error('Erreur suppression du cartItem', err),
      });
    }
  }

  clear(): void {
    if (!this.accountService.isAuthenticated()) {
      this.items = [];
      this.cartService.updateItems([]);
    } else {
      this.itemsICart = [];
      this.cartService.clearCart(this.IdCart).subscribe();
    }
    this.total = 0;
  }

  async goToPayment() {
    if (this.accountService.isAuthenticated()) {
      const stripe = await loadStripe('pk_test_...'); // clé publique
      const token = localStorage.getItem('jhi-authenticationtoken');

      this.http
        .post(
          'http://localhost:8080/api/payment/create-checkout-session?amount=' + this.total * 100,
          {},
          {
            headers: { Authorization: `Bearer ${token}` },
            responseType: 'text',
          },
        )
        .subscribe(async (url: string) => {
          window.location.href = url; // redirection vers Stripe Checkout
        });
    } else {
      alert('Vous devez être connecté pour passer au paiement.');
      this.router.navigate(['/login']);
    }
  }

  increaseQty(item: CartItem | ICartItem): void {
    if (!this.accountService.isAuthenticated()) {
      // Cas utilisateur non connecté → panier local
      if ('quantity' in item && item.quantity) item.quantity++;
      if ('lineTotal' in item && 'unitPrice' in item) {
        item.lineTotal = (item.unitPrice ?? 0) * (item.quantity ?? 1);
      }
      this.cartService.updateItems(this.items);
      this.updateTotalICart();
    } else {
      // Cas utilisateur connecté → mise à jour en base
      const updatedItem = {
        id: (item as ICartItem).id,
        quantity: ((item as ICartItem).quantity ?? 0) + 1,
      };

      this.cartItemService.partialUpdate(updatedItem).subscribe({
        next: res => {
          if (res.body) {
            (item as ICartItem).quantity = res.body.quantity;
            (item as ICartItem).lineTotal = (item as ICartItem).unitPrice! * res.body.quantity!;
            this.updateTotalICart();
          }
        },
        error: err => console.error('Erreur update quantité', err),
      });
    }
  }

  decreaseQty(item: CartItem | ICartItem): void {
    if (!this.accountService.isAuthenticated()) {
      // Cas utilisateur non connecté → panier local
      if ('quantity' in item && item.quantity && item.quantity > 1) {
        item.quantity--;
        if ('lineTotal' in item && 'unitPrice' in item) {
          item.lineTotal = (item.unitPrice ?? 0) * (item.quantity ?? 1);
        }
        this.cartService.updateItems(this.items);
        this.updateTotalICart();
      }
    } else {
      // Cas utilisateur connecté → mise à jour en base
      if ((item as ICartItem).quantity && (item as ICartItem).quantity! > 1) {
        const updatedItem = {
          id: (item as ICartItem).id,
          quantity: (item as ICartItem).quantity! - 1,
        };

        this.cartItemService.partialUpdate(updatedItem).subscribe({
          next: res => {
            if (res.body) {
              (item as ICartItem).quantity = res.body.quantity;
              (item as ICartItem).lineTotal = (item as ICartItem).unitPrice! * res.body.quantity!;
              this.updateTotalICart();
            }
          },
          error: err => console.error('Erreur update quantité', err),
        });
      }
    }
  }
}
