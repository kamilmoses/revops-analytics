-- model to analyze churn on all renewals

-- filter all renewals
WITH renewal_deals as (
    SELECT
        * 
    FROM {{  ref('stg_deals')  }}
    WHERE is_renewal = TRUE
),

-- sum all Renewal ARR and Churned ARR
churn_analysis  as (
    SELECT 
        sum(arr) as total_renewal_arr,
        SUM(CASE
            WHEN stage = 'Churned' THEN arr ELSE 0 END) AS churned_arr

    FROM renewal_deals),

-- calculate churn rate
churn_rate as (
    SELECT
        *,
        ROUND(churned_arr / total_renewal_arr * 100, 2) as churn_rate
    FROM churn_analysis
)

SELECT * FROM churn_rate