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

describe('CustomerOrder e2e test', () => {
  const customerOrderPageUrl = '/customer-order';
  const customerOrderPageUrlPattern = new RegExp('/customer-order(\\?.*)?$');
  const username = Cypress.env('E2E_USERNAME') ?? 'user';
  const password = Cypress.env('E2E_PASSWORD') ?? 'user';
  const customerOrderSample = { orderNumber: 'décider pacifique bon', createdAt: '2025-09-08T03:51:58.811Z', total: 27955.39 };

  let customerOrder;

  beforeEach(() => {
    cy.login(username, password);
  });

  beforeEach(() => {
    cy.intercept('GET', '/api/customer-orders+(?*|)').as('entitiesRequest');
    cy.intercept('POST', '/api/customer-orders').as('postEntityRequest');
    cy.intercept('DELETE', '/api/customer-orders/*').as('deleteEntityRequest');
  });

  afterEach(() => {
    if (customerOrder) {
      cy.authenticatedRequest({
        method: 'DELETE',
        url: `/api/customer-orders/${customerOrder.id}`,
      }).then(() => {
        customerOrder = undefined;
      });
    }
  });

  it('CustomerOrders menu should load CustomerOrders page', () => {
    cy.visit('/');
    cy.clickOnEntityMenuItem('customer-order');
    cy.wait('@entitiesRequest').then(({ response }) => {
      if (response?.body.length === 0) {
        cy.get(entityTableSelector).should('not.exist');
      } else {
        cy.get(entityTableSelector).should('exist');
      }
    });
    cy.getEntityHeading('CustomerOrder').should('exist');
    cy.url().should('match', customerOrderPageUrlPattern);
  });

  describe('CustomerOrder page', () => {
    describe('create button click', () => {
      beforeEach(() => {
        cy.visit(customerOrderPageUrl);
        cy.wait('@entitiesRequest');
      });

      it('should load create CustomerOrder page', () => {
        cy.get(entityCreateButtonSelector).click();
        cy.url().should('match', new RegExp('/customer-order/new$'));
        cy.getEntityCreateUpdateHeading('CustomerOrder');
        cy.get(entityCreateSaveButtonSelector).should('exist');
        cy.get(entityCreateCancelButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', customerOrderPageUrlPattern);
      });
    });

    describe('with existing value', () => {
      beforeEach(() => {
        cy.authenticatedRequest({
          method: 'POST',
          url: '/api/customer-orders',
          body: customerOrderSample,
        }).then(({ body }) => {
          customerOrder = body;

          cy.intercept(
            {
              method: 'GET',
              url: '/api/customer-orders+(?*|)',
              times: 1,
            },
            {
              statusCode: 200,
              body: [customerOrder],
            },
          ).as('entitiesRequestInternal');
        });

        cy.visit(customerOrderPageUrl);

        cy.wait('@entitiesRequestInternal');
      });

      it('detail button click should load details CustomerOrder page', () => {
        cy.get(entityDetailsButtonSelector).first().click();
        cy.getEntityDetailsHeading('customerOrder');
        cy.get(entityDetailsBackButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', customerOrderPageUrlPattern);
      });

      it('edit button click should load edit CustomerOrder page and go back', () => {
        cy.get(entityEditButtonSelector).first().click();
        cy.getEntityCreateUpdateHeading('CustomerOrder');
        cy.get(entityCreateSaveButtonSelector).should('exist');
        cy.get(entityCreateCancelButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', customerOrderPageUrlPattern);
      });

      it('edit button click should load edit CustomerOrder page and save', () => {
        cy.get(entityEditButtonSelector).first().click();
        cy.getEntityCreateUpdateHeading('CustomerOrder');
        cy.get(entityCreateSaveButtonSelector).click();
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', customerOrderPageUrlPattern);
      });

      it('last delete button click should delete instance of CustomerOrder', () => {
        cy.get(entityDeleteButtonSelector).last().click();
        cy.getEntityDeleteDialogHeading('customerOrder').should('exist');
        cy.get(entityConfirmDeleteButtonSelector).click();
        cy.wait('@deleteEntityRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(204);
        });
        cy.wait('@entitiesRequest').then(({ response }) => {
          expect(response?.statusCode).to.equal(200);
        });
        cy.url().should('match', customerOrderPageUrlPattern);

        customerOrder = undefined;
      });
    });
  });

  describe('new CustomerOrder page', () => {
    beforeEach(() => {
      cy.visit(`${customerOrderPageUrl}`);
      cy.get(entityCreateButtonSelector).click();
      cy.getEntityCreateUpdateHeading('CustomerOrder');
    });

    it('should create an instance of CustomerOrder', () => {
      cy.get(`[data-cy="orderNumber"]`).type('personnel');
      cy.get(`[data-cy="orderNumber"]`).should('have.value', 'personnel');

      cy.get(`[data-cy="createdAt"]`).type('2025-09-07T12:31');
      cy.get(`[data-cy="createdAt"]`).blur();
      cy.get(`[data-cy="createdAt"]`).should('have.value', '2025-09-07T12:31');

      cy.get(`[data-cy="total"]`).type('27761.74');
      cy.get(`[data-cy="total"]`).should('have.value', '27761.74');

      cy.get(entityCreateSaveButtonSelector).click();

      cy.wait('@postEntityRequest').then(({ response }) => {
        expect(response?.statusCode).to.equal(201);
        customerOrder = response.body;
      });
      cy.wait('@entitiesRequest').then(({ response }) => {
        expect(response?.statusCode).to.equal(200);
      });
      cy.url().should('match', customerOrderPageUrlPattern);
    });
  });
});
