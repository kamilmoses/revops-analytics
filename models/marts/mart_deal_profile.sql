--show all deals with additional account and contact details

WITH all_deals AS (
    SELECT 
        d.*,
        a.country AS country,
        a.industry AS industry,
        a.account_id
    FROM {{  ref('stg_deals')  }} d
    LEFT JOIN {{  ref('stg_accounts')  }} a ON d.account_name = a.account_name
),

deals_with_decision_makers AS (
    SELECT 
        l.*,
        CASE WHEN 
            c.is_decision_maker = TRUE THEN c.contact_name ELSE NULL END AS decision_maker
    FROM all_deals l
    LEFT JOIN {{  ref('stg_contacts')  }} c ON l.account_id = c.account_id
),

deals_with_one_decision_maker AS (
    SELECT 
        *,
        -- create a flag to see duplicated lines (multiple contacts in contact table)
        ROW_NUMBER() OVER (PARTITION BY deal_id ORDER BY decision_maker) AS deal_duplicate_numer
    FROM deals_with_decision_makers
)


SELECT 
    deal_id,
    account_name,
    segment,
    arr,
    acv,
    stage,
    close_date,
    is_renewal,
    churn_reason,
    country,
    industry,
    decision_maker
FROM deals_with_one_decision_maker
WHERE deal_duplicate_numer = 1
ORDER BY close_date ASC 
