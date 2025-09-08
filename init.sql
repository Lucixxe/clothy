TRUNCATE TABLE cart CASCADE;
TRUNCATE TABLE cart_item CASCADE;
TRUNCATE TABLE category CASCADE;
TRUNCATE TABLE customer CASCADE;
TRUNCATE TABLE customer_order CASCADE;
TRUNCATE TABLE product CASCADE;

INSERT INTO category (id, name, slug, is_active) VALUES
(1, 'Pantallon', 'pantallon', true),
(2, 'Chemise', 'chemise', true),
(3, 'Homme', 'homme', true),
(4, 'Femme', 'femme', true),
(5, 'Enfants', 'enfants', true),
(6, 'Chaussures', 'chaussures', true);


-- Ajout des produits Chaussures
INSERT INTO product (id, name, sku, price) VALUES
(1, 'Nike Air', '20', 250),
(2, 'Nike P 3000', '20', 250),
(3, 'Nike P 6000', '40', 250);

-- Ajout des produits Pantallons
INSERT INTO product (id, name, sku, price) VALUES
(4, 'Pantallon Slim', '25', 250),
(5, 'Pantallon Regular', '35', 250),
(6, 'Pantallon Cargo', '20', 250);

-- Ajout des produits Chemises
INSERT INTO product (id, name, sku, price) VALUES
(7, 'Chemise Blanche', '100', 250),
(8, 'Chemise Bleue', '5', 250),
(9, 'Chemise à Carreaux', '12', 250);


