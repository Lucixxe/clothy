import { IProduct, NewProduct } from './product.model';

export const sampleWithRequiredData: IProduct = {
  id: 11737,
  name: 'drelin au-dessous',
  sku: 17511,
  price: 1843.12,
};

export const sampleWithPartialData: IProduct = {
  id: 23028,
  name: 'pourvu que à condition que',
  sku: 15873,
  price: 25953.08,
};

export const sampleWithFullData: IProduct = {
  id: 4403,
  name: 'actionnaire',
  sku: 21233,
  price: 2026.75,
};

export const sampleWithNewData: NewProduct = {
  name: 'hormis fréquenter tandis que',
  sku: 26563,
  price: 4718.75,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
