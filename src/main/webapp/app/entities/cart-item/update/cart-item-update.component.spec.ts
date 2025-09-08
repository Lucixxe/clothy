import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { ICart } from 'app/entities/cart/cart.model';
import { CartService } from 'app/entities/cart/service/cart.service';
import { IProduct } from 'app/entities/product/product.model';
import { ProductService } from 'app/entities/product/service/product.service';
import { ICustomerOrder } from 'app/entities/customer-order/customer-order.model';
import { CustomerOrderService } from 'app/entities/customer-order/service/customer-order.service';
import { ICartItem } from '../cart-item.model';
import { CartItemService } from '../service/cart-item.service';
import { CartItemFormService } from './cart-item-form.service';

import { CartItemUpdateComponent } from './cart-item-update.component';

describe('CartItem Management Update Component', () => {
  let comp: CartItemUpdateComponent;
  let fixture: ComponentFixture<CartItemUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let cartItemFormService: CartItemFormService;
  let cartItemService: CartItemService;
  let cartService: CartService;
  let productService: ProductService;
  let customerOrderService: CustomerOrderService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [CartItemUpdateComponent],
      providers: [
        provideHttpClient(),
        FormBuilder,
        {
          provide: ActivatedRoute,
          useValue: {
            params: from([{}]),
          },
        },
      ],
    })
      .overrideTemplate(CartItemUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(CartItemUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    cartItemFormService = TestBed.inject(CartItemFormService);
    cartItemService = TestBed.inject(CartItemService);
    cartService = TestBed.inject(CartService);
    productService = TestBed.inject(ProductService);
    customerOrderService = TestBed.inject(CustomerOrderService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('should call Cart query and add missing value', () => {
      const cartItem: ICartItem = { id: 7701 };
      const cart: ICart = { id: 29966 };
      cartItem.cart = cart;

      const cartCollection: ICart[] = [{ id: 29966 }];
      jest.spyOn(cartService, 'query').mockReturnValue(of(new HttpResponse({ body: cartCollection })));
      const additionalCarts = [cart];
      const expectedCollection: ICart[] = [...additionalCarts, ...cartCollection];
      jest.spyOn(cartService, 'addCartToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ cartItem });
      comp.ngOnInit();

      expect(cartService.query).toHaveBeenCalled();
      expect(cartService.addCartToCollectionIfMissing).toHaveBeenCalledWith(
        cartCollection,
        ...additionalCarts.map(expect.objectContaining),
      );
      expect(comp.cartsSharedCollection).toEqual(expectedCollection);
    });

    it('should call Product query and add missing value', () => {
      const cartItem: ICartItem = { id: 7701 };
      const product: IProduct = { id: 21536 };
      cartItem.product = product;

      const productCollection: IProduct[] = [{ id: 21536 }];
      jest.spyOn(productService, 'query').mockReturnValue(of(new HttpResponse({ body: productCollection })));
      const additionalProducts = [product];
      const expectedCollection: IProduct[] = [...additionalProducts, ...productCollection];
      jest.spyOn(productService, 'addProductToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ cartItem });
      comp.ngOnInit();

      expect(productService.query).toHaveBeenCalled();
      expect(productService.addProductToCollectionIfMissing).toHaveBeenCalledWith(
        productCollection,
        ...additionalProducts.map(expect.objectContaining),
      );
      expect(comp.productsSharedCollection).toEqual(expectedCollection);
    });

    it('should call CustomerOrder query and add missing value', () => {
      const cartItem: ICartItem = { id: 7701 };
      const customerOrder: ICustomerOrder = { id: 18791 };
      cartItem.customerOrder = customerOrder;

      const customerOrderCollection: ICustomerOrder[] = [{ id: 18791 }];
      jest.spyOn(customerOrderService, 'query').mockReturnValue(of(new HttpResponse({ body: customerOrderCollection })));
      const additionalCustomerOrders = [customerOrder];
      const expectedCollection: ICustomerOrder[] = [...additionalCustomerOrders, ...customerOrderCollection];
      jest.spyOn(customerOrderService, 'addCustomerOrderToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ cartItem });
      comp.ngOnInit();

      expect(customerOrderService.query).toHaveBeenCalled();
      expect(customerOrderService.addCustomerOrderToCollectionIfMissing).toHaveBeenCalledWith(
        customerOrderCollection,
        ...additionalCustomerOrders.map(expect.objectContaining),
      );
      expect(comp.customerOrdersSharedCollection).toEqual(expectedCollection);
    });

    it('should update editForm', () => {
      const cartItem: ICartItem = { id: 7701 };
      const cart: ICart = { id: 29966 };
      cartItem.cart = cart;
      const product: IProduct = { id: 21536 };
      cartItem.product = product;
      const customerOrder: ICustomerOrder = { id: 18791 };
      cartItem.customerOrder = customerOrder;

      activatedRoute.data = of({ cartItem });
      comp.ngOnInit();

      expect(comp.cartsSharedCollection).toContainEqual(cart);
      expect(comp.productsSharedCollection).toContainEqual(product);
      expect(comp.customerOrdersSharedCollection).toContainEqual(customerOrder);
      expect(comp.cartItem).toEqual(cartItem);
    });
  });

  describe('save', () => {
    it('should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ICartItem>>();
      const cartItem = { id: 2227 };
      jest.spyOn(cartItemFormService, 'getCartItem').mockReturnValue(cartItem);
      jest.spyOn(cartItemService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ cartItem });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: cartItem }));
      saveSubject.complete();

      // THEN
      expect(cartItemFormService.getCartItem).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(cartItemService.update).toHaveBeenCalledWith(expect.objectContaining(cartItem));
      expect(comp.isSaving).toEqual(false);
    });

    it('should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ICartItem>>();
      const cartItem = { id: 2227 };
      jest.spyOn(cartItemFormService, 'getCartItem').mockReturnValue({ id: null });
      jest.spyOn(cartItemService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ cartItem: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: cartItem }));
      saveSubject.complete();

      // THEN
      expect(cartItemFormService.getCartItem).toHaveBeenCalled();
      expect(cartItemService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ICartItem>>();
      const cartItem = { id: 2227 };
      jest.spyOn(cartItemService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ cartItem });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(cartItemService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('compareCart', () => {
      it('should forward to cartService', () => {
        const entity = { id: 29966 };
        const entity2 = { id: 31845 };
        jest.spyOn(cartService, 'compareCart');
        comp.compareCart(entity, entity2);
        expect(cartService.compareCart).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareProduct', () => {
      it('should forward to productService', () => {
        const entity = { id: 21536 };
        const entity2 = { id: 11926 };
        jest.spyOn(productService, 'compareProduct');
        comp.compareProduct(entity, entity2);
        expect(productService.compareProduct).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareCustomerOrder', () => {
      it('should forward to customerOrderService', () => {
        const entity = { id: 18791 };
        const entity2 = { id: 9643 };
        jest.spyOn(customerOrderService, 'compareCustomerOrder');
        comp.compareCustomerOrder(entity, entity2);
        expect(customerOrderService.compareCustomerOrder).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
