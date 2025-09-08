import { ICart } from 'app/entities/cart/cart.model';
import { IProduct } from 'app/entities/product/product.model';
import { ICustomerOrder } from 'app/entities/customer-order/customer-order.model';

export interface ICartItem {
  id: number;
  quantity?: number | null;
  unitPrice?: number | null;
  lineTotal?: number | null;
  isInOrder?: boolean | null;
  cart?: ICart | null;
  product?: IProduct | null;
  customerOrder?: ICustomerOrder | null;
}

export type NewCartItem = Omit<ICartItem, 'id'> & { id: null };
