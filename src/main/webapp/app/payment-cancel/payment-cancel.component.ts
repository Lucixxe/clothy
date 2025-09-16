import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'jhi-payment-cancel',
  imports: [],
  templateUrl: './payment-cancel.component.html',
  styleUrl: './payment-cancel.component.scss',
})
export class PaymentCancelComponent {
  orderId: string | null = null; // tu peux passer l'ID via query params comme pour la success page

  constructor(private router: Router) {}

  goToHome(): void {
    this.router.navigate(['/']);
  }
}
