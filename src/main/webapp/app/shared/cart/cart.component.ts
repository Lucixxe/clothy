import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css'],
})
export class CartComponent {
  itemCount: number = 0; // tu pourras le mettre à jour depuis un service

  constructor(private router: Router) {}
  openCart() {
    this.router.navigate(['/cart']);
  }
}
