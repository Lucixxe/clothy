import { Component, Input } from '@angular/core';

@Component({
  selector: 'jhi-article',
  standalone: true,
  imports: [],
  templateUrl: './article.component.html',
  styleUrl: './article.component.scss',
})
export class ArticleComponent {
  @Input() product: any;
}
