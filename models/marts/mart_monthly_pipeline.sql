-- Show monthly pipeline for all deals (including Churned and Closed Lost)


WITH pipeline_per_month AS (
    SELECT 
        COUNT(deal_id) AS number_of_deals,
        SUM(arr) AS total_arr,
        SUM(CASE --show ARR for Enterprise only
            WHEN segment = 'Enterprise' THEN arr ELSE 0 END) AS total_enterprise_arr,
        DATE_TRUNC('month', close_date) AS month
    FROM {{  ref('stg_deals')  }}
    GROUP BY DATE_TRUNC('month', close_date)
    ORDER BY month
),

monthly_pipeline AS (
    SELECT
        month,
        number_of_deals,
        total_arr,
        total_enterprise_arr,
        -- calculate enterprise rate
        ROUND(total_enterprise_arr / total_arr * 100,2) AS enterprise_rate
    FROM pipeline_per_month
)

SELECT * FROM monthly_pipeline

