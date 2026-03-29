SELECT
    contact_id,
    account_id,
    contact_name,
    role,
    CAST(is_decision_maker AS BOOLEAN) as is_decision_maker
FROM {{  ref('contacts')  }}