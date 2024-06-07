SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM pizza_types;
SELECT * FROM pizzas;


create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));


create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));

-- Basic:
-- Q1 Retrieve the total number of orders placed.
SELECT COUNT(*) as total_orders FROM orders;

-- Q2 Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details AS od
        LEFT JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id;
    
-- Q3 Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizza_types AS pt
        LEFT JOIN
    pizzas AS p USING (pizza_type_id)
ORDER BY price DESC
LIMIT 1; 

-- Q4 Identify the most common pizza size ordered.
SELECT 
    p.size AS most_comman_size, COUNT(od.order_details_id) AS total
FROM
    order_details AS od
        LEFT JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY size
ORDER BY total DESC;


-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name,SUM(od.quantity) as quantity
FROM
    pizza_types as pt 
        JOIN
        pizzas AS p 
        ON pt.pizza_type_id = p.pizza_type_id
    JOIN 
     order_details AS od
    ON od.pizza_id = p.pizza_id
    GROUP BY pt.name ORDER BY quantity DESC LIMIT 5;
