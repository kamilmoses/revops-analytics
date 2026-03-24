-- group ARR by month
WITH monthly_arr AS (
    SELECT
        CAST(DATE_TRUNC('month',close_date) AS DATE) as month,
        SUM(arr) as monthly_arr
    FROM {{  ref('stg_deals')  }}
    WHERE stage = 'Closed Won'
    GROUP BY DATE_TRUNC('month', close_date)
    ORDER BY month asc
),
-- add new column 'prev_month_arr' to compare ARR to previous month
prev_monthly_arr AS (
    SELECT
        *,
        LAG(monthly_arr) OVER (ORDER BY month) as prev_month_arr
    FROM monthly_arr
),
-- add new column 'delta_monthly_arr' to show delta between months (preformance month-to-month)
delta_monthly_arr AS (
    SELECT 
        *,
        monthly_arr - prev_month_arr as delta_monthly_arr
    FROM prev_monthly_arr
)



SELECT * FROM delta_monthly_arr