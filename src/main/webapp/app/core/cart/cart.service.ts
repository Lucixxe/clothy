import { Injectable } from '@angular/core';

export interface CartItem {
  id: number;
  name: string;
  price: number;
  quantity: number;
}

@Injectable({ providedIn: 'root' })
export class CartService {
  private storageKey = 'cartItems';

  // Utilitaires cookies
  private getCookie(name: string): string | null {
    const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    return match ? decodeURIComponent(match[2]) : null;
  }

  private setCookie(name: string, value: string, days = 7): void {
    const expires = new Date(Date.now() + days * 864e5).toUTCString();
    document.cookie = `${name}=${encodeURIComponent(value)}; expires=${expires}; path=/`;
  }

  private removeCookie(name: string): void {
    document.cookie = `${name}=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;`;
  }

  getItems(): CartItem[] {
    const stored = this.getCookie(this.storageKey);
    return stored ? JSON.parse(stored) : [];
  }

  private save(items: CartItem[]): void {
    this.setCookie(this.storageKey, JSON.stringify(items));
  }

  addItem(item: CartItem): void {
    const items = this.getItems();
    const existing = items.find(i => i.id === item.id);
    if (existing) {
      existing.quantity += item.quantity;
    } else {
      items.push(item);
    }
    this.save(items);
  }

  updateItems(items: CartItem[]): void {
    this.save(items);
  }

  removeItem(id: number): void {
    const items = this.getItems().filter(p => p.id !== id);
    this.save(items);
  }

  clear(): void {
    this.removeCookie(this.storageKey);
  }

  getCount(): number {
    const items = this.getItems();
    return items.reduce((sum, item) => sum + item.quantity, 0);
  }
}
