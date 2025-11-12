TRUNCATE TABLE pizza_sales;

select * from pizza_sales;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

LOAD DATA  INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\pizza_sales.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'datadir';

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pizza_sales.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pizza_sales.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    pizza_id,
    order_id,
    pizza_name_id,
    quantity,
    order_date,
    order_time,
    unit_price,
    total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name
);

select * from pizza_sales;


select round(sum(total_price) / count(distinct order_id),2) as Average_Value from pizza_sales;

select sum(quantity) as Total_Pizza_Sold from pizza_sales;

select count(distinct order_id) as Total_Of_Order from pizza_sales;

select round(sum(quantity) / count(distinct order_id),2) as Avg_Pizza_Per_Order from pizza_sales;

select * from pizza_sales;

SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_per_week,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));

SELECT MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_per_week,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
order by Total_orders desc;

select pizza_category as Category,count(pizza_category) as Number_of_order_by_category,
round(sum(total_price) * 100 / (select sum(total_price) from pizza_sales
 where QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1
),2) as revenue_percentage
 from pizza_sales
 where QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1
group by pizza_category;

select pizza_size as size,count(pizza_size) as Number_of_order_by_size,
round(sum(total_price) * 100 / (select sum(total_price) from pizza_sales 
where QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1) ,2) as revenue_percentage_by_size
 from pizza_sales
 where QUARTER(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1
group by pizza_size
order by revenue_percentage_by_size desc