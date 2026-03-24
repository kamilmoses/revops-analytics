WITH monthly_arr AS (
    SELECT
        CAST(DATE_TRUNC('month',close_date) AS DATE) as month,
        SUM(arr) as monthly_arr
    FROM {{  ref('stg_deals')  }}
    WHERE stage = 'Closed Won'
    GROUP BY DATE_TRUNC('month', close_date)
    ORDER BY month asc
),

prev_monthly_arr AS (
    SELECT
        *,
        LAG(monthly_arr) OVER (ORDER BY month) as prev_month_arr
    FROM monthly_arr
),

delta_monthly_arr AS (
    SELECT 
        *,
        monthly_arr - prev_month_arr as delta_monthly_arr
    FROM prev_monthly_arr
)



SELECT * FROM delta_monthly_arr