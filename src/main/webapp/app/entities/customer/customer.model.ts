import dayjs from 'dayjs/esm';
import { IUser } from 'app/entities/user/user.model';

export interface ICustomer {
  id: number;
  email?: string | null;
  firstName?: string | null;
  lastName?: string | null;
  createdAt?: dayjs.Dayjs | null;
  passwordHash?: string | null;
  adress?: string | null;
  user?: Pick<IUser, 'id' | 'login'> | null;
}

export type NewCustomer = Omit<ICustomer, 'id'> & { id: null };
