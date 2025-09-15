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
    return this.product.image ? `base64,${this.product.image}` : 'assets/images/default-product.png';
  }
}
