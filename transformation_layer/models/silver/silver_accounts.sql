-- depends_on: {{ ref('accounts') }}
SELECT
    account_id,
    account_name,
    country,
    industry,
    seats,
    referral_source,
    plan_tier,
    CAST(signup_date AS DATE) AS signup_date,
    CAST(is_trial AS BOOLEAN) AS is_trial,
    CAST(churn_flag AS BOOLEAN) AS churn_flag
FROM {{ ref('accounts') }}
WHERE account_id IS NOT NULL
