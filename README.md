# Azure Data Factory ETL pipeline to Transform E-Commerce Orders and display cleaned data in star schema for reporting
-----------------------------

<img width="806" alt="image" src="https://github.com/user-attachments/assets/041d49ed-ad33-4cce-a2fd-d0bd613c3340" />

## Project Overview
The purpose of this ETL pipeline is to streamline the extraction, transformation, and loading (ETL) process of e-commerce order data into a star schema data model using Azure Data Factory. This pipeline is designed to automate the flow of raw transactional data from various sources into a clean, standardized format, enabling efficient reporting and analysis for business stakeholders.

By leveraging Azure Data Factory (ADF), the pipeline automates key data transformation processes that ensure data accuracy, consistency, and quality while enabling scalability as new data is ingested. The final output is structured in a star schema, which provides a flexible and user-friendly architecture for querying and reporting, supporting various business needs such as sales analysis, customer behavior insights, and inventory management.

## Business Objectives
The goal of the pipeline is to enhance the data-driven decision-making capabilities of the business by providing access to cleaned and structured e-commerce order data for analytics and reporting. Key business objectives include:

__Accurate Reporting:__ Enable the generation of real-time, accurate reports on sales performance, customer orders, inventory status, and more.

__Improved Decision-Making:__ Provide business analysts and decision-makers with structured, reliable data to guide strategic decisions on marketing, sales, and inventory management.

__Sales and Customer Insights:__ Facilitate advanced analytics such as identifying trends in customer purchasing patterns, identifying high-performing products, and analyzing sales forecasts.

__Operational Efficiency:__ Streamline the data flow, reducing manual intervention, and ensure that business teams can focus on deriving insights instead of managing raw data.

__Scalability:__ Ensure that the pipeline can scale as the e-commerce business grows, handling increasing volumes of orders and data sources without impacting performance or reliability.

## Key Components

__Data Extraction:__ Raw data is extracted from various sources, including databases, APIs, or flat files, and ingested into the ADF pipeline.

Data Transformation: The raw order data is cleaned and transformed to ensure it is standardized, validated, and ready for reporting. This includes filtering out invalid records, correcting errors, and applying business rules.


## ETL Process Overview

__STEP 1: Create Cleaned Staging Table for Order Lines__

The staging table will store the cleaned, transformed data before it’s used for reporting.We create a stage_order_lines table, where each row will correspond to 
a single product ordered (one row per product from the multi-value product_ids field).

__STEP 2: Transform & Insert Clean Data Into Staging__

In this step, we transform the raw data into a cleaned format. We handle:

* Converting multiple product IDs into separate rows.
  
* Normalizing the order_date field into a consistent DATE format.

* Parsing and cleaning the price column to a numeric format.

* Clean and explode product_ids into individual rows, parse dates and prices.
  

__STEP 3: Create Cleaned Customer View__

In this step, we clean up customer data (e.g., removing extra spaces, standardizing email format) and store it in a view.


__STEP 4: Final Reporting View — Join Everything__

Now, we join the cleaned stage_order_lines and cleaned_customers data to create a final report that combines order details with customer data.


__STEP 5: Create a final view that aggregates the data for reporting__

This view joins stage_order_lines, cleaned_customers, and raw_products to provide a comprehensive summary of orders, customer details, product info, and calculated totals.

The total_amount is calculated by multiplying quantity by price.

__STEP 6: Query the Final Output__

Now, you can query the final report to see the transformed and cleaned data.


__STEP 7: Build a Star Schema__

For this, we will create a star schema with a fact table for orders and dimension tables for customers and products.


