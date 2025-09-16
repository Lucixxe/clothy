import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { TranslateDirective } from 'app/shared/language';

@Component({
  selector: 'jhi-footer',
  templateUrl: './footer.component.html',
  imports: [TranslateDirective, RouterLink],
})
export default class FooterComponent {}
