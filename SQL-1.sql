USE my_guitar_shop;
-- Q6
SELECT category_name, product_name, list_price FROM categories 
JOIN products ON categories.category_id=products.category_id
ORDER BY category_name ASC, product_name ASC;
-- Q7
SELECT first_name, last_name, line1, city, state, zip_code FROM customers
JOIN addresses ON customers.customer_id= addresses.customer_id
WHERE email_address = 'allan.sherwood@yahoo.com';
-- Q8
SELECT first_name, last_name, line1, city, state, zip_code FROM customers
JOIN addresses ON customers.customer_id= addresses.customer_id
WHERE address_id IN (SELECT shipping_address_id FROM customers);
-- Q9
SELECT last_name, first_name, order_date, product_name, item_price, discount_amount, quantity 
FROM customers JOIN orders ON customers.customer_id=orders.customer_id
JOIN order_items ON orders.order_id=order_items.order_id
JOIN products ON order_items.product_id=products.product_id
ORDER BY last_name, order_date, product_name ;
-- Q9 Try 2
SELECT last_name, first_name, order_date, product_name, item_price, discount_amount, quantity 
FROM customers a JOIN orders b ON a.customer_id=b.customer_id
JOIN order_items c ON b.order_id=c.order_id
JOIN products d ON c.product_id=d.product_id
ORDER BY last_name, order_date, product_name ;
-- Q10
SELECT product_name, list_price FROM products x
WHERE list_price IN (SELECT list_price FROM products y WHERE x.product_name != y.product_name);
-- Q11
SELECT 'SHIPPED' AS 'ship_status', order_id, order_date FROM orders WHERE ship_date IS NOT NULL
UNION
SELECT 'NOT SHIPPED' AS 'ship_status', order_id, order_date FROM orders WHERE ship_date IS NULL 
ORDER BY order_date;
-- Q12
SELECT category_name, COUNT(product_id), MAX(list_price) FROM categories 
LEFT JOIN products ON categories.category_id= products.category_id
GROUP BY category_name
ORDER BY COUNT(product_id) DESC;
-- Q13
SELECT email_address, COUNT(DISTINCT order_id), SUM(Order_amount) AS 'Order_total' FROM customers JOIN 
(SELECT customer_id, orders.order_id, (item_price-discount_amount)*quantity AS 'Order_amount' FROM orders
JOIN order_items ON orders.order_id=order_items.order_id ) AS subtable
ON customers.customer_id = subtable.customer_id
GROUP BY email_address
HAVING (COUNT(DISTINCT order_id)>1)
ORDER BY Order_total DESC;
-- Q14
SELECT email_address, COUNT(DISTINCT product_id) AS 'COUNTS' FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY email_address
HAVING COUNTS>1;
-- Q15
SELECT product_name, list_price FROM products
WHERE list_price > (SELECT AVG(list_price) FROM products)
ORDER BY list_price DESC;
-- Q16
SELECT category_name FROM categories
WHERE (NOT EXISTS(SELECT * FROM products WHERE products.category_id = categories.category_id));
-- Q17
SELECT email_address, MAX(order_total) FROM 
	(SELECT email_address, orders.order_id, SUM((item_price-discount_amount)*quantity) AS 'order_total' FROM customers
	JOIN orders ON customers.customer_id = orders.customer_id
	JOIN order_items ON orders.order_id = order_items.order_id
    GROUP BY orders.order_id) AS table1
GROUP BY email_address;
-- Q18
SELECT product_name, discount_percent FROM products x
WHERE x.discount_percent NOT IN (SELECT discount_percent FROM products y WHERE x.product_name<>y.product_name)
ORDER BY product_name;
-- Q19
SELECT list_price, FORMAT(list_price,1) , CONVERT(list_price, SIGNED), CAST(list_price AS SIGNED),
	date_added, CAST(date_added AS date), CAST(date_added AS CHAR(7) ), CAST(date_added AS time)FROM products;
-- Q20
SELECT card_number, LENGTH(card_number), RIGHT(card_number,4), CONCAT('XXXX-XXXX-XXXX-',RIGHT(card_number,4)) FROM orders;



-- Check Answers
-- Q17
CREATE VIEW t AS (SELECT email_address, o.order_id, SUM((item_price-discount_amount)*quantity) AS 'order_total' 
FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY email_address, o.order_id);

SELECT email_address, order_id, order_total FROM t AS a
WHERE order_total=(select max(order_total) FROM t AS b WHERE a.email_address=b.email_address);

/*
SELECT email_address, o.order_id, SUM((item_price-discount_amount)*quantity) AS 'order_total' FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY email_address, o.order_id；
*/

SELECT email_address, orders.order_id, SUM((item_price-discount_amount)*quantity) AS 'order_total' FROM customers
	JOIN orders ON customers.customer_id = orders.customer_id
	JOIN order_items ON orders.order_id = order_items.order_id
    GROUP BY orders.order_id;









 