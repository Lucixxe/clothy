import { ICategory } from 'app/entities/category/category.model';

export interface IProduct {
  id: number;
  name?: string | null;
  sku?: string | null;
  price?: number | null;
  category?: ICategory | null;
}

export type NewProduct = Omit<IProduct, 'id'> & { id: null };
