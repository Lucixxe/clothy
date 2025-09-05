import { Component } from '@angular/core';
import { Routes } from '@angular/router';
import { ArticleComponent } from 'app/shared/article/article.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'jhi-articles-page',
  standalone: true,
  imports: [ArticleComponent, CommonModule],
  templateUrl: './articles-page.component.html',
  styleUrls: ['./articles-page.component.scss'],
})
export class ArticlesPageComponent {
  products = [
    { id: 1, name: 'T-shirt Blanc', price: 19.99 },
    { id: 2, name: 'Pantalon Noir', price: 39.99 },
    { id: 3, name: 'Chaussures Sport', price: 59.99 },
    { id: 4, name: 'Pull Gris', price: 29.99 },
    { id: 5, name: 'Sac à Dos', price: 49.99 },
    { id: 6, name: 'Casquette', price: 14.99 },
  ];
}

export const cartPageRoute: Routes = [
  {
    path: '',
    component: ArticlesPageComponent,
    data: { pageTitle: 'Articles' },
  },
];
