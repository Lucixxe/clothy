import dayjs from 'dayjs/esm';

export interface ICustomer {
  id: number;
  email?: string | null;
  firstName?: string | null;
  name?: string | null;
  createdAt?: dayjs.Dayjs | null;
  passwordHash?: string | null;
  address?: string | null;
}

export type NewCustomer = Omit<ICustomer, 'id'> & { id: null };
