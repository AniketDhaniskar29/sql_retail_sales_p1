-- SQL Retails sales Analysis - P1
create database sql_project_p2;

-- Data Cleaning

select * from retails_sales1
where transactions_id is Null

select * from retails_sales1
where sale_time is Null

select * from retails_sales1
where gender is Null
      or
	  age is null
	  or
	  category is null
	  or 
	  quantiy is null
	  or
	  cogs is null
	  or
	  total_sale is null


delete from retails_sales1
where 
       gender is Null
      or
	  age is null
	  or
	  category is null
	  or 
	  quantiy is null
	  or
	  cogs is null
	  or
	  total_sale is null

-- Data Exploration
-- How many sales we have

Select count(*) as total_sale from retails_sales1;

-- How many customers we have

Select count(Distinct customer_id) as total_customers from retails_sales1;

-- Category

Select Distinct category as total_category from retails_sales1;

-- Data Analysis
-- 1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
select * from retails_sales1
where sale_date = '2022-11-05';

--2. **Write a SQL query to retrieve all transactions where the category is 
--'Clothing' and the quantity sold is less than or equals to 4 in the month of Nov-2022**:

SELECT * 
FROM retails_sales1
WHERE category = 'Clothing'
AND quantiy <= 4 
AND sale_date >= '2022-11-01' 
AND sale_date < '2022-12-01';

--3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

--Method 1
select category,
       sum(quantiy * price_per_unit) as Total_Sales
	   from retails_sales1
	   group by category
	   order by Total_Sales Desc;

--Method 2
select category,
       sum(total_sale) as net_sale
from retails_sales1
group by category


-- 4. **Write a SQL query to find the average age of customers who purchased items 
--from the 'Beauty' category.**:

Select 
    Round(avg(age),2) as avg_age
from retails_sales1
where category ='Beauty'

--5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

select * from retails_sales1
where total_sale > 1000

--6. **Write a SQL query to find the total number of transactions (transaction_id) 
--made by each gender in each category.**:

select category, gender,
count(*) as total_trans
from retails_sales1
group by
category,
gender
order by category

--7. **Write a SQL query to calculate the average sale for each month. 
--Find out best selling month in each year**:

with monthly_sales as(
select 
     year(sale_date) as year,
	 month(sale_date) as month,
	 avg(total_sale) as avg_sale
from retails_sales1
group by year(sale_date), month(sale_date)
)
select year, month, avg_sale
from monthly_sales
where avg_sale = (
      select max(avg_sale)
	  from monthly_sales as sub
	  where sub.year = monthly_sales.year
	  )
order by year, month

--8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
select top 5 
      customer_id,
	  sum(total_sale) as total_sales
from retails_sales1
group by customer_id
order by total_sales desc

--9. **Write a SQL query to find the number of unique customers who purchased items 
--from each category.**

select category,
count(distinct customer_id)
from retails_sales1
group by category


-- 10. **Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

SELECT 
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS number_of_orders
FROM retails_sales1
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY number_of_orders DESC;



 
