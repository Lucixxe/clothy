BEGIN;

TRUNCATE TABLE cart CASCADE;
TRUNCATE TABLE cart_item CASCADE;
TRUNCATE TABLE category CASCADE;
TRUNCATE TABLE customer CASCADE;
TRUNCATE TABLE customer_order CASCADE;
TRUNCATE TABLE product CASCADE;
TRUNCATE TABLE rel_product__category CASCADE;



DELETE FROM jhi_user_authority WHERE user_id > 1000 ;
DELETE FROM JHI_USER WHERE LOGIN NOT IN ('admin', 'user') ;


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

INSERT INTO product (id, name, sku, price, image, description) VALUES
(1, 'Nike Air', '1', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071324Z&X-Amz-Expires=43200&X-Amz-Signature=b564b57826dccf5046abaf5d6d68b852fada0d9e34ed857239e7ec863143091d&X-Amz-SignedHeaders=host&x-id=GetObject', 'Portez ces Nike Air et chaque pas vous propulse vers le succès ! Équipées de la technologie AeroBoost 3000, elles transforment votre marche en vol plané. Devenez un skater débridé des temps modernes !'),

(2, 'Nike P 3000', '30', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071345Z&X-Amz-Expires=43200&X-Amz-Signature=12c871e5a9a399999fee32fa5ed52f752ac3205f8d60ac354925484f5f110e34&X-Amz-SignedHeaders=host&x-id=GetObject', 'Les Nike P 3000 : semelles à propulsion ionique incluses ! Marchez sur les nuages, courez plus vite que la lumière. Transformez votre quotidien en aventure intergalactique !'),

(3, 'Nike P 6000', '40', 250, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071357Z&X-Amz-Expires=43200&X-Amz-Signature=b666f24a9639fda66926bf530e0b4fa3d0d79c6b2f25da65237b9c48356c34a0&X-Amz-SignedHeaders=host&x-id=GetObject', 'Nike P 6000 : Edition Cyberpunk Supreme ! Avec amortisseurs quantiques et design holographique. Devenez le héros de votre propre film de science-fiction !'),

(4, 'Pantalon Slim', '25', 30, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071513Z&X-Amz-Expires=43200&X-Amz-Signature=65cae5612b596164429514f1d2ede8ea87fd061b6a6905b74c49b17e285a33ca&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Slim Neo-Matrix ! Tissu auto-adaptatif qui épouse parfaitement votre silhouette. Activez le mode "Agent Smith" et dominez le monde corporatif !'),

(5, 'Pantalon Regular', '35', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071513Z&X-Amz-Expires=43200&X-Amz-Signature=65cae5612b596164429514f1d2ede8ea87fd061b6a6905b74c49b17e285a33ca&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Regular dimension parallèle ! Confort maximal avec fibres temporelles. Voyagez dans le temps tout en gardant un style impeccable !'),

(6, 'Pantalon Cargo', '50', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071534Z&X-Amz-Expires=43200&X-Amz-Signature=c7a0bba1aae10eb055cd730928c7cf18d07d5075899588c60e69b04c43500b98&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Cargo Survival Edition ! Poches dimensionnelles infinies pour transporter tout votre équipement d''explorateur galactique. Prêt pour l''apocalypse zombie !'),

(7, 'Chemise Blanche', '100', 98, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071549Z&X-Amz-Expires=43200&X-Amz-Signature=eaa4e20d86eb16c648db8204474285d7b5160b774124327f0e96dd2853073711&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Blanche Quantique ! Tissu auto-nettoyant et résistant aux rayons laser. Transformez-vous en gentleman du futur avec cette merveille technologique !'),

(8, 'Chemise Bleue', '5', 36, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071604Z&X-Amz-Expires=43200&X-Amz-Signature=71ef547858fe34b09f9e8a675829b693cda0ef4b10d38e15f73645bfdec27510&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Bleue Océan Cosmique ! Infusée avec l''essence des mers extraterrestres. Portez-la et ressentez la puissance des profondeurs galactiques !'),

(9, 'Chemise à Carreaux', '12', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071616Z&X-Amz-Expires=43200&X-Amz-Signature=b36d27e09877ed138ea8cdf313676b1ec6a01854f45d704a152f9baf81c0a2a5&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise à Carreaux Multivers ! Chaque carreau ouvre un portail vers une dimension différente. Devenez le maître des réalités alternatives !'),

(10, 'Sneakers Running', '18', 120, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071646Z&X-Amz-Expires=43200&X-Amz-Signature=71ec5741efa3c745d3563ca07e96be32ab3169d70e535b06f0d06cef65b54b1b&X-Amz-SignedHeaders=host&x-id=GetObject', 'Sneakers Running Hypersoniques ! Technologie anti-gravité intégrée. Courez sur l''eau, escaladez les murs comme Spider-Man ! L''impossible devient possible !'),

(11, 'Bottes en Cuir', '8', 180, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071659Z&X-Amz-Expires=43200&X-Amz-Signature=a066069ad2b1f8f933ee805e7ef60031d40e77db700063c93ad5d1fee9fb9c0c&X-Amz-SignedHeaders=host&x-id=GetObject', 'Bottes en Cuir de Dragon Cybernétique ! Forgées dans les forges de Mars. Protection totale contre les attaques d''aliens et style légendaire garanti !'),

(12, 'Derbies Classiques', '15', 140, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071737Z&X-Amz-Expires=43200&X-Amz-Signature=b751ae94a48c213a642e10a7a7ea9959955b1c9e1bb258d54d1ec486bbd7e633&X-Amz-SignedHeaders=host&x-id=GetObject', 'Derbies Classiques du Gentleman Temporel ! Cuir vieilli dans le futur puis ramené dans le présent. Chaque pas résonne dans l''éternité !'),

(13, 'Pantalon Chino', '22', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T072018Z&X-Amz-Expires=43200&X-Amz-Signature=2ffce9b24f6bedfa2100d26692ff7e9c998352323ec63fe1cdf2aded3cdbb19b&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Chino Nano-Intelligence ! Fibres programmables qui s''adaptent à votre morphologie. Devenez un espion galactique avec ce vêtement caméléon !'),

(14, 'Jeans Slim', '28', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T072043Z&X-Amz-Expires=43200&X-Amz-Signature=39b5886e79ee66dec0d48aec0cfd293bdfed7736a69af70901f2de0e24951a65&X-Amz-SignedHeaders=host&x-id=GetObject', 'Jeans Slim Rebellion 2099 ! Denim renforcé au vibranium. Résiste aux explosions nucléaires tout en gardant un look rebelle intemporel !'),

(15, 'Jeans Regular', '32', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T072056Z&X-Amz-Expires=43200&X-Amz-Signature=6aebb91d97082cf680d72ccbef2b89c3f3b1bf6d26938742a99b9887a98cecec&X-Amz-SignedHeaders=host&x-id=GetObject', 'Jeans Regular Confort Infini ! Technologie de téléportation moléculaire pour un confort absolu. Voyagez à travers les galaxies sans perdre votre style !'),

(16, 'Chemise Oxford', '14', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071910Z&X-Amz-Expires=43200&X-Amz-Signature=8e0d57de541a76b018e4e856f41895541d2578557e8adf7f978d0d82c3666758&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Oxford Académie Intersidérale ! Tissée avec des fils d''étoiles mortes. Portez la sagesse de l''univers et devenez le professeur X du style !'),

(17, 'Chemise Noire', '9', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071923Z&X-Amz-Expires=43200&X-Amz-Signature=7eb26b137dead3d2bbfac2613348128e65309020b0d632a55751418cafdf1894&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Noire Ninja Cyberpunk ! Absorption totale de lumière pour une discrétion maximale. Infiltrez-vous partout comme un hacker légendaire !'),

(18, 'Chemise en Lin', '7', 65, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071937Z&X-Amz-Expires=43200&X-Amz-Signature=8f4a1a9772937cef4148ba6908ccbe32fdb8e5a17b4f8707a37dc527b41bd5e3&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise en Lin des Jardins d''Eden Galactiques ! Lin cultivé sur Pandora avec régulation thermique automatique. Fraîcheur éternelle garantie !'),

(19, 'Chaussures de Ville', '11', 130, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071802Z&X-Amz-Expires=43200&X-Amz-Signature=66107643e38e83dae305a02b4f45d8cca355fdc5ffb20faa5f3c92f0b3162a03&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chaussures de Ville Magistrat Suprême ! Arpentez les couloirs du pouvoir avec autorité. Chaque pas impose le respect dans tout l''empire galactique !'),

(20, 'Baskets Lifestyle', '26', 110, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071827Z&X-Amz-Expires=43200&X-Amz-Signature=e8814a3c945b54cf8373d8414c607f84486e8249f3a190e95197c8310c0e6c94&X-Amz-SignedHeaders=host&x-id=GetObject', 'Baskets Lifestyle Nomade Cosmique ! Semelles adaptatives pour tout terrain : Mars, Vénus ou votre salon ! L''aventure vous attend partout !'),

(21, 'Pantalon Jogger', '19', 35, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T072113Z&X-Amz-Expires=43200&X-Amz-Signature=d20953e84e7d2699d90c54807617295c875a3b612931b6fec38de305cba2cec0&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Jogger Vitesse Éclair ! Accélérateur de particules intégré dans les fibres. Courez plus vite que Flash tout en restant stylé !'),

(22, 'Pantalon de Costume', '12', 89, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T072122Z&X-Amz-Expires=43200&X-Amz-Signature=ce31a9dfa1f8e88c5d428016af6c6d66c016a8cda0bc8060c7b9b31aaf5873ef&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon de Costume Empereur Galactique ! Coupe présidentielle avec nano-plis auto-entretenus. Dirigez l''univers avec classe et autorité !'),

(23, 'Chemise Rayée', '16', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T071949Z&X-Amz-Expires=43200&X-Amz-Signature=e6e7209b257904f8d9fffc3a073d0ff09ebaf3efd1fb8734ab6013e1befddd9b&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Rayée Illusion Optique ! Les rayures créent des portails dimensionnels hypnotiques. Troublez vos ennemis et devenez invisible à volonté !'),

(24, 'Chemise Coupe Slim', '21', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=YPSXXRW24XLR74UPQHXC%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T072003Z&X-Amz-Expires=43200&X-Amz-Signature=88c21c0f4c8741f580421f459c785269c174fba8a122e7eb949e8d37cdbd0abe&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Coupe Slim Architecte du Futur ! Géométrie parfaite calculée par IA quantique. Sculptez votre silhouette comme un dieu grec cybernétique !');

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


