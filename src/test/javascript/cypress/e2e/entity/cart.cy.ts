import {
  entityConfirmDeleteButtonSelector,
  entityCreateButtonSelector,
  entityCreateCancelButtonSelector,
  entityCreateSaveButtonSelector,
  entityDeleteButtonSelector,
  entityDetailsBackButtonSelector,
  entityDetailsButtonSelector,
  entityEditButtonSelector,
  entityTableSelector,
} from '../../support/entity';

describe('Cart e2e test', () => {
  const cartPageUrl = '/cart';
  const cartPageUrlPattern = new RegExp('/cart(\\?.*)?$');
  const username = Cypress.env('E2E_USERNAME') ?? 'user';
  const password = Cypress.env('E2E_PASSWORD') ?? 'user';
  const cartSample = { cartKey: '63b62489-d522-4cd2-91f7-652398a556c6', createdAt: '2025-09-08T07:52:15.784Z', isCheckedOut: false };

  let cart;
  let customer;

  beforeEach(() => {
    cy.login(username, password);
  });

  beforeEach(() => {
    // create an instance at the required relationship entity:
    cy.authenticatedRequest({
      method: 'POST',
      url: '/api/customers',
      body: {
        email: 'Philothee.Arnaud@hotmail.fr',
        firstName: 'Denise',
        lastName: 'Bertrand',
        createdAt: '2025-09-08T07:11:00.356Z',
        passwordHash: 'placide nonobstant ça',
        adress: 'ha tromper',
      },
    }).then(({ body }) => {
      customer = body;
    });
  });

  beforeEach(() => {
    cy.intercept('GET', '/api/carts+(?*|)').as('entitiesRequest');
    cy.intercept('POST', '/api/carts').as('postEntityRequest');
    cy.intercept('DELETE', '/api/carts/*').as('deleteEntityRequest');
  });

  beforeEach(() => {
    // Simulate relationships api for better performance and reproducibility.
    cy.intercept('GET', '/api/customers', {
      statusCode: 200,
      body: [customer],
    });
  });

  afterEach(() => {
    if (cart) {
      cy.authenticatedRequest({
        method: 'DELETE',
        url: `/api/carts/${cart.id}`,
      }).then(() => {
        cart = undefined;
      });
    }
  });

  afterEach(() => {
    if (customer) {
      cy.authenticatedRequest({
        method: 'DELETE',
        url: `/api/customers/${customer.id}`,
      }).then(() => {
        customer = undefined;
      });
    }
  });

  it('Carts menu should load Carts page', () => {
    cy.visit('/');
    cy.clickOnEntityMenuItem('cart');
    cy.wait('@entitiesRequest').then(({ response }) => {
      if (response?.body.length === 0) {
        cy.get(entityTableSelector).should('not.exist');
      } else {
        cy.get(entityTableSelector).should('exist');
      }
    });
    cy.getEntityHeading('Cart').should('exist');
    cy.url().should('match', cartPageUrlPattern);
  });

  describe('Cart page', () => {
    describe('create button click', () => {
      beforeEach(() => {
        cy.visit(cartPageUrl);
        cy.wait('@entitiesRequest');
      });

      it('should load create Cart page', () => {
        cy.get(entityCreateButtonSelector).click();
        cy.url().should('match', new RegExp('/cart/new$'));
        cy.getEntityCreateUpdateHeading('Cart');
        cy.get(entityCreateSaveButtonSelector).should('exist');
        cy.get(entityCreateCancelButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', cartPageUrlPattern);
      });
    });

    describe('with existing value', () => {
      beforeEach(() => {
        cy.authenticatedRequest({
          method: 'POST',
          url: '/api/carts',
          body: {
            ...cartSample,
            customer,
          },
        }).then(({ body }) => {
          cart = body;

          cy.intercept(
            {
              method: 'GET',
              url: '/api/carts+(?*|)',
              times: 1,
            },
            {
              statusCode: 200,
              body: [cart],
            },
          ).as('entitiesRequestInternal');
        });

        cy.visit(cartPageUrl);

        cy.wait('@entitiesRequestInternal');
      });

      it('detail button click should load details Cart page', () => {
        cy.get(entityDetailsButtonSelector).first().click();
        cy.getEntityDetailsHeading('cart');
        cy.get(entityDetailsBackButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', cartPageUrlPattern);
      });

      it('edit button click should load edit Cart page and go back', () => {
        cy.get(entityEditButtonSelector).first().click();
        cy.getEntityCreateUpdateHeading('Cart');
        cy.get(entityCreateSaveButtonSelector).should('exist');
        cy.get(entityCreateCancelButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', cartPageUrlPattern);
      });

      it('edit button click should load edit Cart page and save', () => {
        cy.get(entityEditButtonSelector).first().click();
        cy.getEntityCreateUpdateHeading('Cart');
        cy.get(entityCreateSaveButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', cartPageUrlPattern);
      });

      it('last delete button click should delete instance of Cart', () => {
        cy.get(entityDeleteButtonSelector).last().click();
        cy.getEntityDeleteDialogHeading('cart').should('exist');
        cy.get(entityConfirmDeleteButtonSelector).click();
        cy.wait('@deleteEntityRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(204);
        });
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', cartPageUrlPattern);

        cart = undefined;
      });
    });
  });

  describe('new Cart page', () => {
    beforeEach(() => {
      cy.visit(`${cartPageUrl}`);
      cy.get(entityCreateButtonSelector).click();
      cy.getEntityCreateUpdateHeading('Cart');
    });

    it('should create an instance of Cart', () => {
      cy.get(`[data-cy="cartKey"]`).type('ca067de6-76de-4c1b-9919-49ef1e5c53e7');
      cy.get(`[data-cy="cartKey"]`).invoke('val').should('match', new RegExp('ca067de6-76de-4c1b-9919-49ef1e5c53e7'));

      cy.get(`[data-cy="createdAt"]`).type('2025-09-08T07:45');
      cy.get(`[data-cy="createdAt"]`).blur();
      cy.get(`[data-cy="createdAt"]`).should('have.value', '2025-09-08T07:45');

      cy.get(`[data-cy="isCheckedOut"]`).should('not.be.checked');
      cy.get(`[data-cy="isCheckedOut"]`).click();
      cy.get(`[data-cy="isCheckedOut"]`).should('be.checked');

      cy.get(`[data-cy="customer"]`).select(1);

      cy.get(entityCreateSaveButtonSelector).click();

      cy.wait('@postEntityRequest').then(({ response }) => {
        expect(response?.statusCode).to.equal(201);
        cart = response.body;
      });
      cy.wait('@entitiesRequest').then(({ response }) => {
        expect(response?.statusCode).to.equal(200);
      });
      cy.url().should('match', cartPageUrlPattern);
    });
  });
});
