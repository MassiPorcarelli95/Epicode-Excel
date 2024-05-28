/* .1: Verificare che i campi definiti come PK siano univoci. */
SELECT 
    'sales' AS tabella,
    id_sales AS id,
    COUNT(*) AS totale
FROM 
    toys__.sales
GROUP BY 
    id_sales
HAVING 
    COUNT(*) > 1

UNION ALL

SELECT 
    'product' AS tabella,
    id_product AS id,
    COUNT(*) AS totale
FROM 
    toys__.product
GROUP BY 
    id_product
HAVING 
    COUNT(*) > 1

UNION ALL

SELECT 
    'region' AS tabella,
    id_region AS id,
    COUNT(*) AS totale
FROM 
    toys__.region
GROUP BY 
    id_region
HAVING 
    COUNT(*) > 1;
   /* 2: Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. */
SELECT 
    p.name_product AS Prodotto, 
    YEAR(s.date_sales) AS Anno, 
    SUM(s.amount_sale) AS Fatturato_Totale
FROM 
    toys__.product p
JOIN 
    toys__.sales s ON p.id_product = s.id_product
GROUP BY 
    p.name_product, YEAR(s.date_sales)
HAVING 
    SUM(s.amount_sale) > 0
ORDER BY 
    Anno, Fatturato_Totale DESC;
 /* 3: Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente. */
SELECT 
    r.name_region AS Stato, 
    YEAR(s.date_sales) AS Anno, 
    SUM(s.amount_sale) AS Fatturato_Totale
FROM 
    toys__.sales s
JOIN 
    toys__.region r ON s.id_product = r.id_product
GROUP BY 
    r.name_region, YEAR(s.date_sales)
ORDER BY 
    Anno ASC, Fatturato_Totale DESC;
   /* 4: Qual è la categoria di articoli maggiormente richiesta dal mercato? */
SELECT 
    p.category_product AS Categoria,
    COUNT(s.id_sales) AS Numero_Vendite
FROM 
    toys__.sales s
JOIN 
    toys__.product p ON s.id_product = p.id_product
GROUP BY 
    p.category_product
ORDER BY 
    Numero_Vendite DESC
LIMIT 1;
/* 5: Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti. */
 /* 5: Prodotti invenduti - Approccio 1 */
SELECT 
    p.name_product AS Prodotto
FROM 
    toys__.product p
LEFT JOIN 
    toys__.sales s ON p.id_product = s.id_product
WHERE 
    s.id_sales IS NULL;
    /* 5: Prodotti invenduti - Approccio 2 */
SELECT 
    name_product AS Prodotto
FROM 
    toys__.product
WHERE 
    id_product NOT IN (SELECT id_product FROM toys__.sales);
    /* 6: Esporre l'elenco dei prodotti con la rispettiva ultima data di vendita */
SELECT 
    p.name_product AS Prodotto,
    MAX(s.date_sales) AS Ultima_Data_Vendita
FROM 
    toys__.product p
LEFT JOIN 
    toys__.sales s ON p.id_product = s.id_product
GROUP BY 
    p.id_product, p.name_product;
    