import { ICustomerOrder } from 'app/entities/customer-order/customer-order.model';
import { IProduct } from 'app/entities/product/product.model';

export interface IOrderItem {
  id: number;
  quantity?: number | null;
  unitPrice?: number | null;
  lineTotal?: number | null;
  order?: ICustomerOrder | null;
  product?: IProduct | null;
}

export type NewOrderItem = Omit<IOrderItem, 'id'> & { id: null };
