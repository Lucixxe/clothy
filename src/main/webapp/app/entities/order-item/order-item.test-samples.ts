import { IOrderItem, NewOrderItem } from './order-item.model';

export const sampleWithRequiredData: IOrderItem = {
  id: 16549,
  quantity: 23988,
  unitPrice: 22506.51,
  lineTotal: 12961.94,
};

export const sampleWithPartialData: IOrderItem = {
  id: 28487,
  quantity: 27299,
  unitPrice: 22462.83,
  lineTotal: 24133.36,
};

export const sampleWithFullData: IOrderItem = {
  id: 6728,
  quantity: 17449,
  unitPrice: 20263.67,
  lineTotal: 10948.34,
};

export const sampleWithNewData: NewOrderItem = {
  quantity: 12165,
  unitPrice: 1027.11,
  lineTotal: 12468.3,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
