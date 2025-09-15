import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApplicationConfigService } from 'app/core/config/application-config.service';

// DTO équivalent à ton CheckOutResultDTO
export interface CheckOutResultDTO {
  orderId: string;
  success: boolean;
  message?: string;
}

@Injectable({ providedIn: 'root' })
export class CheckoutService {
  private readonly http = inject(HttpClient);
  private readonly applicationConfigService = inject(ApplicationConfigService);

  private resourceUrl = this.applicationConfigService.getEndpointFor('api/check-out-order');

  /**
   * Appelle le backend pour finaliser le checkout d’un panier
   * @param cartId l’ID du panier
   */
  checkOut(cartId: number): Observable<CheckOutResultDTO> {
    return this.http.post<CheckOutResultDTO>(`${this.resourceUrl}/${cartId}`, {});
  }
}
