import { ICustomer } from 'app/entities/customer/customer.model';

export interface IAddress {
  id: number;
  line1?: string | null;
  city?: string | null;
  country?: string | null;
  customer?: ICustomer | null;
}

export type NewAddress = Omit<IAddress, 'id'> & { id: null };
