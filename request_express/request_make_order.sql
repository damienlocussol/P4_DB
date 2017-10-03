--CREATE NEW ORDER
SELECT * FROM order_book;

SELECT * FROM order_content;

SELECT * FROM customer;

--AFFICHER LES PRODUITS DISPONIBLES AUJOURD'HUI
SELECT id, name, price FROM product WHERE date_product = CURRENT_DATE;

--AFFICHER LES ADRESSES POUR UN CLIENT
SELECT id FROM adress WHERE customer_id = 5;

--CREATION DE LA COMMANDE
--input datas	customer_id
INSERT INTO order_book
	(date_order, status, total_price, time_start, customer_id, adress_id)
VALUES
	(CURRENT_DATE,
	'not paid',
	0,
	'2017-09-11 10:05:00',
	5,
	6);

--REMPLISSAGE ORDER_CONTENT
--inputs datas -> product_id      order_id      quantity
INSERT INTO order_content
	(product_id, order_book_id, quantity)
VALUES
	(44,
	currval('order_book_id_seq'),
	3);
	
--PRIX TOTAL DANS ORDER_BOOK
UPDATE order_book 
SET total_price = 
	(SELECT sum(order_content.quantity * price) 
		FROM order_content 
		JOIN product ON product_id = id 
		WHERE order_content.order_book_id = currval('order_book_id_seq')) 
	WHERE id= currval('order_book_id_seq');

--REGLEMENT
UPDATE order_book SET status = 'paid'
WHERE id= currval('order_book_id_seq');

--VERIFIER LES COMMANDES A TRAITER MAINTENANT
SELECT id FROM order_book WHERE time_start  < CURRENT_TIMESTAMP AND status = 'paid';

--CHANGER LA POSITION D'UN LIVREUR
--UPDATE delivery_man SET position = 12 WHERE ss_number = 1001;


--CHOISIR UN LIVREUR
--LIVREUR(s) AVEC LES PRODUITS DEMANDES
SELECT delivery_man_ss_number, COUNT(delivery_man_ss_number) FROM delivery_bag 
JOIN order_content ON delivery_bag.product_id = order_content.product_id JOIN delivery_man ON delivery_bag.delivery_man_ss_number = delivery_man.ss_number
WHERE order_book_id = 26 AND delivery_bag.quantity >= order_content.quantity AND delivery_man.status = 'free'
GROUP BY delivery_man_ss_number
HAVING COUNT(delivery_man_ss_number) = (SELECT COUNT(order_content.product_id) FROM order_content WHERE order_book_id = 26); 
--

SELECT ss_number, ABS(delivery_man.position - adress.position) AS "distance" FROM delivery_man 
JOIN adress ON adress.id = (SELECT adress_id FROM order_book WHERE id =26) 
WHERE ss_number IN(100,245)
ORDER BY distance LIMIT 1;

-- TIMEEND DANS ORDER_BOOK
UPDATE order_book SET time_end = CURRENT_TIMESTAMP + (6/5 * interval '1' minute), status = 'customer_ok' WHERE id =26;

--NOTIF CLIENT ESTIMATION DU TEMPS 
SELECT to_char(time_end, 'HH:MI') AS "heure estimée", customer_id AS "client" FROM order_book WHERE id=26;

--CREATION ORDER_OK
INSERT INTO order_ok(order_book_id, ss_number)
VALUES(26,
	  245);

--NOTIF LIVREUR ACCEPT ORDER
UPDATE delivery_man SET status = 'busy' WHERE ss_number = 245;
UPDATE order_book SET status = 'accepted' WHERE id = 26;

--NOTIF LATE
	-- TIMEEND DANS ORDER_BOOK
	--NOTIF CLIENT ESTIMATION DU TEMPS 

--NOTIF ACCIDENT -- CHANGEMENT DE LIVREUR
	--CHOISIR UN LIVREUR
	-- TIMEEND DANS ORDER_BOOK
	--NOTIF CLIENT ESTIMATION DU TEMPS 
	--MODIF ORDER_OK
		UPDATE order_ok SET ss_number = 245 WHERE order_book_id = 10;
	--NOTIF LIVREUR ACCEPT ORDER

--AUCUN LIVREUR DISPO -- PRENDRE LE LIVREUR LIBRE LE PLUS PROCHE DU MAGASIN POUR RAVITAILLER ET LIVRER LA COMMANDE
SELECT ss_number, ABS(delivery_man.position - adress.position) AS "distance" FROM delivery_man 
JOIN adress ON adress.id = 12 --adress 12 = office/cuisine
WHERE status = 'free'
ORDER BY distance LIMIT 1;
	--RAVITAILLEMENT SAC LIVREUR
	--TIMEEND DANS ORDER_BOOK
	--NOTIF CLIENT ESTIMATION DU TEMPS 
	--CREATION ORDER_OK
	--NOTIF LIVREUR ACCEPT ORDER

	
----------------------------------------------------------------LIVRAISON EN COURS---------------------------------------------------------------

SELECT order_book_id, ss_number FROM order_ok JOIN order_book ON order_book_id = id WHERE status = 'accepted' ;

--LIVREUR ORDER DONE  STATUS = FREE   POSITION = CUSTOMER POSITION
UPDATE delivery_man SET status = 'free', position = adress.position FROM adress JOIN order_book ON order_book.customer_id = adress.customer_id WHERE ss_number = 245 AND order_book.id =26 ;
UPDATE order_book SET status = 'done', time_end = CURRENT_TIMESTAMP WHERE id = 26;

--VIDER LE SAC DU LIVREUR DE LA COMMANDE
UPDATE delivery_bag 
SET quantity = delivery_bag.quantity - order_content.quantity 
FROM order_content
WHERE delivery_bag.product_id = order_content.product_id AND order_book_id = 26 AND delivery_man_ss_number = 245;
--




SELECT * FROM order_book;

--ANNULER UNE COMMANDE
DELETE FROM order_content WHERE order_book_id = 2;
DELETE FROM order_ok WHERE order_book_id = 2;
DELETE FROM order_book WHERE id = 2;

















