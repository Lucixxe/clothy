import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

interface CartItem {
  id: number;
  name: string;
  price: number;
  quantity: number;
  image: string;
}

@Component({
  selector: 'jhi-cart-page',
  imports: [CommonModule],
  templateUrl: './cart-page.component.html',
  styleUrls: ['./cart-page.component.scss'],
})
export class CartPageComponent {
  cartItems: CartItem[] = [
    // exemple d'articles, à remplacer par le service réel
    { id: 1, name: 'T-shirt Homme', price: 19.99, quantity: 2, image: 'assets/images/tshirt.jpg' },
    { id: 2, name: 'Chaussures', price: 49.99, quantity: 1, image: 'assets/images/shoes.jpg' },
  ];

  getTotal(): number {
    return this.cartItems.reduce((total, item) => total + item.price * item.quantity, 0);
  }

  removeItem(item: CartItem) {
    this.cartItems = this.cartItems.filter(i => i.id !== item.id);
  }

  checkout() {
    alert('Redirection vers la page de paiement...');
    // ici tu peux naviguer vers une page de checkout
  }
}
