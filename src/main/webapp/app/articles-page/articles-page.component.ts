import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ArticleComponent } from 'app/shared/article/article.component';
import { ProductService } from 'app/entities/product/service/product.service';
import { IProduct } from 'app/entities/product/product.model';
import { ActivatedRoute } from '@angular/router';

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
  categories: string[] = [];

  private readonly productService = inject(ProductService);
  private readonly route = inject(ActivatedRoute);
  ngOnInit(): void {
    this.route.queryParamMap.subscribe(params => {
      const category = params.get('category');
      this.categories = category ? [category] : [];
      this.loadProducts();
    });
  }

  loadProducts(): void {
    this.loading = true;
    if (this.categories.length == 0) {
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
    } else {
      this.productService.getByCategory(this.categories[0]).subscribe({
        next: response => {
          this.products = response ?? [];
          this.loading = false;
        },
        error: () => {
          this.loading = false;
          console.error('Erreur lors du chargement des produits');
        },
      });
    }
  }
}
