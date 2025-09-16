import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ArticleComponent } from 'app/shared/article/article.component';
import { ProductService } from 'app/entities/product/service/product.service';
import { IProduct } from 'app/entities/product/product.model';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'jhi-articles-page',
  standalone: true,
  imports: [ArticleComponent, CommonModule, FormsModule],
  templateUrl: './articles-page.component.html',
  styleUrls: ['./articles-page.component.scss'],
})
export class ArticlesPageComponent implements OnInit {
  products: IProduct[] = [];
  filteredProducts: IProduct[] = [];
  loading = true;
  categories: string[] = [];

  // Prix pour le slider
  minPrice = 0;
  maxPrice = 1000;
  globalMinPrice = 0;
  globalMaxPrice = 1000;

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
          this.initializePriceRange();
          this.filterProducts();
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
          this.initializePriceRange();
          this.filterProducts();
          this.loading = false;
        },
        error: () => {
          this.loading = false;
          console.error('Erreur lors du chargement des produits');
        },
      });
    }
  }

  initializePriceRange(): void {
    if (this.products.length > 0) {
      const prices = this.products.map(product => product.price || 0).filter(price => price > 0);

      if (prices.length > 0) {
        this.globalMinPrice = Math.min(...prices);
        this.globalMaxPrice = Math.max(...prices);
        this.minPrice = this.globalMinPrice;
        this.maxPrice = this.globalMaxPrice;
      }
    }
  }

  filterProducts(): void {
    this.filteredProducts = this.products.filter(product => {
      const price = product.price || 0;
      return price >= this.minPrice && price <= this.maxPrice;
    });
  }

  onMinPriceSliderChange(): void {
    if (this.minPrice > this.maxPrice) {
      this.maxPrice = this.minPrice;
    }
    this.filterProducts();
  }

  onMaxPriceSliderChange(): void {
    if (this.maxPrice < this.minPrice) {
      this.minPrice = this.maxPrice;
    }
    this.filterProducts();
  }
}
