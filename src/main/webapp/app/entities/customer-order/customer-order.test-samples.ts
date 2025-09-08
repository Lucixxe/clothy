import dayjs from 'dayjs/esm';

import { ICustomerOrder, NewCustomerOrder } from './customer-order.model';

export const sampleWithRequiredData: ICustomerOrder = {
  id: 2458,
  orderNumber: 'contre fourbe tomber',
  createdAt: dayjs('2025-09-08T03:47'),
  total: 26426.82,
};

export const sampleWithPartialData: ICustomerOrder = {
  id: 19527,
  orderNumber: 'partenaire infiniment pouvoir',
  createdAt: dayjs('2025-09-07T23:42'),
  total: 18055.71,
};

export const sampleWithFullData: ICustomerOrder = {
  id: 24520,
  orderNumber: 'presque mature',
  createdAt: dayjs('2025-09-07T10:04'),
  total: 27764.95,
};

export const sampleWithNewData: NewCustomerOrder = {
  orderNumber: 'déborder derrière',
  createdAt: dayjs('2025-09-08T04:53'),
  total: 20267.31,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
