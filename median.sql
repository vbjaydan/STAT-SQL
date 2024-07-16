--  Getting MEDIAN
WITH cte AS (
    SELECT 
        value, 
        ROW_NUMBER() OVER (ORDER BY value ASC) AS row_num,
        COUNT(*) OVER () AS total_count
    FROM 
        station
)
SELECT 
    ROUND(AVG(value), 4) AS median_value
FROM 
    cte
WHERE 
    row_num IN (FLOOR((total_count + 1) / 2.0), CEIL((total_count + 1) / 2.0));

-- EXPLANATION
-- ROW_NUMBER() OVER (ORDER BY value ASC) AS rnum: This assigns a sequential integer to each row ordered by value
-- COUNT(*) OVER () AS total_count: This calculates the total number of rows.
-- ROUND(AVG(value), 4) AS median_value: Selects the average of the two middle values (for even number of rows) or the single middle value (for odd number of rows), rounded to 4 decimal places.
-- WHERE row_num IN (FLOOR((total_count + 1) / 2.0), CEIL((total_count + 1) / 2.0)): Filters to get the two middle rows for even count or the single middle row for odd count.

-- (TOTAL_COUNT + 1) / 2.0:
-- Adding 1 to total_count ensures that the division by 2 will correctly find the middle of the dataset.
-- Dividing by 2.0 ensures that we get a floating-point result, which is essential for correctly using the FLOOR and CEIL functions.

-- FLOOR((total_count + 1) / 2.0):
-- The FLOOR function rounds the result down to the nearest integer. This gives the lower middle position in case of an even number of rows.
-- For example, if there are 6 rows, (6 + 1) / 2.0 = 3.5, and FLOOR(3.5) results in 3.

-- CEIL((TOTAL_COUNT + 1) / 2.0):
-- The CEIL function rounds the result up to the nearest integer. This gives the upper middle position in case of an even number of rows.
-- For the same example with 6 rows, (6 + 1) / 2.0 = 3.5, and CEIL(3.5) results in 4.
