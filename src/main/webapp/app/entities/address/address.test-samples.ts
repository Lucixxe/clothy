import { IAddress, NewAddress } from './address.model';

export const sampleWithRequiredData: IAddress = {
  id: 2568,
  line1: 'adorable crac',
  city: 'Saint-Paul',
  country: 'Kiribati',
};

export const sampleWithPartialData: IAddress = {
  id: 1335,
  line1: 'toujours bè',
  city: 'Troyes',
  country: 'Andorre',
};

export const sampleWithFullData: IAddress = {
  id: 16440,
  line1: 'plouf administration',
  city: 'Versailles',
  country: 'Corée du Nord',
};

export const sampleWithNewData: NewAddress = {
  line1: 'toc ronron moderne',
  city: 'Saint-Maur-des-Fossés',
  country: 'Qatar',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
