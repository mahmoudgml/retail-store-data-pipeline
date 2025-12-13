/*
===================================================
Create Database 
===================================================
Script Purpose:
    This script creates a new database named 'RetailDB' after checking
    whether it already exists. If the database exists, it will be dropped
    and recreated.

WARNING:
    Running this script will DROP the entire 'RetailDB' database if it exists.
    All data in this database will be permanently deleted. Proceed with caution
    and ensure you have a proper backup before executing this script.
===============================================================================
*/

USE master; 
GO 

-- Drop and create the 'RetailDB' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'RetailDB')
BEGIN 
    ALTER DATABASE RetailDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE; 
    DROP DATABASE RetailDB; 
END; 
GO

-- Create Database 'RetailDB'
CREATE DATABASE RetailDB; 
GO 

USE RetailDB; 
GO 

