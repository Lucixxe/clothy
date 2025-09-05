import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ArticleComponent } from 'app/shared/article/article.component';
import { ProductService } from 'app/entities/product/service/product.service';
import { IProduct } from 'app/entities/product/product.model';

@Component({
  selector: 'jhi-articles-page',
  standalone: true,
  imports: [ArticleComponent, CommonModule],
  templateUrl: './articles-page.component.html',
  styleUrls: ['./articles-page.component.scss'],
})
export class ArticlesPageComponent implements OnInit {
  products: IProduct[] = [];
  loading = true;

  private readonly productService = inject(ProductService);

  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts(): void {
    this.loading = true;
    this.productService.query().subscribe({
      next: response => {
        this.products = response.body ?? [];
        this.loading = false;
      },
      error: () => {
        this.loading = false;
        console.error('Erreur lors du chargement des produits');
      },
    });
  }
}
