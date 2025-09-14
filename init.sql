CREATE EXTENSION IF NOT EXISTS lo;
SELECT lo_manage('product','image');

BEGIN;
TRUNCATE TABLE cart CASCADE;
TRUNCATE TABLE cart_item CASCADE;
TRUNCATE TABLE category CASCADE;
TRUNCATE TABLE customer CASCADE;
TRUNCATE TABLE customer_order CASCADE;
TRUNCATE TABLE product CASCADE;
ALTER TABLE product ALTER COLUMN image TYPE TEXT;


INSERT INTO Customer (id,email, first_name,last_name, created_at, password_hash, adress, user_id) VALUES
(1, 'admin', 'Administrator', 'Administrator', CURRENT_TIMESTAMP,'$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC', 'admin street',1),
(2, 'user', 'User', 'User', CURRENT_TIMESTAMP, '$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K', 'User street', 2);

INSERT INTO Cart (id, cart_key, created_at, is_checked_out, customer_id) VALUES
(1, 'f68484c0-f7a0-4784-8aff-5bb42ff74a97', CURRENT_TIMESTAMP, false, 1),
(2, 'b8b211a6-47e8-41b9-8f7c-ba8ecfdcf5e8', CURRENT_TIMESTAMP, false, 2);

INSERT INTO category (id, name, slug, is_active) VALUES
(1, 'Pantallon', 'pantallon', true),
(2, 'Chemise', 'chemise', true),
(3, 'Homme', 'homme', true),
(4, 'Femme', 'femme', true),
(5, 'Enfants', 'enfants', true),
(6, 'Chaussures', 'chaussures', true);

-- Option 1: Insérer les produits sans images pour le moment
INSERT INTO product (id, name, sku, price, image) VALUES
(1, 'Nike Air',         '20', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7SDL644KD9F8IWQBOEKB%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T143452Z&X-Amz-Expires=39600&X-Amz-Signature=9868bc5c0318c5610d322cb366121cf9ab870ce2b8a5afba9de64c32a88430b1&X-Amz-SignedHeaders=host&x-id=GetObject'),
(2, 'Nike P 3000',      '30', 150,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject'),
(3, 'Nike P 6000',      '40', 250,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject');

INSERT INTO product (id, name, sku, price, image) VALUES
(4, 'Pantallon Slim',   '25', 30,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject'),
(5, 'Pantallon Regular','35', 45,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject'),
(6, 'Pantallon Cargo',  '50', 39,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject');

INSERT INTO product (id, name, sku, price, image) VALUES
(7, 'Chemise Blanche',  '100',98,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject'),
(8, 'Chemise Bleue',    '5',  36,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject'),
(9, 'Chemise à Carreaux','12',59,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=PBKYNLBAGF04H3AXNHVK%2F20250912%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250912T142759Z&X-Amz-Expires=43200&X-Amz-Signature=898214b434cab5a9ca4c723260451d42d4ef9ce6d11a24bb08603676d8cf3d73&X-Amz-SignedHeaders=host&x-id=GetObject');

-- Relations produit/catégorie
INSERT INTO rel_product__category (category_id, product_id) VALUES
(6,1),(6,2),(6,3),
(1,4),(1,5),(1,6),
(2,7),(2,8),(2,9);

COMMIT;


