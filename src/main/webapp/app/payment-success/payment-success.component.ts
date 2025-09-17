import { Component, inject, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CustomerOrderService } from 'app/entities/customer-order/service/customer-order.service';
import { CartItemService } from 'app/entities/cart-item/service/cart-item.service';
import { AccountService } from 'app/core/auth/account.service';
import { CustomerService } from 'app/entities/customer/service/customer.service';
import { CartService, CartItem } from '../entities/cart/service/cart.service';
import { CheckoutService } from 'app/entities/checkout/checkout.service';

@Component({
  selector: 'jhi-payment-success',
  imports: [],
  templateUrl: './payment-success.component.html',
  styleUrl: './payment-success.component.scss',
})
export class PaymentSuccessComponent implements OnInit {
  orderId: string = '';
  private customerOrderService = inject(CustomerOrderService);
  private cartItemService = inject(CartItemService);
  private accountService = inject(AccountService);
  private customerService = inject(CustomerService);
  private cartService = inject(CartService);
  private checkoutService = inject(CheckoutService);
  constructor(private router: Router) {}
  IdCart?: number;

  ngOnInit(): void {
    // Génère un ID de commande aléatoire
    this.orderId =
      'ORD-' +
      Math.floor(Math.random() * 1000000)
        .toString()
        .padStart(6, '0');
    //recuperer l'id de l'utilisateur connecté
    this.cartService.getCurrentUserCartId().subscribe({
      next: cartId => {
        if (!cartId) {
          return;
        }
        this.IdCart = cartId;
        this.cartService.clear(); // Vider le panier stocké dans les cookies
        // Supprimer les éléments du panier côté serveur
        this.checkoutService.checkOut(cartId).subscribe({
          next: () => {
            console.log('Checkout finalisé avec succès.');
          },
          error: err => {
            console.error('Erreur lors du checkout :', err);
          },
        });
      },
      error: () => {
        console.error("Erreur lors de la récupération du panier de l'utilisateur.");
      },
    });
  }
  goToHome() {
    this.router.navigate(['/']); // Redirection vers la page d'accueil
  }
}
