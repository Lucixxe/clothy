import dayjs from 'dayjs/esm';

import { ICustomer, NewCustomer } from './customer.model';

export const sampleWithRequiredData: ICustomer = {
  id: 3366,
  email: 'Nadine22@yahoo.fr',
  firstName: 'Raoul',
  lastName: 'Legrand',
  createdAt: dayjs('2025-09-08T04:45'),
  passwordHash: 'quoique zzzz',
  adress: 'suivant ah',
};

export const sampleWithPartialData: ICustomer = {
  id: 29162,
  email: 'Lorraine96@hotmail.fr',
  firstName: 'Loup',
  lastName: 'Laine',
  createdAt: dayjs('2025-09-07T12:45'),
  passwordHash: 'souvent solitaire',
  adress: 'adorable multiple tandis que',
};

export const sampleWithFullData: ICustomer = {
  id: 4149,
  email: 'Angele6@yahoo.fr',
  firstName: 'Pierre',
  lastName: 'Durand',
  createdAt: dayjs('2025-09-07T17:09'),
  passwordHash: 'vouh chut conseil d’administration',
  adress: 'clac parce que',
};

export const sampleWithNewData: NewCustomer = {
  email: 'Pacome_Lecomte@yahoo.fr',
  firstName: 'Théodose',
  lastName: 'Sanchez',
  createdAt: dayjs('2025-09-08T07:54'),
  passwordHash: 'conseil municipal',
  adress: 'suivant',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
