import dayjs from 'dayjs/esm';

import { ICustomer, NewCustomer } from './customer.model';

export const sampleWithRequiredData: ICustomer = {
  id: 9734,
  email: 'Josse.Legrand50@gmail.com',
  firstName: 'Thibert',
  lastName: 'Marchal',
  createdAt: dayjs('2025-09-08T02:12'),
  passwordHash: 'd’autant que coupable coac coac',
  adress: 'dense gestionnaire hors',
};

export const sampleWithPartialData: ICustomer = {
  id: 9060,
  email: 'Thais29@hotmail.fr',
  firstName: 'Timoléon',
  lastName: 'Marchal',
  createdAt: dayjs('2025-09-08T00:35'),
  passwordHash: 'groin groin',
  adress: 'solitaire pauvre résulter',
};

export const sampleWithFullData: ICustomer = {
  id: 4632,
  email: 'Lorraine_Leclerc20@gmail.com',
  firstName: 'Marie',
  lastName: 'Carre',
  createdAt: dayjs('2025-09-07T19:49'),
  passwordHash: 'aussitôt que',
  adress: 'chut conseil d’administration amorphe',
};

export const sampleWithNewData: NewCustomer = {
  email: 'Pacome_Lecomte@yahoo.fr',
  firstName: 'Théodose',
  lastName: 'Sanchez',
  createdAt: dayjs('2025-09-08T11:20'),
  passwordHash: 'conseil municipal',
  adress: 'suivant',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
