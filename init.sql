CREATE EXTENSION IF NOT EXISTS lo;
SELECT lo_manage('product','image');

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


INSERT INTO product (id, name, sku, price, image, image_content_type) VALUES
(1, 'Nike Air',         '20', 250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg'),
(2, 'Nike P 3000',      '30', 250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg'),
(3, 'Nike P 6000',      '40', 250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg');

INSERT INTO product (id, name, sku, price, image, image_content_type) VALUES
(4, 'Pantallon Slim',   '25', 250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg'),
(5, 'Pantallon Regular','35', 250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg'),
(6, 'Pantallon Cargo',  '50', 250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg');

INSERT INTO product (id, name, sku, price, image, image_content_type) VALUES
(7, 'Chemise Blanche',  '100',250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg'),
(8, 'Chemise Bleue',    '5',  250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg'),
(9, 'Chemise à Carreaux','12',250, lo_import('/seed_images/chaussures-1.jpg'),     'image/jpg');

-- Relations produit/catégorie
INSERT INTO rel_product__category (category_id, product_id) VALUES
(6,1),(6,2),(6,3),
(1,4),(1,5),(1,6),
(2,7),(2,8),(2,9);

COMMIT;


