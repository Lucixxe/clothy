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
(1, 'Nike Air', '1', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225326Z&X-Amz-Expires=43200&X-Amz-Signature=9f32c45d03cf6ff35c4456c7e3152716c21fc24cfd59d3388c865c2a0661bf77&X-Amz-SignedHeaders=host&x-id=GetObject', 'Portez ces Nike Air et chaque pas vous propulse vers le succès ! Équipées de la technologie AeroBoost 3000, elles transforment votre marche en vol plané. Devenez un skater débridé des temps modernes !'),

(2, 'Nike P 3000', '30', 100, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225430Z&X-Amz-Expires=43200&X-Amz-Signature=c176d0474c1ccad44cdb741438932595bced87cbb07d2e356f47e78f5ce2e677&X-Amz-SignedHeaders=host&x-id=GetObject', 'Les Nike P 3000 : semelles à propulsion ionique incluses ! Marchez sur les nuages, courez plus vite que la lumière. Transformez votre quotidien en aventure intergalactique !'),

(3, 'Nike P 6000', '40', 250, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225448Z&X-Amz-Expires=43200&X-Amz-Signature=24730987cb8313bf0ca0c62653b9d59b7be27be587c67ed935f9acae270afa6e&X-Amz-SignedHeaders=host&x-id=GetObject', 'Nike P 6000 : Edition Cyberpunk Supreme ! Avec amortisseurs quantiques et design holographique. Devenez le héros de votre propre film de science-fiction !'),

(4, 'Pantalon Slim', '25', 30, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225506Z&X-Amz-Expires=43200&X-Amz-Signature=ffce3b40bbc81545458f6510a77bf2799d80c229a00990574251a776be54bd89&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Slim Neo-Matrix ! Tissu auto-adaptatif qui épouse parfaitement votre silhouette. Activez le mode "Agent Smith" et dominez le monde corporatif !'),

(5, 'Pantalon Regular', '35', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225602Z&X-Amz-Expires=43200&X-Amz-Signature=dd35ec9d8e5f85c4cc0120cbf4958963d7f95c656ee8487205aeb8d4ee6434b7&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Regular dimension parallèle ! Confort maximal avec fibres temporelles. Voyagez dans le temps tout en gardant un style impeccable !'),

(6, 'Pantalon Cargo', '50', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225615Z&X-Amz-Expires=43200&X-Amz-Signature=913674e1829eb869ea95823b3ad511b41f8eeab706a31d074159c1ec2fd723f0&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Cargo Survival Edition ! Poches dimensionnelles infinies pour transporter tout votre équipement d''explorateur galactique. Prêt pour l''apocalypse zombie !'),

(7, 'Chemise Blanche', '100', 98, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-1.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225657Z&X-Amz-Expires=43200&X-Amz-Signature=49d7aed9c92d960fd0e58a5bb2f8620f94cfd55ba47f8b7efede85a65aea31dd&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Blanche Quantique ! Tissu auto-nettoyant et résistant aux rayons laser. Transformez-vous en gentleman du futur avec cette merveille technologique !'),

(8, 'Chemise Bleue', '5', 36, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-2.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225715Z&X-Amz-Expires=43200&X-Amz-Signature=6da498bf1b7cf043d5d609fc05d93820b9cbc7ddd13295035d0695f7f949e8f5&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Bleue Océan Cosmique ! Infusée avec l''essence des mers extraterrestres. Portez-la et ressentez la puissance des profondeurs galactiques !'),

(9, 'Chemise à Carreaux', '12', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225729Z&X-Amz-Expires=43200&X-Amz-Signature=5c12462c00fef1a18842c6662a9a0420ae2a6b42f291c9af88a8001eb73ac3d4&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise à Carreaux Multivers ! Chaque carreau ouvre un portail vers une dimension différente. Devenez le maître des réalités alternatives !'),

(10, 'Sneakers Running', '18', 120, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225754Z&X-Amz-Expires=43200&X-Amz-Signature=3f2c5007c07be9c37219d0438a7f7ee3e7ec7839af40f013fcd71f71623a0891&X-Amz-SignedHeaders=host&x-id=GetObject', 'Sneakers Running Hypersoniques ! Technologie anti-gravité intégrée. Courez sur l''eau, escaladez les murs comme Spider-Man ! L''impossible devient possible !'),

(11, 'Bottes en Cuir', '8', 180, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225839Z&X-Amz-Expires=43200&X-Amz-Signature=dff2dabe076cb8fb4046373ced35501605ee3573c2b5c441fac244c4b73ccb99&X-Amz-SignedHeaders=host&x-id=GetObject', 'Bottes en Cuir de Dragon Cybernétique ! Forgées dans les forges de Mars. Protection totale contre les attaques d''aliens et style légendaire garanti !'),

(12, 'Derbies Classiques', '15', 140, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225903Z&X-Amz-Expires=43200&X-Amz-Signature=939d5f10e06b2b69d5576ee722cee340005085ab660e3bcd950b3e2f4f3d75a5&X-Amz-SignedHeaders=host&x-id=GetObject', 'Derbies Classiques du Gentleman Temporel ! Cuir vieilli dans le futur puis ramené dans le présent. Chaque pas résonne dans l''éternité !'),

(13, 'Pantalon Chino', '22', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225932Z&X-Amz-Expires=43200&X-Amz-Signature=afeadb773a2da9709ff8e959cdc311b059f02aa27a4cf88c16cb9bbb3dba0871&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Chino Nano-Intelligence ! Fibres programmables qui s''adaptent à votre morphologie. Devenez un espion galactique avec ce vêtement caméléon !'),

(14, 'Jeans Slim', '28', 59, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T225958Z&X-Amz-Expires=43200&X-Amz-Signature=63c0a194f39270dce6f2a0442614a82618aefdb8510128663410630822f2cd34&X-Amz-SignedHeaders=host&x-id=GetObject', 'Jeans Slim Rebellion 2099 ! Denim renforcé au vibranium. Résiste aux explosions nucléaires tout en gardant un look rebelle intemporel !'),

(15, 'Jeans Regular', '32', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230016Z&X-Amz-Expires=43200&X-Amz-Signature=5325af201fd373674821bd181fa6df028320899249f5e2b7c7696f1de47fffb4&X-Amz-SignedHeaders=host&x-id=GetObject', 'Jeans Regular Confort Infini ! Technologie de téléportation moléculaire pour un confort absolu. Voyagez à travers les galaxies sans perdre votre style !'),

(16, 'Chemise Oxford', '14', 45, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230111Z&X-Amz-Expires=43200&X-Amz-Signature=a605a38fad900202c0aa244e2f65045ecbcca69d72b54c8bae5a458f7e4bdab1&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Oxford Académie Intersidérale ! Tissée avec des fils d''étoiles mortes. Portez la sagesse de l''univers et devenez le professeur X du style !'),

(17, 'Chemise Noire', '9', 39, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-5.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230203Z&X-Amz-Expires=43200&X-Amz-Signature=83eaca7a743d8143eb59fe7ca57d50c81d6074911519a0151f7bde7dcb8afbd5&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Noire Ninja Cyberpunk ! Absorption totale de lumière pour une discrétion maximale. Infiltrez-vous partout comme un hacker légendaire !'),

(18, 'Chemise en Lin', '7', 65, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-6.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230226Z&X-Amz-Expires=43200&X-Amz-Signature=45e6a96df8b43844a9c081b29cbf679f62425d9ae26cf84e58c85eac49362b50&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise en Lin des Jardins d''Eden Galactiques ! Lin cultivé sur Pandora avec régulation thermique automatique. Fraîcheur éternelle garantie !'),

(19, 'Chaussures de Ville', '11', 130, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230244Z&X-Amz-Expires=43200&X-Amz-Signature=7439f22679027b39bcc218d1997bf963a31dd9894d9845ec4350139d9fca2abf&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chaussures de Ville Magistrat Suprême ! Arpentez les couloirs du pouvoir avec autorité. Chaque pas impose le respect dans tout l''empire galactique !'),

(20, 'Baskets Lifestyle', '26', 110, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chaussures-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230259Z&X-Amz-Expires=43200&X-Amz-Signature=2d917658fc618544a2ba81ed387f35b2d6ac6f4e11e0961cce28ca9e8410d3df&X-Amz-SignedHeaders=host&x-id=GetObject', 'Baskets Lifestyle Nomade Cosmique ! Semelles adaptatives pour tout terrain : Mars, Vénus ou votre salon ! L''aventure vous attend partout !'),

(21, 'Pantalon Jogger', '19', 35, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230320Z&X-Amz-Expires=43200&X-Amz-Signature=a5ac8153166b84a23e9d3fcc8a6ba00218b966ba19a627c82915e87281e23bd8&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon Jogger Vitesse Éclair ! Accélérateur de particules intégré dans les fibres. Courez plus vite que Flash tout en restant stylé !'),

(22, 'Pantalon de Costume', '12', 89, 'https://s3.eu-central-2.wasabisys.com/clothy-images/pantalon-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230337Z&X-Amz-Expires=43200&X-Amz-Signature=97dcf6f57dcd0ac6ac1eed96fb21dbd5fa046ab9df7dd3636ab43fc0e782cc9f&X-Amz-SignedHeaders=host&x-id=GetObject', 'Pantalon de Costume Empereur Galactique ! Coupe présidentielle avec nano-plis auto-entretenus. Dirigez l''univers avec classe et autorité !'),

(23, 'Chemise Rayée', '16', 49, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-7.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230352Z&X-Amz-Expires=43200&X-Amz-Signature=8f1d1ba36f79fd4e7aa240268bfd0b1d773e9e6849b3bc99f69477e084be85d6&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Rayée Illusion Optique ! Les rayures créent des portails dimensionnels hypnotiques. Troublez vos ennemis et devenez invisible à volonté !'),

(24, 'Chemise Coupe Slim', '21', 55, 'https://s3.eu-central-2.wasabisys.com/clothy-images/chemise-8.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=R7JK2L398RAEP9S15DVQ%2F20250918%2Feu-central-2%2Fs3%2Faws4_request&X-Amz-Date=20250918T230407Z&X-Amz-Expires=43200&X-Amz-Signature=edde3663cd860f5e2a4f3f5ae14e6c72ca575d9a5df37ec3e29d65c2b793687a&X-Amz-SignedHeaders=host&x-id=GetObject', 'Chemise Coupe Slim Architecte du Futur ! Géométrie parfaite calculée par IA quantique. Sculptez votre silhouette comme un dieu grec cybernétique !');

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