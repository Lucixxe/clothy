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

INSERT INTO product (id, name, sku, price, image,description) VALUES
(1, 'Nike Air', '20', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=V3S3MVSH4CP6NXQN9N7G%2F20250917%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250917T091223Z&X-Amz-Expires=43200&X-Amz-Signature=a00765f811df0b0ed781af6433cf891cfeb47999c14c7018ceaf89e99119715f&X-Amz-SignedHeaders=host&x-id=GetObject','a'),
(2, 'Nike P 3000', '30', 150, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T123623Z&X-Amz-Expires=43200&X-Amz-Signature=b500858f9b6a0b1407ec79d11658f02ccae09727f8a4ea72f693ff20af8eb9ff&X-Amz-SignedHeaders=host&x-id=GetObject','b'),
(3, 'Nike P 6000', '40', 250, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T123635Z&X-Amz-Expires=43200&X-Amz-Signature=b061e7134471ee38be8f09feaddd7ae558725c4ee4e3dfb285937f5d0f81d1dc&X-Amz-SignedHeaders=host&x-id=GetObject','c'),
(4, 'Pantalon Slim', '25', 30, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=V3S3MVSH4CP6NXQN9N7G%2F20250917%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250917T091119Z&X-Amz-Expires=43200&X-Amz-Signature=807277c1dd8b76101df3c197a138b57b0358364d9c719a2e87f3f0e4a50a8c18&X-Amz-SignedHeaders=host&x-id=GetObject','d'),
(5, 'Pantalon Regular', '35', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T123714Z&X-Amz-Expires=43200&X-Amz-Signature=cef295c19e5616f3ea17d16684a315aa3120b7e60750fb83807bf8c13a2169ae&X-Amz-SignedHeaders=host&x-id=GetObject','e'),
(6, 'Pantalon Cargo', '50', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T123729Z&X-Amz-Expires=43200&X-Amz-Signature=b7145929023966afb8ac5916e36f47e015ac3cca3045fcd0a9e4a7989754ab66&X-Amz-SignedHeaders=host&x-id=GetObject','f'),
(7, 'Chemise Blanche', '100', 98, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=V3S3MVSH4CP6NXQN9N7G%2F20250917%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250917T091145Z&X-Amz-Expires=43200&X-Amz-Signature=85ab13679fa676774fa14bf2abb16c82a98acb2a35fdbf9e4fc6b3cea60a8e32&X-Amz-SignedHeaders=host&x-id=GetObject','g'),
(8, 'Chemise Bleue', '5', 36, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124115Z&X-Amz-Expires=43200&X-Amz-Signature=61ff93effbeffe178dc4898c16b81feccebb416550be90913c9de42b18a2fe92&X-Amz-SignedHeaders=host&x-id=GetObject','h'),
(9, 'Chemise à Carreaux', '12', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124136Z&X-Amz-Expires=43200&X-Amz-Signature=e95ea1fd7008050c0efcba43ae9634db1ef730c168a02d95df9cf9e5fd803c80&X-Amz-SignedHeaders=host&x-id=GetObject','i'),
(10, 'Sneakers Running', '18', 120, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124201Z&X-Amz-Expires=43200&X-Amz-Signature=8debdfee8ca99a5e7176298f7a628156c99b7c889095f3a45395c3b9fd94f410&X-Amz-SignedHeaders=host&x-id=GetObject','j'),
(11, 'Bottes en Cuir', '8', 180, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124215Z&X-Amz-Expires=43200&X-Amz-Signature=7e76694731e0f8130b224c63dc876d24164ff5e1ffffa4fa1dfcbef63f63e1ed&X-Amz-SignedHeaders=host&x-id=GetObject','k'),
(12, 'Derbies Classiques', '15', 140, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124229Z&X-Amz-Expires=43200&X-Amz-Signature=de657043021cbf36616f55ce4d5920ff29862f55e558f6357fa20f85d236410c&X-Amz-SignedHeaders=host&x-id=GetObject','l'),
(13, 'Pantalon Chino', '22', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124243Z&X-Amz-Expires=43200&X-Amz-Signature=2069e80f27dd564a5c845511c853cfb56aaaca893e3c59ef14afeb7b109445b0&X-Amz-SignedHeaders=host&x-id=GetObject','m'),
(14, 'Jeans Slim', '28', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124257Z&X-Amz-Expires=43200&X-Amz-Signature=00911d717e18d83006437ad730be493e66eef7a92bb031521328160aecff77c7&X-Amz-SignedHeaders=host&x-id=GetObject','n'),
(15, 'Jeans Regular', '32', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124308Z&X-Amz-Expires=43200&X-Amz-Signature=18efa44ec62a772f6259dcdea119e2ff32a770464d1b6bcdf1f4f6d535714996&X-Amz-SignedHeaders=host&x-id=GetObject','o'),
(16, 'Chemise Oxford', '14', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124325Z&X-Amz-Expires=43200&X-Amz-Signature=0a7d469d97f812d0f7904e8e4fadcc948b6caa4d50b97a0cdba99f26009df940&X-Amz-SignedHeaders=host&x-id=GetObject','p'),
(17, 'Chemise Noire', '9', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124347Z&X-Amz-Expires=43200&X-Amz-Signature=c8031368ef5adcb24edfa6de3b30b7938fe18b72012605da7bd293a810ac8583&X-Amz-SignedHeaders=host&x-id=GetObject','q'),
(18, 'Chemise en Lin', '7', 65, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124404Z&X-Amz-Expires=43200&X-Amz-Signature=21bbace361d02d08cdeae3ac77ab1fa18bef6fd622dc1c2fad262f62272e70be&X-Amz-SignedHeaders=host&x-id=GetObject','r'),
(19, 'Chaussures de Ville', '11', 130, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124439Z&X-Amz-Expires=43200&X-Amz-Signature=80f7eaff11f10d50261a14e0d6134001a50cde2479c26cfe497c644b50b90e41&X-Amz-SignedHeaders=host&x-id=GetObject','s'),
(20, 'Baskets Lifestyle', '26', 110, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124449Z&X-Amz-Expires=43200&X-Amz-Signature=5ea8f15fdda8d536872bba0b1b05c534de457097b2996e0a657c9e7f7df65a17&X-Amz-SignedHeaders=host&x-id=GetObject','t'),
(21, 'Pantalon Jogger', '19', 35, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124506Z&X-Amz-Expires=43200&X-Amz-Signature=4bebca4285b0380f7b287b98d1659d2dfd248a98a08fcac24ba1b3c394ac0400&X-Amz-SignedHeaders=host&x-id=GetObject','u'),
(22, 'Pantalon de Costume', '12', 89, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124536Z&X-Amz-Expires=43200&X-Amz-Signature=34626eab6f02d17e1e449ef989e8db8dd426e5f17006ef395321abad9bec4591&X-Amz-SignedHeaders=host&x-id=GetObject','v'),
(23, 'Chemise Rayée', '16', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124522Z&X-Amz-Expires=43200&X-Amz-Signature=76bfa02ebd7f64562054aa3c875ce9d34f5ca84bd6f8b852a39e5bf4bdf1e3fd&X-Amz-SignedHeaders=host&x-id=GetObject','w'),
(24, 'Chemise Coupe Slim', '21', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=J5MPMMAOKIP4KS6U5ZR4%2F20250916%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250916T124548Z&X-Amz-Expires=43200&X-Amz-Signature=74bdec24af1f55c60600de80728f7770f6721d222e2c9329d5c0960592d59505&X-Amz-SignedHeaders=host&x-id=GetObject','x');

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


