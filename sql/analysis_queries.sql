/*
===============================================================================
 analysis_queries.sql
===============================================================================
Script Purpose:
    This SQL script performs the analysis for the Sales & Inventory project.
    It includes queries for the following areas:

    A) Sales Analysis
       - Top 10 best-selling products
       - Top 5 customers by spending
       - Revenue per store
       - Revenue per category
       - Monthly sales trend

    B) Inventory Analysis
       - Products with low stock
       - Stores with highest inventory levels

    C) Staff Performance
       - Number of orders handled by each staff member
       - Best-performing staff member by total sales

    D) Customer Insights
       - Customers with no orders
       - Average spending per customer

===============================================================================
*/


-- ============================================
-- a) sales analysis
-- ============================================
USE RetailDB; 
GO 

-- 1. top 10 best-selling products
select top 10
    p.product_id,
    p.product_name,
    sum(oi.quantity) as total_quantity_sold
from orderitems as oi
join products as p on oi.product_id = p.product_id
group by p.product_id, p.product_name
order by total_quantity_sold desc;
go

-- 2. top 5 customers by spending
select top 5
    c.customer_id,
    c.first_name + ' ' + c.last_name as customer_name,
    sum(oi.quantity * oi.list_price) as total_spending
from orders as o
join customers as c on o.customer_id = c.customer_id
join orderitems as oi on o.order_id = oi.order_id
group by c.customer_id, c.first_name, c.last_name
order by total_spending desc;
go

-- 3. revenue per store
select 
    s.store_id,
    s.store_name,
    sum(oi.quantity * oi.list_price) as total_revenue
from orders as o
join stores as s on o.store_id = s.store_id
join orderitems as oi on o.order_id = oi.order_id
group by s.store_id, s.store_name
order by total_revenue desc;
go

-- 4. revenue per category
select 
    c.category_id,
    c.category_name,
    sum(oi.quantity * oi.list_price) as total_revenue
from orderitems as oi
join products as p on oi.product_id = p.product_id
join categories as c on p.category_id = c.category_id
group by c.category_id, c.category_name
order by total_revenue desc;
go

-- 5. monthly sales trend
select 
    year(o.order_date) as year,
    month(o.order_date) as month,
    sum(oi.quantity * oi.list_price) as monthly_revenue
from orders as o
join orderitems as oi on o.order_id = oi.order_id
group by year(o.order_date), month(o.order_date)
order by year, month;
go

-- ============================================
-- b) inventory analysis
-- ============================================

-- 1. products with low stock (less than 10 units)
select 
    p.product_id,
    p.product_name,
    st.store_name,
    s.quantity as stock_quantity
from stocks as s
join products as p on s.product_id = p.product_id
join stores as st on s.store_id = st.store_id
where s.quantity < 10
order by s.quantity asc;
go

-- 2. stores with highest inventory levels
select 
    st.store_id,
    st.store_name,
    sum(s.quantity) as total_stock
from stocks as s
join stores as st on s.store_id = st.store_id
group by st.store_id, st.store_name
order by total_stock desc;
go

-- ============================================
-- c) staff performance
-- ============================================

-- 1. number of orders handled by each staff member
select 
    st.staff_id,
    st.first_name + ' ' + st.last_name as staff_name,
    count(o.order_id) as orders_handled
from staffs as st
left join orders as o on st.staff_id = o.staff_id
group by st.staff_id, st.first_name, st.last_name
order by orders_handled desc;
go

-- 2. best performing staff by total sales
select top 1
    st.staff_id,
    st.first_name + ' ' + st.last_name as staff_name,
    sum(oi.quantity * oi.list_price) as total_sales
from staffs as st
join orders as o on st.staff_id = o.staff_id
join orderitems as oi on o.order_id = oi.order_id
group by st.staff_id, st.first_name, st.last_name
order by total_sales desc;
go

-- ============================================
-- d) customer insights
-- ============================================

-- 1. customers with no orders
select 
    c.customer_id,
    c.first_name + ' ' + c.last_name as customer_name
from customers as c
left join orders as o on c.customer_id = o.customer_id
where o.order_id is null;
go

-- 2. average spending per customer
select 
    avg(customer_total) as avg_spending_per_customer
from (
    select 
        o.customer_id,
        sum(oi.quantity * oi.list_price) as customer_total
    from orders as o
    join orderitems as oi on o.order_id = oi.order_id
    group by o.customer_id
) as customer_totals;
go
