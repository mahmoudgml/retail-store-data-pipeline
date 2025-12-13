/*
===============================================================================
DDL Script: Create RetailDB Tables
===============================================================================
Script Purpose:
    This script creates all necessary tables for the RetailDB database.
    It ensures that if the tables already exist, they are dropped and recreated.
    The tables follow a normalized design and include primary keys, foreign keys,
    and necessary constraints for maintaining data integrity.

Tables Created:
    - Brands
    - Categories
    - Stores
    - Products
    - Staffs
    - Customers
    - Orders
    - OrderItems
    - Stocks

Usage:
    Execute this script after creating the RetailDB database and its schemas.
    Example: USE RetailDB; GO
===============================================================================
*/

-- ============================================
-- Create Tables
-- ============================================
USE RetailDB; 
GO 

-- Create Brands Table
IF OBJECT_ID('Brands', 'U') IS NOT NULL 
    DROP TABLE Brands;
CREATE TABLE Brands (
    brand_id INT PRIMARY KEY,
    brand_name NVARCHAR(50) NOT NULL
);

-- Create Categories Table
IF OBJECT_ID('Categories', 'U') IS NOT NULL 
    DROP TABLE Categories;
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name NVARCHAR(50) NOT NULL
);

-- Create Stores Table
IF OBJECT_ID('Stores', 'U') IS NOT NULL 
    DROP TABLE Stores;
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name NVARCHAR(50) NOT NULL,
    phone NVARCHAR(50),
    email NVARCHAR(50),
    street NVARCHAR(50),
    city NVARCHAR(50),
    state NVARCHAR(50),
    zip_code NVARCHAR(50)
);

-- Create Products Table
IF OBJECT_ID('Products', 'U') IS NOT NULL 
    DROP TABLE Products;
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(150) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year INT,
    list_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Create Staffs Table
IF OBJECT_ID('Staffs', 'U') IS NOT NULL 
    DROP TABLE Staffs;
CREATE TABLE Staffs (
    staff_id INT PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(50) NOT NULL,
    phone NVARCHAR(50),
    active BIT ,
    store_id INT NOT NULL,
    manager_id INT,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (manager_id) REFERENCES Staffs(staff_id)
);

-- Create Customers Table
IF OBJECT_ID('Customers', 'U') IS NOT NULL 
    DROP TABLE Customers;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    phone NVARCHAR(50),
    email NVARCHAR(50),
    street NVARCHAR(50),
    city NVARCHAR(50),
    state NVARCHAR(50),
    zip_code NVARCHAR(50)
);

-- Create Orders Table
IF OBJECT_ID('Orders', 'U') IS NOT NULL 
    DROP TABLE Orders;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_status INT  NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE,
    shipped_date DATE,
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
);

-- Create OrderItems Table
IF OBJECT_ID('OrderItems', 'U') IS NOT NULL 
    DROP TABLE OrderItems;
CREATE TABLE OrderItems (
    order_id INT NOT NULL,
    item_id NVARCHAR(50) NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(5, 2),
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create Stocks Table
IF OBJECT_ID('Stocks', 'U') IS NOT NULL
    DROP TABLE Stocks;
CREATE TABLE Stocks (
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
GO