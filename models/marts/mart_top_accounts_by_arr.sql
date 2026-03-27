--Show top accounts per Closed-Won ARR, rank them in ASC order and show top 50% deals and bottom 50% deals

WITH grouped_by_accounts AS (
    SELECT 
        account_name,
        SUM(arr) as total_arr,
        count(deal_id) as total_deals,
        AVG(arr) as avg_arr
    FROM {{  ref('stg_deals')  }}
    WHERE stage = 'Closed Won'
    GROUP BY account_name
),

ranked_accounts AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_arr DESC) AS rank_by_arr,
        --calculate percentile per 50% top and bottom deals by total ARR
        NTILE(2) OVER (
            ORDER BY total_arr DESC) AS top_or_bottom_50
    FROM grouped_by_accounts
)

SELECT * FROM ranked_accounts