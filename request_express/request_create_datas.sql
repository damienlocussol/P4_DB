--CREATION D'UN VELO
INSERT INTO bike (is_checked,date_revision,status) 
VALUES (true, {d '2017-08-15'}, true);

--CREATION D'UN LIVREUR --   bike_id 15 = velo hs = livreur sans velo
INSERT INTO delivery_man (ss_number, firstname, lastname, status, position, bike_id)
VALUES(245, 'Jane', 'Manzoni', 'free', 65, 15);

--CREATION D'UN PRODUIT
INSERT INTO product (name, date_product, quantity, price, category_id) 
VALUES    ('jambalaya',
		{d '2017-09-28'},
		20,
		12.5,
		1);

--CREATION D'UN CLIENT
INSERT INTO customer (firstname, lastname, login, password) 
VALUES    ('le',
		'Chef',
		'chef',
		'boss');

--CREATION D'UNE ADRESSE
INSERT INTO adress (customer_id,
			     numero,
			     street,
			     adress_code,
			     city,
			     building,
			     floor,
			     door,
			     digicode,
			     phone1,
			     phone2,
			     email,
			     position) 
VALUES             (12,
			    '1',
			    'rue notre-dame',
			    75001,
			    'paris',
			    null,
			    0,
			    null,
			    null,
			    665046468,
			    null,
			    'info@expressfood.fr',
			    75);



----MAJ SEQUENCE
--SELECT setval('order_book_id_seq', (SELECT MAX(id) FROM order_book));
--
----CREATE SEQUENCE
--CREATE SEQUENCE order_book_id_seq
--MINVALUE 1
--START 1
--INCREMENT 1;
--
--ALTER TABLE order_book
--ALTER COLUMN id
--SET DEFAULT nextval('order_book_id_seq');





