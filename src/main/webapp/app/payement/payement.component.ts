import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'jhi-payement',
  templateUrl: './payement.component.html',
  styleUrls: ['./payement.component.scss'],
  imports: [CommonModule, ReactiveFormsModule],
})
export class PayementComponent {
  payementForm: FormGroup;
  submitted = false;

  constructor(private fb: FormBuilder) {
    this.payementForm = this.fb.group({
      nom: ['', [Validators.required, Validators.minLength(2)]],
      numeroCarte: ['', [Validators.required, Validators.pattern('^[0-9]{16}$')]],
      dateExpiration: ['', [Validators.required, Validators.pattern('^(0[1-9]|1[0-2])\\/([0-9]{2})$')]],
      cvv: ['', [Validators.required, Validators.pattern('^[0-9]{3,4}$')]],
    });
  }

  get f() {
    return this.payementForm.controls;
  }

  onSubmit(): void {
    this.submitted = true;

    if (this.payementForm.invalid) {
      return;
    }

    // Ici tu peux appeler ton service backend pour traiter le paiement
    console.log('Paiement réussi : ', this.payementForm.value);
    alert('Paiement effectué avec succès !');
  }
}
