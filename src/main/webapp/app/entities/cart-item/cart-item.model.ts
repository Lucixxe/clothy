import { ICart } from 'app/entities/cart/cart.model';
import { IProduct } from 'app/entities/product/product.model';

export interface ICartItem {
  id: number;
  quantity?: number | null;
  unitPrice?: number | null;
  lineTotal?: number | null;
  cart?: ICart | null;
  product?: IProduct | null;
}

export type NewCartItem = Omit<ICartItem, 'id'> & { id: null };
