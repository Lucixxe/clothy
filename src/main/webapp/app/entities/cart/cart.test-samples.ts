import dayjs from 'dayjs/esm';

import { ICart, NewCart } from './cart.model';

export const sampleWithRequiredData: ICart = {
  id: 20875,
  cartKey: 'a10e8029-27a5-4663-8999-9bd988306a6e',
  createdAt: dayjs('2025-09-08T11:22'),
  isCheckedOut: false,
};

export const sampleWithPartialData: ICart = {
  id: 17644,
  cartKey: '2f0b93bf-721f-4462-9752-2c38fcdc1018',
  createdAt: dayjs('2025-09-08T10:07'),
  isCheckedOut: false,
};

export const sampleWithFullData: ICart = {
  id: 4081,
  cartKey: '62f9e4c3-6293-4ccf-a604-09dd88fbf6f2',
  createdAt: dayjs('2025-09-08T06:20'),
  isCheckedOut: true,
};

export const sampleWithNewData: NewCart = {
  cartKey: 'c37c43f3-518f-4db8-bace-3a603dc0cd5e',
  createdAt: dayjs('2025-09-07T18:39'),
  isCheckedOut: false,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
