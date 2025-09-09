import { Component, OnInit } from '@angular/core';
import { CartService, CartItem } from '../core/cart/cart.service';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
@Component({
  selector: 'app-cart-page',
  templateUrl: './cart-page.component.html',
  imports: [CommonModule, RouterLink],
  standalone: true,
})
export class CartPageComponent implements OnInit {
  items: CartItem[] = [];
  total = 0;

  constructor(private cartService: CartService) {}

  ngOnInit(): void {
    this.loadCart();
  }

  loadCart(): void {
    this.items = this.cartService.getItems();
    this.total = this.items.reduce((sum, item) => sum + item.price * item.quantity, 0);
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
}
export class AppModule {}
