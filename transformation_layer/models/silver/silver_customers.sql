-- depends_on: {{ ref('silver_accounts') }}
SELECT 
acc.account_id,
acc.account_name, 
acc.industry,
acc.country,
acc.plan_tier,
acc.signup_date,
acc.churn_flag,
sub.subscription_id,
sub.start_date,
sub.end_date,
sub.is_active,
sub.duration_days,
sub.mrr_amount,
sub.arr_amount,
sub.billing_frequency

FROM {{ ref('silver_accounts')  }} acc
LEFT JOIN {{ ref('silver_subscriptions') }} sub ON sub.account_id=acc.account_id
