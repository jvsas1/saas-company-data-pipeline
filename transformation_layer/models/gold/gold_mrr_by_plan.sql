-- depends_on: {{ ref('silver_subscriptions') }}
SELECT
    plan_tier,
    billing_frequency,
    COUNT(subscription_id)          AS total_subscriptions,
    SUM(mrr_amount)                 AS total_mrr,
    AVG(mrr_amount)                 AS avg_mrr_per_customer,
    SUM(arr_amount)                 AS total_arr,
    SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) AS active_subscriptions
FROM {{ ref('silver_subscriptions') }}
GROUP BY 1, 2
ORDER BY total_mrr DESC
