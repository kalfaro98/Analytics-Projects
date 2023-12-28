use super_market_sales;
select * from supermarket_sales;

-- Q1 what are the top 5 product lines in terms of total spent?
select product_line, sum(Total) as total_spent
from supermarket_sales 
group by product_line
order by total_spent  desc
limit 5;

-- Q2 Rank the cities by highest gross income? 
select city, 
rank() over(order by total_gross_income desc) as city_rank
from
	( select city, sum(gross_income) as total_gross_income
	from supermarket_sales
	group by city
	order by total_gross_income) as temp_table;
    
    -- Q3 Which gender attributed the most to total sales?
SELECT gender, SUM(total) AS total_sales_by_gender
FROM supermarket_sales
GROUP BY gender
ORDER BY total_sales_by_gender DESC
LIMIT 1;

-- Q4 Demogrpahic mix %
select gender, 
	customer_type,
    count(*) as count_by_gender,
    count(*) * 100/ ( select count(*) as count_of_rows
    from supermarket_sales) as percent_mix
    
	from supermarket_sales
    group by gender, customer_type
    order by gender, customer_type;
    
-- Q5 what is the average rating for each product line?
select product_line,
	round(avg(Rating), 2) as avg_rating
       from supermarket_sales
       group by product_line
       order by avg_rating desc;
    
    -- Q6 what is the most used payment type for each gender?
    select gender, payment,
    count(*) as payment_count
    from supermarket_sales
    group by gender, payment 
    order by payment_count desc;
    
    -- Q7 compare the revenue of members VS Normal customer type
    select customer_type,
    sum(case when customer_type = 'Member' then total else 0 end) as member_revenue,
    sum(case when customer_type = 'Normal' then total else 0 end) as normal_revenue
    from supermarket_sales
    group by customer_type;
    
    -- Q8 What was the gross income of product line: Sports and Travel for the month of march?
    select product_line, round(sum(gross_income),2) as rounded_sum
    from supermarket_sales
    where product_line like '%Sports%' and purchase_date like '%3/%/%'
    group by product_line;
    
    -- Q9 which product_line is the most profitable?
    select product_line,
			round(sum(Total-cogs),2) as profit
            from supermarket_sales
            group by product_line
            order by profit desc
            limit 1;
	
    -- Q10 rank each product line based on total quantity purchased?
    select product_line,
			sum(quantity) as total_quantity,
            rank() over (order by sum(quantity) desc) as quantity_rank
            from supermarket_sales
            group by product_line
            order by quantity_rank;
           
    
    
    
    
    
    
    



