import { AfterViewInit, Component, ElementRef, inject, signal, viewChild } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { Router, RouterModule } from '@angular/router';
import { FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';

import { EMAIL_ALREADY_USED_TYPE, LOGIN_ALREADY_USED_TYPE } from 'app/config/error.constants';
import SharedModule from 'app/shared/shared.module';
import PasswordStrengthBarComponent from '../password/password-strength-bar/password-strength-bar.component';
import { RegisterService } from './register.service';

@Component({
  selector: 'jhi-register',
  imports: [SharedModule, RouterModule, FormsModule, ReactiveFormsModule, PasswordStrengthBarComponent],
  templateUrl: './register.component.html',
})
export default class RegisterComponent implements AfterViewInit {
  // Référence au premier champ
  firstNameInput = viewChild.required<ElementRef>('firstNameInput');

  passwordMismatch = signal(false);
  error = signal(false);
  errorEmailExists = signal(false);
  errorUserExists = signal(false);
  success = signal(false);
  submitted = false;

  registerForm = new FormGroup({
    firstName: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
    lastName: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
    email: new FormControl('', { nonNullable: true, validators: [Validators.required, Validators.email] }),
    address: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
    password: new FormControl('', { nonNullable: true, validators: [Validators.required, Validators.minLength(4)] }),
    confirmPassword: new FormControl('', { nonNullable: true, validators: [Validators.required] }),
    terms: new FormControl(false, { nonNullable: true, validators: [Validators.requiredTrue] }),
  });

  private readonly translateService = inject(TranslateService);
  private readonly registerService = inject(RegisterService);
  private readonly router = inject(Router);

  ngAfterViewInit(): void {
    this.firstNameInput().nativeElement.focus();
  }

  onSubmit(): void {
    this.submitted = true;
    this.passwordMismatch.set(false);
    this.error.set(false);
    this.errorEmailExists.set(false);
    this.errorUserExists.set(false);

    // Réinitialiser l'état de touched pour afficher les erreurs
    Object.keys(this.registerForm.controls).forEach(key => {
      const control = this.registerForm.get(key);
      control?.markAsTouched();
    });

    // Vérifier si le formulaire est valide
    if (this.registerForm.invalid) {
      return;
    }

    const { password, confirmPassword, email, firstName, lastName } = this.registerForm.getRawValue();

    // Vérification mot de passe (redondante mais sécurisée)
    if (password !== confirmPassword) {
      this.passwordMismatch.set(true);
      return;
    }

    // Générer un login à partir du prénom et nom (ou utiliser l'email)
    const login = this.generateLogin(firstName, lastName);

    // Envoi au backend JHipster
    this.registerService
      .save({
        login: email,
        email,
        password,
        langKey: this.translateService.currentLang,
        firstName: firstName,
        lastName: lastName,
        imageUrl: this.registerForm.getRawValue().address,
      })
      .subscribe({
        next: () => {
          this.success.set(true);
          this.router.navigate(['/']); // ✅ redirection vers la page d'accueil après succès
        },
        error: response => this.processError(response),
      });

    console.log(this.firstNameInput, ' ', password, ' ', email);
  }

  // Méthode pour générer un login unique
  private generateLogin(firstName: string, lastName: string): string {
    const baseLogin = `${firstName.toLowerCase()}.${lastName.toLowerCase()}`;
    const timestamp = new Date().getTime().toString().slice(-4);
    return `${baseLogin}${timestamp}`;
  }

  private generateLoginFromEmail(email: string): string {
    return email.split('@')[0];
  }

  private processError(response: HttpErrorResponse): void {
    if (response.status === 400 && response.error.type === LOGIN_ALREADY_USED_TYPE) {
      this.errorUserExists.set(true);
    } else if (response.status === 400 && response.error.type === EMAIL_ALREADY_USED_TYPE) {
      this.errorEmailExists.set(true);
    } else {
      this.error.set(true);
    }
  }

  checkPasswordMatch(): boolean {
    const password = this.registerForm.get('password')?.value;
    const confirmPassword = this.registerForm.get('confirmPassword')?.value;
    return password === confirmPassword;
  }
}
