-- Homework 3

-- Create external table
CREATE OR REPLACE EXTERNAL TABLE `dtc-de-2024-1.ny_taxi.external_ny_green_taxi_2022`
OPTIONS (
  format='PARQUET',
  uris=['https://storage.cloud.google.com/ny_taxi_datasets/ny_green_taxi_2022_data.parquet']
);


-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE `dtc-de-2024-1.ny_taxi.ny_green_taxi_2022`
AS SELECT * FROM `dtc-de-2024-1.ny_taxi.external_ny_green_taxi_2022`;


-- Question 1: What is count of records for the 2022 Green Taxi Data?
SELECT
  COUNT(1)
FROM
  `dtc-de-2024-1.ny_taxi.external_ny_green_taxi_2022`;


-- Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables. What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
SELECT DISTINCT
  PULocationID
FROM
  `dtc-de-2024-1.ny_taxi.external_ny_green_taxi_2022`;


SELECT DISTINCT
  PULocationID  
FROM
  `dtc-de-2024-1.ny_taxi.ny_green_taxi_2022`;


-- Question 3: How many records have a fare_amount of 0?
SELECT
  COUNT(1)
FROM
  `dtc-de-2024-1.ny_taxi.ny_green_taxi_2022`
WHERE
  fare_amount = 0;


-- Question 4: What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime? (Create a new table with this strategy)
-- Creating a partition and cluster table
CREATE OR REPLACE TABLE `dtc-de-2024-1.ny_taxi.ny_green_taxi_2022_partitioned_clustered`
PARTITION BY lpep_pickup_date
CLUSTER BY PULocationID AS
SELECT * FROM `dtc-de-2024-1.ny_taxi.ny_green_taxi_2022`;

-- Question 5:
SELECT
  COUNT(DISTINCT PULocationID) AS PULocationID_distinct
FROM `dtc-de-2024-1.ny_taxi.ny_green_taxi_2022` 
WHERE lpep_pickup_date BETWEEN '2022-06-01' AND '2022-06-30';

SELECT
  COUNT(DISTINCT PULocationID) AS PULocationID_distinct
FROM `dtc-de-2024-1.ny_taxi.ny_green_taxi_2022_partitioned_clustered` 
WHERE lpep_pickup_date BETWEEN '2022-06-01' AND '2022-06-30';
