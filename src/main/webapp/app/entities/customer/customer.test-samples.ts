import dayjs from 'dayjs/esm';

import { ICustomer, NewCustomer } from './customer.model';

export const sampleWithRequiredData: ICustomer = {
  id: 3366,
  email: 'Nadine22@yahoo.fr',
  fullName: 'sortir lancer fendre',
  createdAt: dayjs('2025-09-02T14:23'),
  passwordHash: 'dans la mesure où dans la mesure où',
  address: "à l'égard de sitôt que miam",
};

export const sampleWithPartialData: ICustomer = {
  id: 29162,
  email: 'Lorraine96@hotmail.fr',
  fullName: 'au-dehors précisément',
  createdAt: dayjs('2025-09-03T08:16'),
  passwordHash: 'sauvage toutefois absolument',
  address: 'afin que ensuite',
};

export const sampleWithFullData: ICustomer = {
  id: 4149,
  email: 'Angele6@yahoo.fr',
  fullName: 'insipide comme dater',
  createdAt: dayjs('2025-09-03T11:43'),
  passwordHash: 'avant de',
  address: 'chef au-dessous de',
};

export const sampleWithNewData: NewCustomer = {
  email: 'Pacome_Lecomte@yahoo.fr',
  fullName: 'du fait que de façon à psitt',
  createdAt: dayjs('2025-09-02T18:20'),
  passwordHash: 'corps enseignant énergique distinguer',
  address: 'de par',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
