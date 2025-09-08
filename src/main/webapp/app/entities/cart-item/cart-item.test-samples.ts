import { ICartItem, NewCartItem } from './cart-item.model';

export const sampleWithRequiredData: ICartItem = {
  id: 12545,
  quantity: 12390,
  unitPrice: 4248.22,
  lineTotal: 18850.65,
  isInOrder: false,
};

export const sampleWithPartialData: ICartItem = {
  id: 2454,
  quantity: 14800,
  unitPrice: 11066.87,
  lineTotal: 31912.89,
  isInOrder: true,
};

export const sampleWithFullData: ICartItem = {
  id: 9768,
  quantity: 32077,
  unitPrice: 22346.9,
  lineTotal: 32248.47,
  isInOrder: false,
};

export const sampleWithNewData: NewCartItem = {
  quantity: 917,
  unitPrice: 26962.64,
  lineTotal: 4104.3,
  isInOrder: false,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
