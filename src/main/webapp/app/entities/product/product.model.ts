import { ICategory } from 'app/entities/category/category.model';

export interface IProduct {
  id: number;
  name?: string | null;
  sku?: number | null;
  price?: number | null;
  categories?: ICategory[] | null;
}

export type NewProduct = Omit<IProduct, 'id'> & { id: null };
