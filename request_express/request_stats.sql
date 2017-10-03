--LIVRAISONS------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--TOUTES LES LIVRAISONS ET LEUR DUREE
SELECT id, ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60) AS "minute" from order_book ORDER BY minute;

--PCT DES LIVRAISONS > 20 mn
SELECT 
	(SELECT COUNT(ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60)) FROM order_book WHERE ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60) > 20) * 100 / COUNT(id) AS "% livraison en retard" 
FROM order_book ;

--PRIX MOYEN DES LIVRAISONS DEPUIS x
SELECT ROUND(SUM(total_price) / COUNT(id),2) AS "prix moyen d'une livraison" FROM order_book WHERE date_order > '2017-09-10';

--NB MOYEN DE PRODUIT / LIVRAISON
SELECT ROUND(SUM(quantity) / CAST(COUNT(DISTINCT order_book_id) AS NUMERIC),1) AS "nb moyen de produit par livraison" FROM order_content;

--PCT PLAT / DESSERT
SELECT category.name AS "categorie", ROUND(SUM(order_content.quantity) * 100 / (SELECT CAST(SUM(order_content.quantity) AS NUMERIC) FROM order_content),2) AS "%" 
FROM order_content JOIN product ON id = product_id JOIN category ON category.id = category_id
GROUP BY category.name;

--MEILLEUR CLIENT
	SELECT customer_id, COUNT(id) AS "commande", SUM(total_price) AS "price" FROM order_book GROUP BY customer_id ORDER BY "commande" DESC, "price" DESC;




--LIVREURS------------------------------------------------------------------------------------------------------------------------------------------------------------
	--NB DE COMMANDES
SELECT ss_number, COUNT(order_book_id) AS cnt FROM order_ok GROUP BY ss_number ORDER BY cnt DESC;

	--LES + EN RETARD
SELECT 	ss_number, 
		COUNT(order_book_id) AS "nb livraison total", 
		COUNT(ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60)) AS "nb retard",
		COUNT(ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60))*100/COUNT(order_book_id) AS "% retard"
FROM order_ok 
LEFT JOIN order_book ON order_book_id = id AND (ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60) > 20) 
GROUP BY ss_number
ORDER BY "nb retard" DESC;

	--LES PLUS RAPIDE
SELECT 	ss_number ,
		COUNT(order_book_id) AS "nb livraison",
		SUM(ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60)) AS "total minute",
		ROUND(CAST(SUM(ROUND(EXTRACT(EPOCH FROM time_end - time_start )/60)) AS NUMERIC) / COUNT(order_book_id),2) AS "moyenne temps livraison"
FROM order_ok 
JOIN order_book ON order_book_id = id
GROUP BY ss_number
ORDER BY "moyenne temps livraison";






	
