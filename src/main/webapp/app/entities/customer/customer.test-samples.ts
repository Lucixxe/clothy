import dayjs from 'dayjs/esm';

import { ICustomer, NewCustomer } from './customer.model';

export const sampleWithRequiredData: ICustomer = {
  id: 3366,
  email: 'Nadine22@yahoo.fr',
  firstName: 'Raoul',
  name: 'inspirer habile',
  createdAt: dayjs('2025-09-08T04:06'),
  passwordHash: 'coac coac',
  address: 'dense gestionnaire hors',
};

export const sampleWithPartialData: ICustomer = {
  id: 29162,
  email: 'Lorraine96@hotmail.fr',
  firstName: 'Loup',
  name: 'durant sale',
  createdAt: dayjs('2025-09-08T09:30'),
  passwordHash: "spécialiste d'entre après-demain",
  address: 'au défaut de multiplier',
};

export const sampleWithFullData: ICustomer = {
  id: 4149,
  email: 'Angele6@yahoo.fr',
  firstName: 'Pierre',
  name: 'concernant',
  createdAt: dayjs('2025-09-08T01:14'),
  passwordHash: 'même si outre mince',
  address: 'concurrence',
};

export const sampleWithNewData: NewCustomer = {
  email: 'Pacome_Lecomte@yahoo.fr',
  firstName: 'Théodose',
  name: 'de peur que débile coupable',
  createdAt: dayjs('2025-09-08T06:03'),
  passwordHash: 'personnel direction',
  address: 'hésiter sauf à diplomate',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
