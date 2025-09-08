import { Component, Input, inject } from '@angular/core';
import { Router } from '@angular/router';
import { IProduct } from 'app/entities/product/product.model';

@Component({
  selector: 'jhi-article',
  standalone: true,
  imports: [],
  templateUrl: './article.component.html',
  styleUrl: './article.component.scss',
})
export class ArticleComponent {
  @Input() product!: IProduct;

  private readonly router = inject(Router);

  goToProduct(): void {
    this.router.navigate(['/product', this.product.id]);
  }

  getProductImage(): string {
    // Image par défaut pour tous les produits
    return 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&w=600&q=80';
  }
}
