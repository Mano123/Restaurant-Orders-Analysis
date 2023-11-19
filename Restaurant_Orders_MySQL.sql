/* Objective 1 : Explore the items table*/

/*View the menu_items table and write a query to find the number of items on the menu*/

SELECT *
FROM menu_items;

SELECT COUNT(DISTINCT menu_item_id)
FROM menu_items;

-- There are 32 items in the menu

/*What are the least and most expensive items on the menu?**/

SELECT *
FROM menu_items
ORDER BY price DESC;

-- The most expensive items is 'Shrimp Scampi'

SELECT *
FROM menu_items
ORDER BY price ASC;

-- The least expensive items is 'Edamame'

/*How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?*/

SELECT COUNT(menu_item_id)
FROM menu_items
WHERE category='Italian';

SELECT *
FROM menu_items
WHERE category='Italian'
ORDER BY price DESC;

SELECT *
FROM menu_items
WHERE category='Italian'
ORDER BY price ASC;

-- There is 9 dishes in the italian menu and the most expensive is 'Shrimp Scampi' and the least expensive is 'Spaghetti'

/*How many dishes are in each category? What is the average dish price within each category?*/

SELECT 
	category,
    COUNT(menu_item_id) AS number_of_dishes,
    AVG(price) AS average_dish_price
FROM menu_items
GROUP BY category;

/*Objective 2 : Explore the orders table*/

/*View the order_details table. What is the date range of the table?*/

SELECT *
FROM order_details;

SELECT
	MIN(order_date),
    MAX(order_date)
FROM order_details;

-- The date range of the table is between '2023-01-01' and '2023-03-31'

/*How many orders were made within this date range? How many items were ordered within this date range?*/

SELECT
	COUNT(DISTINCT order_id) AS Number_of_orders,
    COUNT(item_id) AS Number_of_items
FROM order_details;

-- There are 32 items ordered for 12097 orders

/*Which orders had the most number of items?*/

SELECT
	order_id,
    COUNT(item_id) AS Number_of_items
FROM order_details
GROUP BY order_id
ORDER BY COUNT(item_id) DESC;

-- 7 orders have the most number of items which are 4305, 3473, 1957, 330, 440, 443, 2675.

SELECT COUNT(*) FROM

(SELECT
	order_id,
    COUNT(item_id) AS Number_of_items
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY COUNT(item_id) DESC) AS num_orders;

-- There are 20 orders that have more than 12 items

/*Objective 3 : Analyze customer behavior*/

/*Combine the menu_items and order_details tables into a single table*/

SELECT *
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id;

/*What were the least and most ordered items? What categories were they in?*/

SELECT 
	menu_items.menu_item_id,
    menu_items.item_name,
    menu_items.category,
    COUNT(order_details.item_id) AS number_of_items_ordered
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
GROUP BY
	menu_items.menu_item_id
ORDER BY number_of_items_ordered ASC;

-- The least ordered items is 'Chicken Tacos' and they are in the 'Mexican' category 

SELECT 
	menu_items.menu_item_id,
    menu_items.item_name,
    menu_items.category,
    COUNT(order_details.item_id) AS number_of_items_ordered
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
GROUP BY
	menu_items.menu_item_id
ORDER BY number_of_items_ordered DESC;

-- The most ordered items is 'Hamburger' and they are in the 'American' category

/*What were the top 5 orders that spent the most money?*/

SELECT 
	order_details.order_id,
    SUM(menu_items.price) AS total_spend
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
GROUP BY order_details.order_id
ORDER BY SUM(menu_items.price) DESC
LIMIT 5;

-- In the top 5 of orders that generate the most income, 440 is the most

/*View the details of the highest spend order. Which specific items were purchased*/

SELECT
	menu_items.category,
    COUNT(order_details.item_id) AS num_items
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
WHERE order_details.order_id=440
GROUP BY category
ORDER BY num_items DESC;

/*BONUS: View the details of the top 5 highest spend orders*/

SELECT
	menu_items.category,
    COUNT(order_details.item_id) AS num_items
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
WHERE order_details.order_id=2075
GROUP BY category
ORDER BY num_items DESC;

SELECT
	menu_items.category,
    COUNT(order_details.item_id) AS num_items
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
WHERE order_details.order_id=1957
GROUP BY category
ORDER BY num_items DESC;

SELECT
	menu_items.category,
    COUNT(order_details.item_id) AS num_items
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
WHERE order_details.order_id=330
GROUP BY category
ORDER BY num_items DESC;

SELECT
	menu_items.category,
    COUNT(order_details.item_id) AS num_items
FROM menu_items
LEFT JOIN order_details ON menu_items.menu_item_id=order_details.item_id
WHERE order_details.order_id=2675
GROUP BY category
ORDER BY num_items DESC;

/*Our results show that Italian food is the food that have the most success based on the clients behavior, so i recommend that we stay focus on this dish*/
