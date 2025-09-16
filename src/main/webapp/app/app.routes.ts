import { Routes } from '@angular/router';

import { Authority } from 'app/config/authority.constants';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { errorRoute } from './layouts/error/error.route';

const routes: Routes = [
  {
    path: '',
    loadComponent: () => import('./home/home.component'),
    title: 'home.title',
  },
  {
    path: '',
    loadComponent: () => import('./layouts/navbar/navbar.component'),
    outlet: 'navbar',
  },
  {
    path: 'product/:id',
    loadComponent: () => import('./product-detail/product-detail.component').then(m => m.ProductDetailComponent),
    title: 'Product Detail',
    data: {
      authorities: [],
    },
  },
  {
    path: 'admin',
    data: {
      authorities: [Authority.ADMIN],
    },
    canActivate: [UserRouteAccessService],
    loadChildren: () => import('./admin/admin.routes'),
  },
  {
    path: 'account',
    loadChildren: () => import('./account/account.route'),
  },
  {
    path: 'login',
    loadComponent: () => import('./login/login.component'),
    title: 'login.title',
  },
  {
    path: '',
    loadChildren: () => import(`./entities/entity.routes`),
  },
  {
    path: 'cart-page',
    loadComponent: () => import('./cart-page/cart-page.component').then(m => m.CartPageComponent),
    title: 'Cart-page',
  },
  {
    path: 'articles-page',
    loadComponent: () => import('./articles-page/articles-page.component').then(m => m.ArticlesPageComponent),
    title: 'Articles-page',
  },
  {
    path: 'payment-success',
    loadComponent: () => import('./payment-success/payment-success.component').then(m => m.PaymentSuccessComponent),
    title: 'Payment Success',
  },
  {
    path: 'payment-cancel',
    loadComponent: () => import('./payment-cancel/payment-cancel.component').then(m => m.PaymentCancelComponent),
    title: 'Payment Cancel',
  },
  ...errorRoute,
];

export default routes;
