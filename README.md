# SQL---World-layoffs-DataCleaning-Project

# Project Overview

This project involves cleaning and exploring a dataset of global layoffs from 2020 to 2024 using MySQL. The dataset contained various inconsistencies such as null values, duplicates, and other inconsistencies. The goal was to ensure data quality and extract valuable insights through complex queries.

# Data Cleaning Steps

Handling Null Values:
Identified columns with null values.
Dropped columns with null values where applicable.
Imputed missing values where possible.

# Removing Duplicates:
Detected and removed duplicate rows to ensure data uniqueness.

# Text Cleaning:

Removed non-eligible characters to maintain database compatibility.
Standardized text formats by trimming whitespace and other inconsistency.
Replaced special characters (e.g., single quotes, double quotes, commas) with blank spaces for consistency.

# Data Type Adjustments:
Converted data types to appropriate formats for better database performance and compatibility.

# Data Exploration

Common Table Expressions (CTEs):
Utilized CTEs to break down complex queries into manageable parts.
Analyzed trends in layoffs over the years, identifying peak periods and industries most affected.

# Aggregations and Grouping:

Performed aggregations to calculate total layoffs by year, industry, and country.
Grouped data to find highest layoffs per company and per industry.

# Tools and Technologies

MySQL: Used for executing SQL queries to clean and explore the data.
SQL Queries: Employed various SQL functions and commands, including CTEs, and joins to handle data inconsistencies and extract insights.

# Conclusion
The cleaned and explored dataset provides valuable insights into global layoffs from 2020 to 2024. This project demonstrates the importance of data cleaning and the power of SQL in uncovering trends and patterns in large datasets.
