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
(1, 'Nike Air', '1', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080222Z&X-Amz-Expires=43200&X-Amz-Signature=61e89596f3f2dab3af34d54a58a07c3ac6806f2de5ea3329fb6ddc91b67456d7&X-Amz-SignedHeaders=host&x-id=GetObject', 'Portez ces Nike Air et chaque pas vous propulse vers le succès ! Équipées de la technologie AeroBoost 3000, elles transforment votre marche en vol plané. Devenez un skater débridé des temps modernes !'),

(2, 'Nike P 3000', '30', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080303Z&X-Amz-Expires=43200&X-Amz-Signature=2e9e7f16c3e24f87cef6129ffd1996d27f0e408c6b7a252efef4ac7f0b36fbdb&X-Amz-SignedHeaders=host&x-id=GetObject', 'Les Nike P 3000 : semelles à propulsion ionique incluses ! Marchez sur les nuages, courez plus vite que la lumière. Transformez votre quotidien en aventure intergalactique !'),

(3, 'Nike P 6000', '40', 250, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080329Z&X-Amz-Expires=43200&X-Amz-Signature=ffb2f17a368527003c8f6dff9f8f92f37d44f875be3b491f691cea6071d00666&X-Amz-SignedHeaders=host&x-id=GetObject', 'Nike P 6000 : Edition Cyberpunk Supreme ! Avec amortisseurs quantiques et design holographique. Devenez le héros de votre propre film de science-fiction !'),

(4, 'Pantalon Slim', '25', 30, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080410Z&X-Amz-Expires=43200&X-Amz-Signature=e96d7b492df2abdec6af704d540b0f5835ed5b048d7fdf9e5e70f1414e60d824&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Slim Neo-Matrix ! Tissu auto-adaptatif qui épouse parfaitement votre silhouette. Activez le mode "Agent Smith" et dominez le monde corporatif !'),

(5, 'Pantalon Regular', '35', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080431Z&X-Amz-Expires=43200&X-Amz-Signature=a660fb4b2eaedd5bf57568ecb4e8e36f0b8f493993a58cd49ca563108a722683&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Regular dimension parallèle ! Confort maximal avec fibres temporelles. Voyagez dans le temps tout en gardant un style impeccable !'),

(6, 'Pantalon Cargo', '50', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080450Z&X-Amz-Expires=43200&X-Amz-Signature=682b6eb81d03a0c31abe5d1796b2f0f96527b575f6ff91e4276415d29062f242&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Cargo Survival Edition ! Poches dimensionnelles infinies pour transporter tout votre équipement d''explorateur galactique. Prêt pour l''apocalypse zombie !'),

(7, 'Chemise Blanche', '100', 98, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080517Z&X-Amz-Expires=43200&X-Amz-Signature=c15d700afc796bf12b45a9818943ca802a6aa3ed1552571ea906eaf4a789c4ff&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Blanche Quantique ! Tissu auto-nettoyant et résistant aux rayons laser. Transformez-vous en gentleman du futur avec cette merveille technologique !'),

(8, 'Chemise Bleue', '5', 36, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080537Z&X-Amz-Expires=43200&X-Amz-Signature=e18c8507bad5a454a4f4c479dc688b88745089ad192dedd74f84f95260f876ad&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Bleue Océan Cosmique ! Infusée avec l''essence des mers extraterrestres. Portez-la et ressentez la puissance des profondeurs galactiques !'),

(9, 'Chemise à Carreaux', '12', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080604Z&X-Amz-Expires=43200&X-Amz-Signature=1fc43308594ba09a0a33f3f3b95d72071a96acca20c20141ebab9b6ae7ab5b84&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise à Carreaux Multivers ! Chaque carreau ouvre un portail vers une dimension différente. Devenez le maître des réalités alternatives !'),

(10, 'Sneakers Running', '18', 120, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080718Z&X-Amz-Expires=43200&X-Amz-Signature=e78e6ec0638d5fc81fe82ada2531af9fb825329ae4e68881e66288e06a95423e&X-Amz-SignedHeaders=host&x-id=GetObject', 'Sneakers Running Hypersoniques ! Technologie anti-gravité intégrée. Courez sur l''eau, escaladez les murs comme Spider-Man ! L''impossible devient possible !'),

(11, 'Bottes en Cuir', '8', 180, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080738Z&X-Amz-Expires=43200&X-Amz-Signature=ae4575acdc35cc69e787a4884878419224bcf23cf09ec0c79c2e10dc0d21146f&X-Amz-SignedHeaders=host&x-id=GetObject', 'Bottes en Cuir de Dragon Cybernétique ! Forgées dans les forges de Mars. Protection totale contre les attaques d''aliens et style légendaire garanti !'),

(12, 'Derbies Classiques', '15', 140, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080803Z&X-Amz-Expires=43200&X-Amz-Signature=13ce57167d0f48327a754fb86e7f8eb638897930bd71755ca7075bbdc2fd03cf&X-Amz-SignedHeaders=host&x-id=GetObject', 'Derbies Classiques du Gentleman Temporel ! Cuir vieilli dans le futur puis ramené dans le présent. Chaque pas résonne dans l''éternité !'),

(13, 'Pantalon Chino', '22', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080838Z&X-Amz-Expires=43200&X-Amz-Signature=ce477d476ed83b021688538869c667125c28fc9f22a7241352e712c04251429d&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Chino Nano-Intelligence ! Fibres programmables qui s''adaptent à votre morphologie. Devenez un espion galactique avec ce vêtement caméléon !'),

(14, 'Jeans Slim', '28', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080905Z&X-Amz-Expires=43200&X-Amz-Signature=5a16aebfacb29461215d1b4e154321f6867ee7c78b20f46b4efe7cef137bc70f&X-Amz-SignedHeaders=host&x-id=GetObject', 'Jeans Slim Rebellion 2099 ! Denim renforcé au vibranium. Résiste aux explosions nucléaires tout en gardant un look rebelle intemporel !'),

(15, 'Jeans Regular', '32', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080927Z&X-Amz-Expires=43200&X-Amz-Signature=8434aad2afbb3cb3b9955f8ef208eda79cab40f194adc828df2084093a46ce64&X-Amz-SignedHeaders=host&x-id=GetObject', 'Jeans Regular Confort Infini ! Technologie de téléportation moléculaire pour un confort absolu. Voyagez à travers les galaxies sans perdre votre style !'),

(16, 'Chemise Oxford', '14', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T080950Z&X-Amz-Expires=43200&X-Amz-Signature=a55f165565293ad4588168e243f4dde77452a18ce8db08bb34c74b81740e920e&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Oxford Académie Intersidérale ! Tissée avec des fils d''étoiles mortes. Portez la sagesse de l''univers et devenez le professeur X du style !'),

(17, 'Chemise Noire', '9', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081032Z&X-Amz-Expires=43200&X-Amz-Signature=68c4e202d7e4dea210f068a576fd8aedde5aedad970ce9bb53acca073a4c580f&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Noire Ninja Cyberpunk ! Absorption totale de lumière pour une discrétion maximale. Infiltrez-vous partout comme un hacker légendaire !'),

(18, 'Chemise en Lin', '7', 65, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081053Z&X-Amz-Expires=43200&X-Amz-Signature=da415fde7033fe1beb997ebed0d1b374e82707940e13176fb3b9d561a53818a5&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise en Lin des Jardins d''Eden Galactiques ! Lin cultivé sur Pandora avec régulation thermique automatique. Fraîcheur éternelle garantie !'),

(19, 'Chaussures de Ville', '11', 130, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081123Z&X-Amz-Expires=43200&X-Amz-Signature=06f5bc2ed8a21e2221ed92916aa98b8b5007863c3e73a15c51762545c59b8b9a&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chaussures de Ville Magistrat Suprême ! Arpentez les couloirs du pouvoir avec autorité. Chaque pas impose le respect dans tout l''empire galactique !'),

(20, 'Baskets Lifestyle', '26', 110, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081148Z&X-Amz-Expires=43200&X-Amz-Signature=6ec8e891449fab9cfb0e291c0d16594c538b28a4a7e5f4938aca31d84f37d7ab&X-Amz-SignedHeaders=host&x-id=GetObject', 'Baskets Lifestyle Nomade Cosmique ! Semelles adaptatives pour tout terrain : Mars, Vénus ou votre salon ! L''aventure vous attend partout !'),

(21, 'Pantalon Jogger', '19', 35, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081212Z&X-Amz-Expires=43200&X-Amz-Signature=14eb54cfc540175d085a42943e781f4d312c3611d94910226147169b3cd84978&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Jogger Vitesse Éclair ! Accélérateur de particules intégré dans les fibres. Courez plus vite que Flash tout en restant stylé !'),

(22, 'Pantalon de Costume', '12', 89, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081304Z&X-Amz-Expires=43200&X-Amz-Signature=59dd61cf6526944642fefbaa981aaac6b1159a6ad81015c35e11ffe470c1e262&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon de Costume Empereur Galactique ! Coupe présidentielle avec nano-plis auto-entretenus. Dirigez l''univers avec classe et autorité !'),

(23, 'Chemise Rayée', '16', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081324Z&X-Amz-Expires=43200&X-Amz-Signature=62004873d4400cda4bda7151cbee512ee690c9eb18e96ce4f339234a747d08f7&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Rayée Illusion Optique ! Les rayures créent des portails dimensionnels hypnotiques. Troublez vos ennemis et devenez invisible à volonté !'),

(24, 'Chemise Coupe Slim', '21', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=7RONTLEOU14R96SGBMZL%2F20250919%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250919T081338Z&X-Amz-Expires=43200&X-Amz-Signature=8f29eda646d0028887613063aee91cf311256855c22c03f29e54bde8a14334fe&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Coupe Slim Architecte du Futur ! Géométrie parfaite calculée par IA quantique. Sculptez votre silhouette comme un dieu grec cybernétique !');

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