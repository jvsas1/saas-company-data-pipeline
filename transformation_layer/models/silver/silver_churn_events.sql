-- depends_on: {{ ref('churn_events') }}
SELECT
 churn_event_id,
 account_id,
 CAST(churn_date AS DATE) AS churn_date,
 LOWER(reason_code) AS reason_code,
 CAST(refund_amount_usd AS NUMERIC) AS refund_amount_usd,
 CAST(preceding_upgrade_flag AS BOOLEAN) AS precending_upgrade_flag,
 CAST(preceding_downgrade_flag AS BOOLEAN) AS preceding_downgrad_flag,
 CAST(is_reactivation AS BOOLEAN) AS is_reactivation,
 COALESCE(feedback_text,'No Feedback') AS feedback
FROM {{ ref('churn_events') }}
WHERE churn_event_id IS NOT NULL
