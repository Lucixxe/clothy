import dayjs from 'dayjs/esm';

export interface ICustomer {
  id: number;
  email?: string | null;
  fullName?: string | null;
  createdAt?: dayjs.Dayjs | null;
  passwordHash?: string | null;
}

export type NewCustomer = Omit<ICustomer, 'id'> & { id: null };
