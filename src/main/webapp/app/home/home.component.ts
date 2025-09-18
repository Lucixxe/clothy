import { Component, Input, OnDestroy, OnInit, inject, signal } from '@angular/core';
import { Router, RouterModule, Routes } from '@angular/router';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { ProductService } from 'app/entities/product/service/product.service';
import SharedModule from 'app/shared/shared.module';
import { AccountService } from 'app/core/auth/account.service';
import { Account } from 'app/core/auth/account.model';
import { ArticleComponent } from 'app/shared/article/article.component';
import { IProduct } from 'app/entities/product/product.model';

@Component({
  selector: 'jhi-home',
  standalone: true,

  templateUrl: './home.component.html',
  styleUrl: './home.component.scss',
  imports: [SharedModule, RouterModule, ArticleComponent],
})
export default class HomeComponent implements OnInit, OnDestroy {
  account = signal<Account | null>(null);

  private readonly destroy$ = new Subject<void>();

  private readonly accountService = inject(AccountService);
  private readonly productService = inject(ProductService);
  bestSellers: any[] = [];
  private readonly router = inject(Router);
  ngOnInit(): void {
    this.accountService
      .getAuthenticationState()
      .pipe(takeUntil(this.destroy$))
      .subscribe(account => this.account.set(account));
    this.productService.query().subscribe(response => {
      this.bestSellers = (response.body ?? []).slice(0, 5);
    });
  }
  goToProduct(product: IProduct): void {
    this.router.navigate(['/product', product.id]);
  }
  login(): void {
    this.router.navigate(['/login']);
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }
}
