import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { ProductService } from 'app/entities/product/service/product.service';
import { IProduct } from 'app/entities/product/product.model';
import { CartService } from '../core/cart/cart.service';
import { CartItemService } from 'app/entities/cart-item/service/cart-item.service';
import { AccountService } from 'app/core/auth/account.service';
@Component({
  selector: 'jhi-product-detail',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.scss'], // ❌ c’était "styleUrl" (au singulier)
})
export class ProductDetailComponent implements OnInit {
  product: IProduct | null = null;
  loading = true;
  addedToCart = false;

  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly productService = inject(ProductService);

  protected cartItemService = inject(CartItemService);
  protected accountService = inject(AccountService);

  constructor(private cartService: CartService) {}

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

  addToCart(product: any): void {
    if (!this.accountService.isAuthenticated()) {
      this.cartService.addItem({
        id: product.id,
        name: product.name,
        price: product.price,
        quantity: 1,
      });
      this.addedToCart = true;
      setTimeout(() => (this.addedToCart = false), 1200); // Animation visible 1.2s
    } else {
      this.cartItemService.addToCart(product.id, 1).subscribe({
        next: () => alert('${product.name} added to cart!'),
        error: err => console.error('Error adding to cart', err),
      });
    }
  }
}
