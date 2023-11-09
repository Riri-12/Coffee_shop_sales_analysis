
--- imported csv file to mysql---
----checking all columns and rows--
select *
from coffee_shop_sales_csv2;

-- checking duplicate in column transaction_id
select distinct transaction_id
from coffee_shop_sales_csv2;

------ checking null, 0 values

select *
from coffee_shop_sales_csv2
where transaction_id is null or transaction_id = "0" or
transaction_time is null or transaction_time = '0' or
transaction_qty is null or transaction_qty ='0' or
store_id is null or store_id = '0' or
store_location is null or store_location = '0' or
product_id is null or product_id = '0' or
unit_price is null or unit_price = '0' or
product_category is null or product_category = '0' or
product_type is null or product_type = '0' or
product_detail is null or product_detail = '0';

------- adding a column Total sales
alter table coffee_shop_sales_csv2
add total_sales INT null After product_detail;

---- checking new added column
select total_sales from coffee_shop_sales_csv2;

--- updating Total_Sales column
SET SQL_SAFE_UPDATES = 0;
update coffee_shop_sales_csv2
set total_sales = unit_price * transaction_qty; 

----checking total sales column values less than 0
 select total_sales
 from coffee_shop_sales_csv2
 where total_sales <0;
 
----- DATA ANALYSIS---
---- trends within a year
select 
date_format(transaction_date, '%Y-%M') as month,
sum(total_sales)
from coffee_shop_sales_csv2
group by month
order by month;

----- busiest day of the week----
SELECT
    DAYNAME(transaction_date) AS DayOfWeek,
    COUNT(*) AS TransactionCount
FROM Coffee_Shop_Sales_CSV2
GROUP BY DayOfWeek
ORDER BY TransactionCount DESC;

-------- busiest hour of the day---
SELECT
    DATE_FORMAT(transaction_time, '%H:00') AS HourOfDay,
    COUNT(*) AS TransactionCount
FROM Coffee_Shop_Sales_CSV2
GROUP BY HourOfDay
ORDER BY TransactionCount desc
limit 1;

------ most sold products
select 
product_category, 
sum(transaction_qty) as total_quantity
from coffee_shop_sales_csv2
group by product_category
order by total_quantity desc;

--- least sold products
select 
product_category, 
sum(transaction_qty) as total_quantity
from coffee_shop_sales_csv2
group by product_category
order by total_quantity asc;


----- most sales by location--
select store_location,
sum(total_sales) as total_sales_location
from coffee_shop_sales_csv2
group by store_location
order by total_sales_location desc;







