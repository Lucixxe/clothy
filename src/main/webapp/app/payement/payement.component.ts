import { Component, inject, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AccountService } from 'app/core/auth/account.service';
import { loadStripe } from '@stripe/stripe-js';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'jhi-payement',
  template: `<button (click)="checkout()">Payer maintenant</button>`,
})
export class PayementComponent implements OnInit {
  private accountService = inject(AccountService);
  private router = inject(Router);

  constructor(private http: HttpClient) {}

  ngOnInit(): void {}

  async checkout() {
    const stripe = await loadStripe(
      'pk_test_51S7sx2RkxlAub16WafblID2ttD1zpzIgRSLAbYsRENxi1UueZZtPDMrZK8sR8Im0hvhzYhuqCKVFRFZAQDC9B3tL00Zd6tYxnP',
    ); // clé publique

    const token = localStorage.getItem('jhi-authenticationtoken');

    this.http
      .post(
        'http://localhost:8080/api/payment/create-checkout-session?amount=5000',
        {},
        {
          headers: { Authorization: `Bearer ${token}` },
          responseType: 'text',
        },
      )
      .subscribe(async (url: string) => {
        window.location.href = url; // redirection vers Stripe Checkout
      });
  }
}
