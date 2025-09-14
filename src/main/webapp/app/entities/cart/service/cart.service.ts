import { Injectable, inject } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable, map, of } from 'rxjs';

import dayjs from 'dayjs/esm';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { ICart, NewCart } from '../cart.model';
import { AccountService } from 'app/core/auth/account.service';
import { ICartItem } from '../../cart-item/cart-item.model';

export interface CartItem {
  id: number;
  name: string;
  price: number;
  quantity: number;
  productId?: number;
}

export type PartialUpdateCart = Partial<ICart> & Pick<ICart, 'id'>;

type RestOf<T extends ICart | NewCart> = Omit<T, 'createdAt'> & {
  createdAt?: string | null;
};

export type RestCart = RestOf<ICart>;
export type NewRestCart = RestOf<NewCart>;
export type PartialUpdateRestCart = RestOf<PartialUpdateCart>;
export type EntityResponseType = HttpResponse<ICart>;
export type EntityArrayResponseType = HttpResponse<ICart[]>;

@Injectable({ providedIn: 'root' })
export class CartService {
  protected readonly http = inject(HttpClient);
  protected readonly applicationConfigService = inject(ApplicationConfigService);
  protected readonly accountService = inject(AccountService);

  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/carts');
  private storageKey = 'cartItems';

  // --- Cookies (utilisateur non connecté) ---
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
    if (this.accountService.isAuthenticated()) {
      // Utilisateur connecté : le panier est en base, cette méthode ne doit pas être utilisée
      return [];
    }
    const stored = this.getCookie(this.storageKey);
    return stored ? JSON.parse(stored) : [];
  }

  addItem(item: CartItem): void {
    if (this.accountService.isAuthenticated()) {
      // Utilisateur connecté : ajoute via l'API (à adapter selon ton API)
      this.http.post('/api/cart-items', item).subscribe();
    } else {
      const items = this.getItems();
      const existing = items.find(i => i.id === item.id);
      if (existing) {
        existing.quantity += item.quantity;
      } else {
        items.push(item);
      }
      this.save(items);
    }
  }

  updateItems(items: CartItem[]): void {
    if (this.accountService.isAuthenticated()) {
      // Utilisateur connecté : met à jour via l'API (à adapter selon ton API)
      this.http.put('/api/cart-items', items).subscribe();
    } else {
      this.save(items);
    }
  }

  removeItem(id: number): void {
    if (this.accountService.isAuthenticated()) {
      this.http.delete(`/api/cart-items/${id}`).subscribe();
    } else {
      const items = this.getItems().filter(p => p.id !== id);
      this.save(items);
    }
  }

  clear(): void {
    if (this.accountService.isAuthenticated()) {
      this.http.delete('/api/cart-items').subscribe();
    } else {
      this.removeCookie(this.storageKey);
    }
  }

  getCount(): number {
    const items = this.getItems();
    return items.reduce((sum, item) => sum + item.quantity, 0);
  }

  private save(items: CartItem[]): void {
    this.setCookie(this.storageKey, JSON.stringify(items));
  }

  // --- API (utilisateur connecté) ---
  create(cart: NewCart): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(cart);
    return this.http.post<RestCart>(this.resourceUrl, copy, { observe: 'response' }).pipe(map(res => this.convertResponseFromServer(res)));
  }

  update(cart: ICart): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(cart);
    return this.http
      .put<RestCart>(`${this.resourceUrl}/${this.getCartIdentifier(cart)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  partialUpdate(cart: PartialUpdateCart): Observable<EntityResponseType> {
    const copy = this.convertDateFromClient(cart);
    return this.http
      .patch<RestCart>(`${this.resourceUrl}/${this.getCartIdentifier(cart)}`, copy, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http
      .get<RestCart>(`${this.resourceUrl}/${id}`, { observe: 'response' })
      .pipe(map(res => this.convertResponseFromServer(res)));
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http
      .get<RestCart[]>(this.resourceUrl, { params: options, observe: 'response' })
      .pipe(map(res => this.convertResponseArrayFromServer(res)));
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getCartIdentifier(cart: Pick<ICart, 'id'>): number {
    return cart.id;
  }

  compareCart(o1: Pick<ICart, 'id'> | null, o2: Pick<ICart, 'id'> | null): boolean {
    return o1 && o2 ? this.getCartIdentifier(o1) === this.getCartIdentifier(o2) : o1 === o2;
  }

  addCartToCollectionIfMissing<Type extends Pick<ICart, 'id'>>(
    cartCollection: Type[],
    ...cartsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const carts: Type[] = cartsToCheck.filter(isPresent);
    if (carts.length > 0) {
      const cartCollectionIdentifiers = cartCollection.map(cartItem => this.getCartIdentifier(cartItem));
      const cartsToAdd = carts.filter(cartItem => {
        const cartIdentifier = this.getCartIdentifier(cartItem);
        if (cartCollectionIdentifiers.includes(cartIdentifier)) {
          return false;
        }
        cartCollectionIdentifiers.push(cartIdentifier);
        return true;
      });
      return [...cartsToAdd, ...cartCollection];
    }
    return cartCollection;
  }

  // --- Utilitaires conversion date ---
  protected convertDateFromClient<T extends ICart | NewCart | PartialUpdateCart>(cart: T): RestOf<T> {
    return {
      ...cart,
      createdAt: cart.createdAt?.toJSON() ?? null,
    };
  }

  protected convertDateFromServer(restCart: RestCart): ICart {
    return {
      ...restCart,
      createdAt: restCart.createdAt ? dayjs(restCart.createdAt) : undefined,
    };
  }

  protected convertResponseFromServer(res: HttpResponse<RestCart>): HttpResponse<ICart> {
    return res.clone({
      body: res.body ? this.convertDateFromServer(res.body) : null,
    });
  }

  protected convertResponseArrayFromServer(res: HttpResponse<RestCart[]>): HttpResponse<ICart[]> {
    return res.clone({
      body: res.body ? res.body.map(item => this.convertDateFromServer(item)) : null,
    });
  }

  // --- API pour récupérer le cartId et les CartItems ---
  getCurrentUserCartId(): Observable<number> {
    return this.http.get<number>('/api/carts/current/id');
  }

  getCartItemsByCartId(cartId: number): Observable<ICartItem[]> {
    return this.http.get<ICartItem[]>(`/api/cart-items/by-cart/${cartId}`);
  }

  clearCart(cartId: number): Observable<CartItem[]> {
    return this.http.delete<CartItem[]>(`/api/cart-items/empty-cart/${cartId}`);
  }
}
