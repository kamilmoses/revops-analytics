SELECT
    deal_id,
    account_name,
    segment,
    arr,
    acv,
    stage,
    CAST(close_date AS DATE) AS close_date,
    CAST(is_renewal AS BOOLEAN) AS is_renewal,
    churn_reason
FROM {{ ref('deals') }}