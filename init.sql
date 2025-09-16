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

INSERT INTO Customer (id, email, first_name, last_name, created_at, password_hash, adress, user_id) VALUES
(1, 'admin', 'Administrator', 'Administrator', CURRENT_TIMESTAMP, '$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC', 'admin street', 1),
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

INSERT INTO product (id, name, sku, price, image) VALUES
(1, 'Nike Air', '20', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg'),
(2, 'Nike P 3000', '30', 150, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-2.jpg'),
(3, 'Nike P 6000', '40', 250, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg'),
(4, 'Pantallon Slim', '25', 30, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg'),
(5, 'Pantallon Regular', '35', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-2.jpg'),
(6, 'Pantallon Cargo', '50', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-3.jpg'),
(7, 'Chemise Blanche', '100', 98, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-1.jpg'),
(8, 'Chemise Bleue', '5', 36, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-2.jpg'),
(9, 'Chemise à Carreaux', '12', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-3.jpg');

INSERT INTO rel_product__category (category_id, product_id) VALUES
(6,1), (6,2), (6,3),
(3,4), (3,5), (3,6),
(2,7), (2,8), (2,9);

COMMIT;


