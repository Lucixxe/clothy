import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

import dayjs from 'dayjs/esm';
import { DATE_TIME_FORMAT } from 'app/config/input.constants';
import { ICustomerOrder, NewCustomerOrder } from '../customer-order.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts ICustomerOrder for edit and NewCustomerOrderFormGroupInput for create.
 */
type CustomerOrderFormGroupInput = ICustomerOrder | PartialWithRequiredKeyOf<NewCustomerOrder>;

/**
 * Type that converts some properties for forms.
 */
type FormValueOf<T extends ICustomerOrder | NewCustomerOrder> = Omit<T, 'createdAt'> & {
  createdAt?: string | null;
};

type CustomerOrderFormRawValue = FormValueOf<ICustomerOrder>;

type NewCustomerOrderFormRawValue = FormValueOf<NewCustomerOrder>;

type CustomerOrderFormDefaults = Pick<NewCustomerOrder, 'id' | 'createdAt'>;

type CustomerOrderFormGroupContent = {
  id: FormControl<CustomerOrderFormRawValue['id'] | NewCustomerOrder['id']>;
  orderNumber: FormControl<CustomerOrderFormRawValue['orderNumber']>;
  createdAt: FormControl<CustomerOrderFormRawValue['createdAt']>;
  total: FormControl<CustomerOrderFormRawValue['total']>;
  customer: FormControl<CustomerOrderFormRawValue['customer']>;
};

export type CustomerOrderFormGroup = FormGroup<CustomerOrderFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class CustomerOrderFormService {
  createCustomerOrderFormGroup(customerOrder: CustomerOrderFormGroupInput = { id: null }): CustomerOrderFormGroup {
    const customerOrderRawValue = this.convertCustomerOrderToCustomerOrderRawValue({
      ...this.getFormDefaults(),
      ...customerOrder,
    });
    return new FormGroup<CustomerOrderFormGroupContent>({
      id: new FormControl(
        { value: customerOrderRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      orderNumber: new FormControl(customerOrderRawValue.orderNumber, {
        validators: [Validators.required],
      }),
      createdAt: new FormControl(customerOrderRawValue.createdAt, {
        validators: [Validators.required],
      }),
      total: new FormControl(customerOrderRawValue.total, {
        validators: [Validators.required],
      }),
      customer: new FormControl(customerOrderRawValue.customer),
    });
  }

  getCustomerOrder(form: CustomerOrderFormGroup): ICustomerOrder | NewCustomerOrder {
    return this.convertCustomerOrderRawValueToCustomerOrder(form.getRawValue() as CustomerOrderFormRawValue | NewCustomerOrderFormRawValue);
  }

  resetForm(form: CustomerOrderFormGroup, customerOrder: CustomerOrderFormGroupInput): void {
    const customerOrderRawValue = this.convertCustomerOrderToCustomerOrderRawValue({ ...this.getFormDefaults(), ...customerOrder });
    form.reset(
      {
        ...customerOrderRawValue,
        id: { value: customerOrderRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): CustomerOrderFormDefaults {
    const currentTime = dayjs();

    return {
      id: null,
      createdAt: currentTime,
    };
  }

  private convertCustomerOrderRawValueToCustomerOrder(
    rawCustomerOrder: CustomerOrderFormRawValue | NewCustomerOrderFormRawValue,
  ): ICustomerOrder | NewCustomerOrder {
    return {
      ...rawCustomerOrder,
      createdAt: dayjs(rawCustomerOrder.createdAt, DATE_TIME_FORMAT),
    };
  }

  private convertCustomerOrderToCustomerOrderRawValue(
    customerOrder: ICustomerOrder | (Partial<NewCustomerOrder> & CustomerOrderFormDefaults),
  ): CustomerOrderFormRawValue | PartialWithRequiredKeyOf<NewCustomerOrderFormRawValue> {
    return {
      ...customerOrder,
      createdAt: customerOrder.createdAt ? customerOrder.createdAt.format(DATE_TIME_FORMAT) : undefined,
    };
  }
}
