-- Customer Churn Analysis using SQL
-- Dataset: Telco Customer Churn
-- Author: Santosh Pal
-- Created: July 2025

-- STEP 1: Create database and use it
CREATE DATABASE telco_db;
USE telco_db;

-- STEP 2: Create customers table with appropriate schema
CREATE TABLE customers (
  customerID VARCHAR(50),
  gender VARCHAR(10),
  SeniorCitizen INT,
  Partner VARCHAR(10),
  Dependents VARCHAR(10),
  tenure INT,
  PhoneService VARCHAR(10),
  MultipleLines VARCHAR(30),
  InternetService VARCHAR(30),
  OnlineSecurity VARCHAR(30),
  OnlineBackup VARCHAR(30),
  DeviceProtection VARCHAR(30),
  TechSupport VARCHAR(30),
  StreamingTV VARCHAR(30),
  StreamingMovies VARCHAR(30),
  Contract VARCHAR(30),
  PaperlessBilling VARCHAR(10),
  PaymentMethod VARCHAR(50),
  MonthlyCharges FLOAT,
  TotalCharges VARCHAR(20),
  Churn VARCHAR(5)
);

-- STEP 3: Query to find high-risk churn customers
-- Filters customers with tenure less than 12 months and month-to-month contracts
SELECT * FROM customers
WHERE tenure < 12 AND Contract = 'Month-to-month';

-- STEP 4: Churn rate by contract type
-- Shows how churn rate varies for different contract types (Month-to-month, One year, Two year)
SELECT Contract,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY Contract;

-- STEP 5: Average monthly charges by churn status
-- Compares billing amounts between churned and retained customers
SELECT Churn, 
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customers
GROUP BY Churn;

-- STEP 6: Churn rate by type of internet service
-- Helps identify if certain services have higher churn rates
SELECT InternetService,
       COUNT(*) AS total,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY InternetService;

-- STEP 7: Churn rate based on whether customer is a senior citizen
-- Highlights if age is a churn factor
SELECT SeniorCitizen,
       COUNT(*) AS total,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY SeniorCitizen;

