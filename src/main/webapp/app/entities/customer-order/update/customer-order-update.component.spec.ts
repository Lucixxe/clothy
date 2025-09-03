import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse, provideHttpClient } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Subject, from, of } from 'rxjs';

import { ICustomer } from 'app/entities/customer/customer.model';
import { CustomerService } from 'app/entities/customer/service/customer.service';
import { IAddress } from 'app/entities/address/address.model';
import { AddressService } from 'app/entities/address/service/address.service';
import { ICustomerOrder } from '../customer-order.model';
import { CustomerOrderService } from '../service/customer-order.service';
import { CustomerOrderFormService } from './customer-order-form.service';

import { CustomerOrderUpdateComponent } from './customer-order-update.component';

describe('CustomerOrder Management Update Component', () => {
  let comp: CustomerOrderUpdateComponent;
  let fixture: ComponentFixture<CustomerOrderUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let customerOrderFormService: CustomerOrderFormService;
  let customerOrderService: CustomerOrderService;
  let customerService: CustomerService;
  let addressService: AddressService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [CustomerOrderUpdateComponent],
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
      .overrideTemplate(CustomerOrderUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(CustomerOrderUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    customerOrderFormService = TestBed.inject(CustomerOrderFormService);
    customerOrderService = TestBed.inject(CustomerOrderService);
    customerService = TestBed.inject(CustomerService);
    addressService = TestBed.inject(AddressService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('should call Customer query and add missing value', () => {
      const customerOrder: ICustomerOrder = { id: 9643 };
      const customer: ICustomer = { id: 26915 };
      customerOrder.customer = customer;

      const customerCollection: ICustomer[] = [{ id: 26915 }];
      jest.spyOn(customerService, 'query').mockReturnValue(of(new HttpResponse({ body: customerCollection })));
      const additionalCustomers = [customer];
      const expectedCollection: ICustomer[] = [...additionalCustomers, ...customerCollection];
      jest.spyOn(customerService, 'addCustomerToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ customerOrder });
      comp.ngOnInit();

      expect(customerService.query).toHaveBeenCalled();
      expect(customerService.addCustomerToCollectionIfMissing).toHaveBeenCalledWith(
        customerCollection,
        ...additionalCustomers.map(expect.objectContaining),
      );
      expect(comp.customersSharedCollection).toEqual(expectedCollection);
    });

    it('should call Address query and add missing value', () => {
      const customerOrder: ICustomerOrder = { id: 9643 };
      const shippingAddress: IAddress = { id: 2318 };
      customerOrder.shippingAddress = shippingAddress;

      const addressCollection: IAddress[] = [{ id: 2318 }];
      jest.spyOn(addressService, 'query').mockReturnValue(of(new HttpResponse({ body: addressCollection })));
      const additionalAddresses = [shippingAddress];
      const expectedCollection: IAddress[] = [...additionalAddresses, ...addressCollection];
      jest.spyOn(addressService, 'addAddressToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ customerOrder });
      comp.ngOnInit();

      expect(addressService.query).toHaveBeenCalled();
      expect(addressService.addAddressToCollectionIfMissing).toHaveBeenCalledWith(
        addressCollection,
        ...additionalAddresses.map(expect.objectContaining),
      );
      expect(comp.addressesSharedCollection).toEqual(expectedCollection);
    });

    it('should update editForm', () => {
      const customerOrder: ICustomerOrder = { id: 9643 };
      const customer: ICustomer = { id: 26915 };
      customerOrder.customer = customer;
      const shippingAddress: IAddress = { id: 2318 };
      customerOrder.shippingAddress = shippingAddress;

      activatedRoute.data = of({ customerOrder });
      comp.ngOnInit();

      expect(comp.customersSharedCollection).toContainEqual(customer);
      expect(comp.addressesSharedCollection).toContainEqual(shippingAddress);
      expect(comp.customerOrder).toEqual(customerOrder);
    });
  });

  describe('save', () => {
    it('should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ICustomerOrder>>();
      const customerOrder = { id: 18791 };
      jest.spyOn(customerOrderFormService, 'getCustomerOrder').mockReturnValue(customerOrder);
      jest.spyOn(customerOrderService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ customerOrder });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: customerOrder }));
      saveSubject.complete();

      // THEN
      expect(customerOrderFormService.getCustomerOrder).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(customerOrderService.update).toHaveBeenCalledWith(expect.objectContaining(customerOrder));
      expect(comp.isSaving).toEqual(false);
    });

    it('should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ICustomerOrder>>();
      const customerOrder = { id: 18791 };
      jest.spyOn(customerOrderFormService, 'getCustomerOrder').mockReturnValue({ id: null });
      jest.spyOn(customerOrderService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ customerOrder: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: customerOrder }));
      saveSubject.complete();

      // THEN
      expect(customerOrderFormService.getCustomerOrder).toHaveBeenCalled();
      expect(customerOrderService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ICustomerOrder>>();
      const customerOrder = { id: 18791 };
      jest.spyOn(customerOrderService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ customerOrder });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(customerOrderService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('compareCustomer', () => {
      it('should forward to customerService', () => {
        const entity = { id: 26915 };
        const entity2 = { id: 21032 };
        jest.spyOn(customerService, 'compareCustomer');
        comp.compareCustomer(entity, entity2);
        expect(customerService.compareCustomer).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareAddress', () => {
      it('should forward to addressService', () => {
        const entity = { id: 2318 };
        const entity2 = { id: 19327 };
        jest.spyOn(addressService, 'compareAddress');
        comp.compareAddress(entity, entity2);
        expect(addressService.compareAddress).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
