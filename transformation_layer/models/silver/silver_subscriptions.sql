-- depends_on: {{ ref('subscriptions') }}
SELECT
    subscription_id,
    account_id,
    CAST(start_date AS DATE)                                                        AS start_date,
    CAST(end_date AS DATE)                                                          AS end_date,
    plan_tier,
    CASE
        WHEN end_date IS NULL THEN TRUE
        WHEN CAST(end_date AS DATE) > CURRENT_DATE THEN TRUE
        ELSE FALSE
    END                                                                             AS is_active,
    (COALESCE(CAST(end_date AS DATE), CURRENT_DATE) - CAST(start_date AS DATE))    AS duration_days,
    seats,
    mrr_amount,
    arr_amount,
    CAST(is_trial AS BOOL)                                                          AS is_trial,
    CAST(upgrade_flag AS BOOL)                                                      AS upgrade_flag,
    CAST(downgrade_flag AS BOOL)                                                    AS downgrade_flag,
    CAST(churn_flag AS BOOL)                                                        AS churn_flag,
    billing_frequency,
    CAST(auto_renew_flag AS BOOL)                                                   AS auto_renew_flag
FROM {{ ref('subscriptions') }}
WHERE subscription_id IS NOT NULL
