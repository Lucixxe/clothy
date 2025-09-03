import dayjs from 'dayjs/esm';
import { ICustomer } from 'app/entities/customer/customer.model';

export interface ICart {
  id: number;
  cartKey?: string | null;
  createdAt?: dayjs.Dayjs | null;
  isCheckedOut?: boolean | null;
  customer?: ICustomer | null;
}

export type NewCart = Omit<ICart, 'id'> & { id: null };
