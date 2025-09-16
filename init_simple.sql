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
(1, 'Pantalon', 'pantalon', true),
(2, 'Chemise', 'chemise', true),
(3, 'Homme', 'homme', true),
(4, 'Femme', 'femme', true),
(5, 'Enfants', 'enfants', true),
(6, 'Chaussures', 'chaussures', true);

INSERT INTO product (id, name, sku, price, image) VALUES
(1, 'Nike Air', '20', 100, '/content/images/chaussures-1.jpg'),
(2, 'Nike P 3000', '30', 150, '/content/images/chaussures-2.jpg'),
(3, 'Nike P 6000', '40', 250, '/content/images/chaussures-3.jpg'),
(4, 'Pantalon Slim', '25', 30, '/content/images/pantalon-1.jpg'),
(5, 'Pantalon Regular', '35', 45, '/content/images/pantalon-2.jpg'),
(6, 'Pantalon Cargo', '50', 39, '/content/images/pantalon-3.jpg'),
(7, 'Chemise Blanche', '100', 98, '/content/images/chemise-1.jpg'),
(8, 'Chemise Bleue', '5', 36, '/content/images/chemise-2.jpg'),
(9, 'Chemise à Carreaux', '12', 59, '/content/images/chemise-3.jpg'),
(10, 'Sneakers Running', '18', 120, '/content/images/chaussures-4.jpg'),
(11, 'Bottes en Cuir', '8', 180, '/content/images/chaussures-5.jpg'),
(12, 'Derbies Classiques', '15', 140, '/content/images/chaussures-6.jpg'),
(13, 'Pantalon Chino', '22', 49, '/content/images/pantalon-4.jpg'),
(14, 'Jeans Slim', '28', 59, '/content/images/pantalon-5.jpg'),
(15, 'Jeans Regular', '32', 55, '/content/images/pantalon-6.jpg'),
(16, 'Chemise Oxford', '14', 45, '/content/images/chemise-4.jpg'),
(17, 'Chemise Noire', '9', 39, '/content/images/chemise-5.jpg'),
(18, 'Chemise en Lin', '7', 65, '/content/images/chemise-6.jpg'),
(19, 'Chaussures de Ville', '11', 130, '/content/images/chaussures-7.jpg'),
(20, 'Baskets Lifestyle', '26', 110, '/content/images/chaussures-8.jpg'),
(21, 'Pantalon Jogger', '19', 35, '/content/images/pantalon-7.jpg'),
(22, 'Pantalon de Costume', '12', 89, '/content/images/pantalon-8.jpg'),
(23, 'Chemise Rayée', '16', 49, '/content/images/chemise-7.jpg'),
(24, 'Chemise Coupe Slim', '21', 55, '/content/images/chemise-8.jpg');

INSERT INTO rel_product__category (category_id, product_id) VALUES
(3,1), (6,1),
(3,2), (6,2),
(3,3), (6,3),
(1,4), (3,4),
(1,5), (3,5),
(1,6), (3,6),
(2,7), (3,7),
(2,8), (3,8),
(2,9), (3,9),
(6,10), (3,10),
(6,11), (3,11),
(6,12), (3,12),
(1,13), (3,13),
(1,14), (3,14),
(1,15), (3,15),
(2,16), (3,16),
(2,17), (3,17),
(2,18), (3,18),
(6,19), (3,19),
(6,20), (3,20),
(1,21), (3,21),
(1,22), (3,22),
(2,23), (3,23),
(2,24), (3,24);

COMMIT;