-- depends_on: {{ ref('silver_churn_events') }}
SELECT
    DATE_TRUNC(churn_date, MONTH) AS churn_month,
    reason_code,
    COUNT(churn_event_id)           AS total_churns,
    AVG(refund_amount_usd)          AS avg_refund_usd,
    SUM(refund_amount_usd)          AS total_refund_usd,
    SUM(CASE WHEN is_reactivation = TRUE THEN 1 ELSE 0 END) AS total_reactivations
FROM {{ ref('silver_churn_events') }}
GROUP BY 1, 2
ORDER BY 1 DESC
