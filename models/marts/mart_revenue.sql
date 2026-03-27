-- Monitor Revenue performence of all Closed Won deals 
-- showing cumulated ARR by date
-- and ranking by segment


-- Get required columns from staging
WITH base AS (
    SELECT
        deal_id,
        account_name,
        segment,
        arr,
        acv,
        stage,
        close_date,
        is_renewal,
        churn_reason
    FROM {{ ref('stg_deals') }}
),

-- filter by Closed Won deals only
closed_won AS (
    SELECT *
    FROM base
    WHERE stage = 'Closed Won'
),

-- add cumulative_arr and ranking per segment
final AS (
    SELECT
        deal_id,
        account_name,
        segment,
        arr,
        acv,
        close_date,
        is_renewal,
        -- Window function: skumulowany ARR po dacie zamknięcia
        SUM(arr) OVER (
            ORDER BY close_date
        ) AS cumulative_arr,
        -- Window function: ranking dealów po ARR w ramach segmentu
        RANK() OVER (
            PARTITION BY segment
            ORDER BY arr DESC
        ) AS rank_in_segment
    FROM closed_won
)

SELECT * FROM final