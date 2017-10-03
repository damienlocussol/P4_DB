SELECT ss_number FROM delivery_man;

SELECT id, name FROM product WHERE date_product = CURRENT_DATE;

-- Input datas -> ss_number quantity
--CREATION DU SAC ET REMPLIR LE SAC------------------------------------------------------------------------------
INSERT INTO delivery_bag 
		(product_id, 
		delivery_man_ss_number, 
		quantity) 
SELECT 	id,
		100,
		4 FROM product WHERE date_product = CURRENT_DATE AND product.quantity >= 4;
--
-- DECREMENTER LA QUANTITE TOTALE DANS PRODUCT
UPDATE product SET quantity = quantity - 4
WHERE date_product = CURRENT_DATE;
--

--PRENDRE UN VELO
--Input data = ss_number
UPDATE delivery_man SET bike_id = id 
FROM bike WHERE delivery_man.ss_number = 100 AND bike.status= true AND date_revision > '2017-07-10';
--
UPDATE bike SET status = false
WHERE id = (SELECT bike_id FROM delivery_man WHERE delivery_man.ss_number = 100); 
--


--VOIR LE SAC DU LIVREUR----------------------------------------------------------------------------------------
SELECT name, delivery_bag.quantity, product_id FROM delivery_bag JOIN product ON product_id = id WHERE delivery_man_ss_number = 245; 

--VEND UN PRODUIT
--Inputs product_id   ss_number
--UPDATE delivery_bag SET quantity = quantity -1 WHERE product_id = 21 AND delivery_man_ss_number = 245;

--RAVITAILLE UN PRODUIT
INSERT INTO delivery_bag 
		(product_id, 
		delivery_man_ss_number, 
		quantity) 
VALUES( 	23,
		100,
		2);

--VERIFIER QU'UN LIVREUR A UN PRODUIT AVEC 0 QUANTITE -> RAVITAILLER
--Input    ss_number
SELECT delivery_man_ss_number FROM delivery_bag WHERE quantity = 0 AND delivery_man_ss_number = 245;


--VIDER LE SAC APRES TOUTES LES LIVRAISONS ET RENDRE LE VELO----------------------------------------------------------------------
UPDATE product SET quantity = product.quantity + delivery_bag.quantity 
FROM delivery_bag WHERE delivery_man_ss_number = 1011 AND delivery_bag.quantity > 0 AND product_id=id; 
DELETE FROM delivery_bag WHERE delivery_man_ss_number = 1011;
--
--RENDRE LE VELO
UPDATE bike SET status = true 
WHERE id = (SELECT bike_id FROM delivery_man WHERE delivery_man.ss_number = 1011);
--
UPDATE delivery_man SET bike_id = 15 
WHERE ss_number = 1011;
--



























