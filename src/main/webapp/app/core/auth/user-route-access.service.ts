import { inject, isDevMode } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivateFn, Router, RouterStateSnapshot } from '@angular/router';
import { of } from 'rxjs';
import { map } from 'rxjs/operators';

import { AccountService } from 'app/core/auth/account.service';
import { StateStorageService } from './state-storage.service';

export const UserRouteAccessService: CanActivateFn = (next: ActivatedRouteSnapshot, state: RouterStateSnapshot) => {
  const accountService = inject(AccountService);
  const router = inject(Router);
  const stateStorageService = inject(StateStorageService);

  const { authorities } = next.data;

  // ✅ si aucune restriction → accès public (retourné comme Observable)
  if (!authorities || authorities.length === 0) {
    return of(true);
  }

  return accountService.identity().pipe(
    map(account => {
      if (account && accountService.hasAnyAuthority(authorities)) {
        return true;
      }

      if (account) {
        if (isDevMode()) {
          console.error('User does not have any of the required authorities:', authorities);
        }
        router.navigate(['accessdenied']);
        return false;
      }

      stateStorageService.storeUrl(state.url);
      router.navigate(['/login']);
      return false;
    }),
  );
};
