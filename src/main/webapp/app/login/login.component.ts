import { AfterViewInit, Component, ElementRef, OnInit, inject, signal, viewChild } from '@angular/core';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';

import SharedModule from 'app/shared/shared.module';
import { LoginService } from 'app/login/login.service';
import { AccountService } from 'app/core/auth/account.service';
import { CartService } from 'app/entities/cart/service/cart.service';
import { CartItemService } from 'app/entities/cart-item/service/cart-item.service';

@Component({
  selector: 'jhi-login',
  imports: [SharedModule, FormsModule, ReactiveFormsModule, RouterModule],
  templateUrl: './login.component.html',
})
export default class LoginComponent implements OnInit, AfterViewInit {
  username = viewChild.required<ElementRef>('username');

  authenticationError = signal(false);

  loginForm = new FormGroup({
    username: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
    password: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
    rememberMe: new FormControl(false, { nonNullable: true, validators: [Validators.required] }),
  });

  private readonly accountService = inject(AccountService);
  private readonly loginService = inject(LoginService);
  private readonly router = inject(Router);
  private readonly cartService = inject(CartService);
  private readonly cartItemService = inject(CartItemService);

  ngOnInit(): void {
    // if already authenticated then navigate to home page
    this.accountService.identity().subscribe(() => {
      if (this.accountService.isAuthenticated()) {
        this.router.navigate(['']);
      }
    });
  }

  ngAfterViewInit(): void {
    this.username().nativeElement.focus();
  }

  login(): void {
    this.loginService.login(this.loginForm.getRawValue()).subscribe({
      next: () => {
        this.authenticationError.set(false);
        if (!this.router.getCurrentNavigation()) {
          // There were no routing during login (eg from navigationToStoredUrl)
          this.transferCookieItemsToCart();
          this.router.navigate(['']);
        }
      },
      error: () => this.authenticationError.set(true),
    });
    //Add merge connection here
  }

  private transferCookieItemsToCart(): void {
    const stored = this.getCookieDirectly('cartItems');
    const cookieItems = stored ? JSON.parse(stored) : [];

    console.log('Cookie items trouvés:', cookieItems);

    if (cookieItems && cookieItems.length > 0) {
      cookieItems.forEach((item: any) => {
        // Utiliser productId si disponible, sinon id
        const productId = item.productId || item.id;

        this.cartItemService.addToCart(productId, item.quantity).subscribe({
          next: () => console.log(`${item.name} ajouté au panier`),
          error: err => console.error('Erreur ajout panier:', err),
        });
      });
      this.removeCookieDirectly('cartItems');
      console.log('Panier cookie vidé');
    } else {
      console.log('Aucun article dans les cookies');
    }
  }
  private getCookieDirectly(name: string): string | null {
    const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    return match ? decodeURIComponent(match[2]) : null;
  }

  private removeCookieDirectly(name: string): void {
    document.cookie = `${name}=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;`;
  }
}
