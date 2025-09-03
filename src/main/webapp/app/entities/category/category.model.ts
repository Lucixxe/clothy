export interface ICategory {
  id: number;
  name?: string | null;
  slug?: string | null;
  isActive?: boolean | null;
}

export type NewCategory = Omit<ICategory, 'id'> & { id: null };
