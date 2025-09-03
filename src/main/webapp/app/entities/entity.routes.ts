import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'authority',
    data: { pageTitle: 'clothyApp.adminAuthority.home.title' },
    loadChildren: () => import('./admin/authority/authority.routes'),
  },
  {
    path: 'category',
    data: { pageTitle: 'clothyApp.category.home.title' },
    loadChildren: () => import('./category/category.routes'),
  },
  {
    path: 'product',
    data: { pageTitle: 'clothyApp.product.home.title' },
    loadChildren: () => import('./product/product.routes'),
  },
  {
    path: 'customer',
    data: { pageTitle: 'clothyApp.customer.home.title' },
    loadChildren: () => import('./customer/customer.routes'),
  },
  {
    path: 'address',
    data: { pageTitle: 'clothyApp.address.home.title' },
    loadChildren: () => import('./address/address.routes'),
  },
  {
    path: 'cart',
    data: { pageTitle: 'clothyApp.cart.home.title' },
    loadChildren: () => import('./cart/cart.routes'),
  },
  {
    path: 'cart-item',
    data: { pageTitle: 'clothyApp.cartItem.home.title' },
    loadChildren: () => import('./cart-item/cart-item.routes'),
  },
  {
    path: 'customer-order',
    data: { pageTitle: 'clothyApp.customerOrder.home.title' },
    loadChildren: () => import('./customer-order/customer-order.routes'),
  },
  {
    path: 'order-item',
    data: { pageTitle: 'clothyApp.orderItem.home.title' },
    loadChildren: () => import('./order-item/order-item.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
