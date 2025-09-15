CREATE EXTENSION IF NOT EXISTS lo;
SELECT lo_manage('product','image');

BEGIN;
TRUNCATE TABLE cart CASCADE;
TRUNCATE TABLE cart_item CASCADE;
TRUNCATE TABLE category CASCADE;
TRUNCATE TABLE customer CASCADE;
TRUNCATE TABLE customer_order CASCADE;
TRUNCATE TABLE product CASCADE;
TRUNCATE TABLE rel_product__category CASCADE;
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
(1, 'Nike Air',         '20', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T082056Z&X-Amz-Expires=43200&X-Amz-Signature=5e26f054d87eb884bc52e45efeb3891b8c317eb9d89ca87c0c0558fa92afcebb&X-Amz-SignedHeaders=host&x-id=GetObject'),
(2, 'Nike P 3000',      '30', 150,'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094550Z&X-Amz-Expires=43200&X-Amz-Signature=c3053dda30bfe55018dee7684624f4caffc8d6152d1e4ad0288c81ce431a5a33&X-Amz-SignedHeaders=host&x-id=GetObject'),
(3, 'Nike P 6000',      '40', 250,'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094617Z&X-Amz-Expires=43200&X-Amz-Signature=abbd2240efe8dc6ffe65dfb6239f96de597d85ba7a05a25a3777af0b056abfed&X-Amz-SignedHeaders=host&x-id=GetObject');

INSERT INTO product (id, name, sku, price, image) VALUES
(4, 'Pantallon Slim',   '25', 30,'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094634Z&X-Amz-Expires=43200&X-Amz-Signature=0aa11d5d8e7708aa8bb34c8b764603d0f23430eb6d09d391ca6f5d9f743a2bbc&X-Amz-SignedHeaders=host&x-id=GetObject'),
(5, 'Pantallon Regular','35', 45,'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094649Z&X-Amz-Expires=43200&X-Amz-Signature=fdc7e5f0887510e1cb8e4eae6953d90d9fe09c28b07a40e8f395904211ad2420&X-Amz-SignedHeaders=host&x-id=GetObject'),
(6, 'Pantallon Cargo',  '50', 39,'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094702Z&X-Amz-Expires=43200&X-Amz-Signature=dab7b853313eacf77be1b8e11639961f21a4883ec32956a61894466fc4cf7d36&X-Amz-SignedHeaders=host&x-id=GetObject');

INSERT INTO product (id, name, sku, price, image) VALUES
(7, 'Chemise Blanche',  '100',98,'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094715Z&X-Amz-Expires=43200&X-Amz-Signature=0a73ae89ccd1f654522f9519509934aabe9d7ba3ac88457372b2a17f12fcdc3e&X-Amz-SignedHeaders=host&x-id=GetObject'),
(8, 'Chemise Bleue',    '5',  36,'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094726Z&X-Amz-Expires=43200&X-Amz-Signature=c87992621ca166d72b3c15fa4dd43afb8e8213a6b67c84ba65ec87eac3290392&X-Amz-SignedHeaders=host&x-id=GetObject'),
(9, 'Chemise à Carreaux','12',59,'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=90MDR71ZO2DOOPXHKOY2%2F20250915%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250915T094738Z&X-Amz-Expires=43200&X-Amz-Signature=1ba427c7247d67e870375e1f571b1028c0f61672222d5a74494cdaca9da55b8b&X-Amz-SignedHeaders=host&x-id=GetObject');

-- Relations produit/catégorie
INSERT INTO rel_product__category (category_id, product_id) VALUES
(6,1),(6,2),(6,3),
(1,4),(1,5),(1,6),
(2,7),(2,8),(2,9);

COMMIT;


