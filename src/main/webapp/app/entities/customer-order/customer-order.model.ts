import dayjs from 'dayjs/esm';
import { ICustomer } from 'app/entities/customer/customer.model';

export interface ICustomerOrder {
  id: number;
  orderNumber?: string | null;
  createdAt?: dayjs.Dayjs | null;
  total?: number | null;
  customer?: ICustomer | null;
}

export type NewCustomerOrder = Omit<ICustomerOrder, 'id'> & { id: null };
