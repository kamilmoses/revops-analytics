{{ config(materialized='table') }}

-- UNPIVOT example: transforms wide format (quarters as columns) to long format (quarters as rows)
-- materialized as table instead of view due to DuckDB limitations with UNPIVOT in views

SELECT *
FROM (
    SELECT segment, Q1_2024, Q2_2024, Q3_2024, Q4_2024
    FROM {{ ref('stg_sales_targets') }}
) AS src
UNPIVOT (target_arr FOR quarter IN (Q1_2024, Q2_2024, Q3_2024, Q4_2024))