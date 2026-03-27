-- show first deals per segment

WITH segment_by_date AS (SELECT 
    *,
    ROW_NUMBER() OVER (
        PARTITION BY segment
        ORDER BY close_date ASC
    ) AS rank_date_by_segment

FROM {{  ref('stg_deals')  }}
WHERE stage = 'Closed Won'
),

first_deals_in_segment AS (
    select *
    FROM segment_by_date
    WHERE rank_date_by_segment = 1
)

SELECT * FROM first_deals_in_segment