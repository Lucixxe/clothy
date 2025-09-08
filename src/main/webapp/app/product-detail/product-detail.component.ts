import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { ProductService } from 'app/entities/product/service/product.service';
import { IProduct } from 'app/entities/product/product.model';

@Component({
  selector: 'jhi-product-detail',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './product-detail.component.html',
  styleUrl: './product-detail.component.scss',
})
export class ProductDetailComponent implements OnInit {
  product: IProduct | null = null;
  loading = true;

  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly productService = inject(ProductService);

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.productService.find(+id).subscribe({
        next: response => {
          this.product = response.body;
          this.loading = false;
        },
        error: () => {
          this.loading = false;
          this.router.navigate(['/articles-page']);
        },
      });
    } else {
      this.router.navigate(['/articles-page']);
    }
  }

  goBack(): void {
    this.router.navigate(['/articles-page']);
  }
}
