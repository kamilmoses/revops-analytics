-- compare current month ARR to next month and see if it grows or lowers
-- add COALESCE funcion to remove NULLs


WITH arr_movement AS (
    SELECT 
        month,
        monthly_arr,
        COALESCE(prev_month_arr,0) AS prev_month_arr,
        COALESCE(delta_monthly_arr,0) AS delta_monthly_arr,
        LEAD(monthly_arr) OVER (ORDER BY month) AS next_month_arr
    FROM {{  ref('mart_arr_movement')  }}
),

arr_next_month_movement AS (
    SELECT 
        *,
        (next_month_arr - monthly_arr) AS delta_next_month
    FROM arr_movement
)

SELECT * FROM arr_next_month_movement