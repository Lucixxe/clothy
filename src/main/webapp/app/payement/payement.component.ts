import { Component, inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { AccountService } from 'app/core/auth/account.service';

@Component({
  selector: 'jhi-payement',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './payement.component.html',
  styleUrls: ['./payement.component.scss'],
})
export class PayementComponent implements OnInit {
  payementForm: FormGroup;
  submitted = false;
  private accountService = inject(AccountService);
  private router = inject(Router);

  constructor(private fb: FormBuilder) {
    this.payementForm = this.fb.group({
      nom: ['', [Validators.required, Validators.minLength(2)]],
      numeroCarte: ['', [Validators.required, Validators.pattern('^[0-9]{16}$')]],
      dateExpiration: ['', [Validators.required, Validators.pattern('^(0[1-9]|1[0-2])\\/([0-9]{2})$')]],
      cvv: ['', [Validators.required, Validators.pattern('^[0-9]{3,4}$')]],
    });
  }

  ngOnInit(): void {
    // Vérifie si l'utilisateur est connecté
    if (!this.accountService.identity()) {
      this.router.navigate(['/login']); // redirige vers login si non connecté
    }
  }

  get f() {
    return this.payementForm.controls;
  }

  onSubmit(): void {
    this.submitted = true;

    if (this.payementForm.invalid) {
      return;
    }

    // Traitement du paiement
    console.log('Paiement réussi : ', this.payementForm.value);
    alert('Paiement effectué avec succès !');
  }
}
