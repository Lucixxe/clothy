import { Component } from '@angular/core';
import { Router } from '@angular/router';
@Component({
  selector: 'app-cart',
  standalone: true,
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.scss'],
})
export class CartComponent {
  itemCount: number = 0; // tu pourras le mettre à jour depuis un service

  constructor(private router: Router) {}
  openCart() {
    this.router.navigate(['/cart-page']);
  }
}
