
Select * from pizza_sales

Select sum(total_price) as Total_Revenue
 from pizza_sales

 select sum(total_price) / count(distinct order_id) as Ave_Order_Value
 from pizza_sales

 select sum(quantity) as Total_Pizza_Sold
 from pizza_sales

 select count(distinct order_id) as Total_Orders
 from pizza_sales
 
 select sum(quantity) / count(distinct order_id) as Avg_Pizzas_per_Order
 from pizza_sales

 select
 cast (sum(quantity) as decimal(10,2)) / 
 cast (count(distinct order_id) as decimal(10,2)) as Avg_Pizzas_per_Order
 from pizza_sales

 select
	CAST (cast (sum(quantity) as decimal(10,2)) / 
	cast (count(distinct order_id) as decimal(10,2)) AS DECIMAL(10,2)) as Avg_Pizzas_per_Order
 from pizza_sales

 -- Daily Trends
 select datename(DW, order_date) as Order_Day,
		count (distinct order_id) as Total_Orders
 from pizza_sales
 group by datename(DW, order_date)
 
  -- Hourly Trends
 select datepart (hour, order_time) as Order_Hours,
		count (distinct order_id) as Total_Orders
 from pizza_sales
 group by datepart (hour, order_time)
 order by count (distinct order_id)

 select pizza_category, sum(total_price) as Total_sales, sum(total_price) * 100 / 
 (select sum(total_price) from pizza_sales) as Pct_Total_Sales_by_Cat
 from pizza_sales
 group by pizza_category

 select pizza_category, sum(total_price) as Total_sales, sum(total_price) * 100 / 
 (select sum(total_price) from pizza_sales where month(order_date) = 1) as Pct_Total_Sales_by_Cat
 from pizza_sales
 where month(order_date) = 1
 group by pizza_category

 select pizza_size, sum(total_price) as Total_sales, sum(total_price) * 100 / 
 (select sum(total_price) from pizza_sales) as Pct_Total_Sales_by_Size
 from pizza_sales
 group by pizza_size

 select pizza_size, cast (sum(total_price) as decimal(10,2)) as Total_sales, 
 cast (sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as Pct_Total_Sales_by_Size
 from pizza_sales
 group by pizza_size
 order by Pct_Total_Sales_by_Size desc

 select pizza_size, cast (sum(total_price) as decimal(10,2)) as Total_sales, 
 cast (sum(total_price) * 100 / (select sum(total_price) from pizza_sales where datepart (quarter, order_date) = 1) as decimal(10,2)) as Pct_Total_Sales_by_Size
 from pizza_sales
 where datepart (quarter, order_date) = 1
 group by pizza_size
 order by Pct_Total_Sales_by_Size desc

 select pizza_category, sum(quantity) as Total_by_Category
 from pizza_sales
 group by pizza_category

 select top 5 pizza_name, sum(quantity) as Bestsellers
 from pizza_sales
 group by pizza_name
 order by Bestsellers desc

 select top 5 pizza_name, sum(quantity) as Worstsellers
 from pizza_sales
 group by pizza_name
 order by Worstsellers


 select * from pizza_sales