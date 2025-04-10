--1.Hazırda neçə məhsul olduğunu təyin edən sorğunu yazın. 

select*from products;

SELECT
    COUNT(*) AS total_products
FROM
    products;


/*2.Son 6 ayda
    konkret təchizatçıdan alınmış bütün məhsulların ümumi alış qiyməti nə qədər olduğunu təyin edən sorğunu yazın. */

SELECT 
    s.supplier_id,
    s.suplier_name,
    SUM(p1.quantity * p1.unit_price) AS total_purchase_amount
FROM 
    purchases p
JOIN 
    purchase_items p1 ON p.purchase_id = p1.purchase_id
JOIN 
    suppliers s ON p.supplier_id = s.supplier_id
WHERE 
    p.purchase_date >= ADD_MONTHS(to_date('31.12.2024','dd.mm.yyyy'), -6)
    AND s.supplier_id =4 -- Buraya konkret təchizatçının ID-sini yaz
GROUP BY 
    s.supplier_id, s.suplier_name;
    select*from suppliers;

/*3.	Hansı təchizatçı son 3 rubde ən çox məhsul təqdim etdiyini göstərən sorğunu yazın. */ 

SELECT 
    s.supplier_id,
    s.suplier_name,
    SUM(pi.quantity) AS total_quantity_supplied
FROM 
    purchases p
JOIN 
    purchase_items pi ON p.purchase_id = pi.purchase_id
JOIN 
    suppliers s ON p.supplier_id = s.supplier_id
WHERE 
    p.purchase_date >= ADD_MONTHS(to_date('31.12.2024','dd.mm.yyyy'), -3)
GROUP BY 
    s.supplier_id, s.suplier_name
ORDER BY 
    total_quantity_supplied DESC
FETCH FIRST 1 ROWS ONLY;

/*4.Ötən həftə nə qədər satış həyata keçirildiyini təyin edən sorğunu yazın. */

SELECT
    COUNT(*) AS total_sales
FROM
    sales
WHERE
    sale_date >= trunc(TO_DATE('27.12.2024', 'dd.mm.yyyy')) - 7;
/*5.Hansı məhsulun qiymətinin ən yüksək olduğunu təyin edən sorğunu yazın.*/

SELECT
    *
FROM
    products
WHERE
    price = (
        SELECT
            MAX(price)
        FROM
            products
    );

/*6. Alınıb amma satılmayan məhsul sayı*/

SELECT
    COUNT(DISTINCT p1.product_id) AS unsold_products
FROM
    purchase_items p1
WHERE
    p1.product_id NOT IN (
        SELECT DISTINCT
            s.product_id
        FROM
            sale_items s
    );


/*7. Ən çox məhsul olan kateqoriya */

SELECT
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM
         categories c
    JOIN products p ON c.category_id = p.category_id
GROUP BY
    c.category_name
ORDER BY
    product_count DESC
FETCH FIRST 1 ROWS ONLY;


/*8. Hər bir məhsulun orta satış qiyməti*/

SELECT
    p.product_name,
    round(AVG(s.unit_price), 2) AS avg_sale_price
FROM
         sale_items s
    JOIN products p ON s.product_id = p.product_id
GROUP BY
    p.product_name;

/*9. Son 3 ayda neçə təchizatçının məhsul tədarük etdiyi*/

SELECT
    COUNT(DISTINCT supplier_id) AS active_suppliers
FROM
    purchases
WHERE
    purchase_date >= add_months(to_date('31.12.2024','dd.mm.yyyy'), - 3);

/*10. Son bir ayda satılmayan məhsullar */

SELECT
    p.product_id,
    p.product_name
FROM
    products p
WHERE
    p.product_id NOT IN (
        SELECT DISTINCT
            si.product_id
        FROM
                 sale_items si
            JOIN sales s ON si.sale_id = s.sale_id
        WHERE
            s.sale_date >= add_months(to_date('31.12.2024','dd.mm.yyyy'), - 1)
    );

select*from sales;

