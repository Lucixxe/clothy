import { Component } from '@angular/core';
import { Routes } from '@angular/router';

@Component({
  selector: 'jhi-cart-page',
  standalone: true,
  imports: [],
  templateUrl: './cart-page.component.html',
  styleUrl: './cart-page.component.scss',
})
export class CartPageComponent {}
export const cartPageRoute: Routes = [
  {
    path: '',
    component: CartPageComponent,
    data: { pageTitle: 'Cart' },
  },
];
