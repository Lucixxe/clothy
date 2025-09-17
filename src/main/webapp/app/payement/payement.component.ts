import { Component, inject, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AccountService } from 'app/core/auth/account.service';
import { loadStripe } from '@stripe/stripe-js';
import { HttpClient } from '@angular/common/http';
import { environment } from 'environments/environment';

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
    const stripe = await loadStripe(environment.stripePublicKey);

    const token = localStorage.getItem('jhi-authenticationtoken');

    this.http
      .post(
        `${environment.apiUrl}/api/payment/create-checkout-session?amount=5000`,
        {},
        {
          headers: { Authorization: `Bearer ${token}` },
          responseType: 'text',
        },
      )
      .subscribe(async (url: string) => {
        window.location.href = url;
      });
  }
}
