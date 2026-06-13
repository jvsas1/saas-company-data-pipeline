-- depends_on: {{ ref('silver_customers') }}
SELECT
    acc.country,
    acc.plan_tier,
    COUNT(DISTINCT acc.account_id)                                          AS total_customers,
    SUM(CASE WHEN acc.churn_flag = TRUE THEN 1 ELSE 0 END)                 AS total_churned,
    SUM(CASE WHEN sub.is_active = TRUE THEN 1 ELSE 0 END)                  AS total_active,
    ROUND(AVG(sub.mrr_amount), 2)                                           AS avg_mrr_per_customer,
    SUM(sub.mrr_amount)                                                     AS total_mrr,
    ROUND(AVG(sub.duration_days), 0)                                        AS avg_subscription_days
FROM {{ ref('silver_customers') }} sc
LEFT JOIN {{ ref('silver_accounts') }} acc
    ON sc.account_id = acc.account_id
LEFT JOIN {{ ref('silver_subscriptions') }} sub
    ON sc.account_id = sub.account_id
GROUP BY 1, 2
ORDER BY total_mrr DESC
