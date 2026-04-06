-- show segment arr grouped by month for all Closed Won deals


WITH monthly_segment_arr AS (
    PIVOT (
        SELECT 
            DATE_TRUNC('month',close_date) as month,
            segment,
            COALESCE(arr, 0) as arr
        FROM {{  ref('stg_deals')  }}
        WHERE stage = 'Closed Won'
    )
    ON segment IN ('Enterprise', 'Mid-Market', 'SMB')
    --use COALESCE to change all nulls in arr to 0
    USING COALESCE(SUM(arr),0)
    GROUP BY month
    ORDER BY month ASC
)

SELECT * FROM monthly_segment_arr