import { ICategory, NewCategory } from './category.model';

export const sampleWithRequiredData: ICategory = {
  id: 8109,
  name: 'au-dedans de conférer mal',
  slug: 'clac planter',
  isActive: false,
};

export const sampleWithPartialData: ICategory = {
  id: 15504,
  name: 'différencier',
  slug: 'manifester partenaire',
  isActive: true,
};

export const sampleWithFullData: ICategory = {
  id: 28780,
  name: 'plouf',
  slug: 'gens',
  isActive: true,
};

export const sampleWithNewData: NewCategory = {
  name: 'aussitôt que cocorico quand ?',
  slug: 'premièrement reconnaître atchoum',
  isActive: true,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
