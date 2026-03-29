SELECT
    account_id,
    account_name,
    country,
    industry,
    CAST(account_created_date AS DATE) AS account_created_date
FROM {{  ref('accounts')  }}