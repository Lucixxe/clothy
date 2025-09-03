import { IProduct, NewProduct } from './product.model';

export const sampleWithRequiredData: IProduct = {
  id: 11737,
  name: 'drelin au-dessous',
  sku: 'oh alors que',
  price: 16146.92,
};

export const sampleWithPartialData: IProduct = {
  id: 23028,
  name: 'pourvu que à condition que',
  sku: 'sage zzzz',
  price: 13162.44,
};

export const sampleWithFullData: IProduct = {
  id: 4403,
  name: 'actionnaire',
  sku: 'depuis en',
  price: 12917.62,
};

export const sampleWithNewData: NewProduct = {
  name: 'hormis fréquenter tandis que',
  sku: 'envers magnifique hors',
  price: 7532.66,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
