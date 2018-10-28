-- Create Database Schema --

CREATE DATABASE Assignment;

-- update safe mode option for bulk update
SET SQL_SAFE_UPDATES = 0;

-- Use the newly created schema for default use

USE assignment;

-- create table based on given CSV file - bajaj auto
CREATE TABLE `bajaj` (
    `date` DATE DEFAULT NULL,
    `Open Price` DOUBLE DEFAULT NULL,
    `High Price` DOUBLE DEFAULT NULL,
    `Low Price` DOUBLE DEFAULT NULL,
    `Close Price` DOUBLE DEFAULT NULL,
    `WAP` DOUBLE DEFAULT NULL,
    `No.of Shares` INT(11) DEFAULT NULL,
    `No. of Trades` INT(11) DEFAULT NULL,
    `Total Turnover (Rs.)` DOUBLE DEFAULT NULL,
    `Deliverable Quantity` INT(11) DEFAULT NULL,
    `% Deli. Qty to Traded Qty` DOUBLE DEFAULT NULL,
    `Spread High-Low` DOUBLE DEFAULT NULL,
    `Spread Close-Open` DOUBLE DEFAULT NULL
);

-- create other table for tcs infosys, hero, eicher, tvs motors similar to above structure

CREATE TABLE tcs AS SELECT * FROM
    bajaj;
CREATE TABLE infosys AS SELECT * FROM
    bajaj;
CREATE TABLE hero AS SELECT * FROM
    bajaj;
CREATE TABLE eicher AS SELECT * FROM
    bajaj;
CREATE TABLE bajaj AS SELECT * FROM
    bajaj;
CREATE TABLE tvsmotor AS SELECT * FROM
    bajaj;

-- Used mysql import wizrd to load csv data into the table.
-- Pre Load data cleanup in Excel ->  Before importing updated all the CSVs by modifying date field to YYYY-MM-DD to avoid issues with date operations post import.
-- Modified date column type to date format for effective use

ALTER TABLE bajaj MODIFY `date` DATE;
ALTER TABLE eicher MODIFY `date` DATE;
ALTER TABLE hero MODIFY `date` DATE;
ALTER TABLE infosys MODIFY `date` DATE;
ALTER TABLE tcs MODIFY `date` DATE;
ALTER TABLE tvsmotors MODIFY `date` DATE;

-- Problem Statement 1 - creating new table with 20 and 50 day moving averages
-- Query to extract moving averages for bajaj - 888 rows inserted

SELECT 
    a.`Date`,
    a.`Close Price`,
    ROUND(AVG(b.`Close Price`), 2) AS `20 Day MA`,
    ROUND(AVG(c.`Close Price`), 2) AS `50 Day MA`
FROM
    bajaj a
        INNER JOIN
    bajaj b ON b.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 19 DAY) AND a.`date`
        INNER JOIN
    bajaj c ON c.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 49 DAY) AND a.`date`
GROUP BY 1
ORDER BY 1;

-- creating new table with above filter query - Bajaj - 888 rows inserted
CREATE TABLE bajaj1 AS SELECT a.`Date`,
    a.`Close Price`,
    ROUND(AVG(b.`Close Price`), 2) AS `20 Day MA`,
    ROUND(AVG(c.`Close Price`), 2) AS `50 Day MA` FROM
    bajaj a
        INNER JOIN
    bajaj b ON b.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 19 DAY) AND a.`date`
        INNER JOIN
    bajaj c ON c.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 49 DAY) AND a.`date`
GROUP BY 1
ORDER BY 1;

-- Creating new table with above filter query - eicher -  888 rows inserted
CREATE TABLE eicher1 AS SELECT a.`Date`,
    a.`Close Price`,
    ROUND(AVG(b.`Close Price`), 2) AS `20 Day MA`,
    ROUND(AVG(c.`Close Price`), 2) AS `50 Day MA` FROM
    eicher a
        INNER JOIN
    eicher b ON b.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 19 DAY) AND a.`date`
        INNER JOIN
    eicher c ON c.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 49 DAY) AND a.`date`
GROUP BY 1
ORDER BY 1;

-- creating new table with above filter query - hero - - 888 rows inserted
CREATE TABLE hero1 AS SELECT a.`Date`,
    a.`Close Price`,
    ROUND(AVG(b.`Close Price`), 2) AS `20 Day MA`,
    ROUND(AVG(c.`Close Price`), 2) AS `50 Day MA` FROM
    hero a
        INNER JOIN
    hero b ON b.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 19 DAY) AND a.`date`
        INNER JOIN
    hero c ON c.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 49 DAY) AND a.`date`
GROUP BY 1
ORDER BY 1;

-- Creating new table with above filter query - infosys - 888 rows inserted

CREATE TABLE infosys1 AS SELECT a.`Date`,
    a.`Close Price`,
    ROUND(AVG(b.`Close Price`), 2) AS `20 Day MA`,
    ROUND(AVG(c.`Close Price`), 2) AS `50 Day MA` FROM
    infosys a
        INNER JOIN
    infosys b ON b.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 19 DAY) AND a.`date`
        INNER JOIN
    infosys c ON c.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 49 DAY) AND a.`date`
GROUP BY 1
ORDER BY 1;

-- creating new table with above filter query - tcs -  888 rows inserted
CREATE TABLE tcs1 AS SELECT a.`Date`,
    a.`Close Price`,
    ROUND(AVG(b.`Close Price`), 2) AS `20 Day MA`,
    ROUND(AVG(c.`Close Price`), 2) AS `50 Day MA` FROM
    tcs a
        INNER JOIN
    tcs b ON b.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 19 DAY) AND a.`date`
        INNER JOIN
    tcs c ON c.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 49 DAY) AND a.`date`
GROUP BY 1
ORDER BY 1;

-- creating new table with above filter query - tvsmotors - 888 rows inserted
CREATE TABLE tvsmotors1 AS SELECT a.`Date`,
    a.`Close Price`,
    ROUND(AVG(b.`Close Price`), 2) AS `20 Day MA`,
    ROUND(AVG(c.`Close Price`), 2) AS `50 Day MA` FROM
    tvsmotors a
        INNER JOIN
    tvsmotors b ON b.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 19 DAY) AND a.`date`
        INNER JOIN
    tvsmotors c ON c.`date` BETWEEN DATE_SUB(a.`date`, INTERVAL 49 DAY) AND a.`date`
GROUP BY 1
ORDER BY 1;

-- Problem Statement 2 - Create master table containing 6 stocks with columns date, bajaj, tvs, infosys, eicher,hero
-- Query that merge close price from all tables - 887 rows joined and fetched
SELECT 
    a.`Date` AS 'Date',
    a.`Close Price` AS 'Bajaj',
    b.`Close Price` AS 'TCS',
    c.`Close Price` AS 'TVS',
    d.`Close Price` AS 'Infosys',
    e.`Close Price` AS 'Eicher',
    f.`Close Price` AS 'Hero'
FROM
    bajaj a
        JOIN
    tcs b ON a.`date` = b.`date`
        JOIN
    tvsmotors c ON a.`date` = c.`date`
        JOIN
    infosys d ON a.`date` = d.`date`
        JOIN
    eicher e ON a.`date` = e.`date`
        JOIN
    hero f ON a.`date` = f.`date`;

-- create master table using above merge query - 887 rows inserted
CREATE TABLE mastertable AS SELECT a.`Date` AS 'Date',
    a.`Close Price` AS 'Bajaj',
    b.`Close Price` AS 'TCS',
    c.`Close Price` AS 'TVS',
    d.`Close Price` AS 'Infosys',
    e.`Close Price` AS 'Eicher',
    f.`Close Price` AS 'Hero' FROM
    bajaj a
        JOIN
    tcs b ON a.`date` = b.`date`
        JOIN
    tvsmotors c ON a.`date` = c.`date`
        JOIN
    infosys d ON a.`date` = d.`date`
        JOIN
    eicher e ON a.`date` = e.`date`
        JOIN
    hero f ON a.`date` = f.`date`;

-- Problem statement 3 - Generate Buy/Sell/Hold signal based on golden/death cross rules.  Case statement is used to generate signal column values
-- Signal Table for Bajaj
CREATE TABLE bajaj2 AS SELECT a.`date`,
    a.bajaj,
    CASE
        WHEN b.`20 Day MA` > b.`50 Day MA` THEN 'BUY'
        WHEN b.`20 Day MA` < b.`50 Day MA` THEN 'SELL'
        WHEN b.`20 Day MA` = b.`50 Day MA` THEN 'HOLD'
    END AS 'Signal' FROM
    mastertable a
        JOIN
    bajaj1 b ON a.`date` = b.`date`;

-- Signal Table for Eicher
CREATE TABLE eicher2 AS SELECT a.`date`,
    a.eicher,
    CASE
        WHEN b.`20 Day MA` > b.`50 Day MA` THEN 'BUY'
        WHEN b.`20 Day MA` < b.`50 Day MA` THEN 'SELL'
        WHEN b.`20 Day MA` = b.`50 Day MA` THEN 'HOLD'
    END AS 'Signal' FROM
    mastertable a
        JOIN
    eicher1 b ON a.`date` = b.`date`;

-- Signal Table for hero
CREATE TABLE hero2 AS SELECT a.`date`,
    a.hero,
    CASE
        WHEN b.`20 Day MA` > b.`50 Day MA` THEN 'BUY'
        WHEN b.`20 Day MA` < b.`50 Day MA` THEN 'SELL'
        WHEN b.`20 Day MA` = b.`50 Day MA` THEN 'HOLD'
    END AS 'Signal' FROM
    mastertable a
        JOIN
    hero1 b ON a.`date` = b.`date`;

-- Signal Table for infosys
CREATE TABLE infosys2 AS SELECT a.`date`,
    a.infosys,
    CASE
        WHEN b.`20 Day MA` > b.`50 Day MA` THEN 'BUY'
        WHEN b.`20 Day MA` < b.`50 Day MA` THEN 'SELL'
        WHEN b.`20 Day MA` = b.`50 Day MA` THEN 'HOLD'
    END AS 'Signal' FROM
    mastertable a
        JOIN
    infosys1 b ON a.`date` = b.`date`;


-- Signal Table for tcs
CREATE TABLE tcs2 AS SELECT a.`date`,
    a.tcs,
    CASE
        WHEN b.`20 Day MA` > b.`50 Day MA` THEN 'BUY'
        WHEN b.`20 Day MA` < b.`50 Day MA` THEN 'SELL'
        WHEN b.`20 Day MA` = b.`50 Day MA` THEN 'HOLD'
    END AS 'Signal' FROM
    mastertable a
        JOIN
    tcs1 b ON a.`date` = b.`date`;

-- Signal Table for Tvsmotors
CREATE TABLE tvsmotors2 AS SELECT a.`date`,
    a.tvs,
    CASE
        WHEN b.`20 Day MA` > b.`50 Day MA` THEN 'BUY'
        WHEN b.`20 Day MA` < b.`50 Day MA` THEN 'SELL'
        WHEN b.`20 Day MA` = b.`50 Day MA` THEN 'HOLD'
    END AS 'Signal' FROM
    mastertable a
        JOIN
    tvsmotors1 b ON a.`date` = b.`date`;

-- Problem statement 4 - User defined function to generate signal for a given date and stock name.
-- Developed UDF that can accept date and returns recommendations. 
Delimiter $$
-- Delimiter option changed for better interpretation
DROP FUNCTION IF EXISTS recommendation$$

CREATE FUNCTION recommendation (entrydate DATE) RETURNS VARCHAR(10)
	DETERMINISTIC
BEGIN
   -- Declare the return and table parameter for interal use
	DECLARE recommendation VARCHAR(10); 
   	-- Extract the recommendation from signal column from tables created in Problem statement 3
    SELECT
      a.`signal` INTO recommendation
	FROM bajaj2 a
	WHERE a.`date`= entrydate;
    -- return the extracted outcome
    RETURN(recommendation);
END $$
-- reset the delimiter to semicolon.
Delimiter ;

-- demonstation of result from query, returns 'BUY' under Recommendation column
SELECT RECOMMENDATION('2018-07-17') AS 'Recommendation'

-- Problem Statement 5 - Summary is provided in AssignmentSummary.pdf.

-- End --
