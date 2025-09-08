import dayjs from 'dayjs/esm';

export interface ICustomer {
  id: number;
  email?: string | null;
  firstName?: string | null;
  lastName?: string | null;
  createdAt?: dayjs.Dayjs | null;
  passwordHash?: string | null;
  adress?: string | null;
}

export type NewCustomer = Omit<ICustomer, 'id'> & { id: null };
