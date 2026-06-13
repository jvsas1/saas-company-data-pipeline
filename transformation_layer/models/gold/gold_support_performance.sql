-- depends_on: {{ ref('silver_support_tickets') }}
SELECT
    priority,
    priority_level,
    COUNT(ticket_id)                        AS total_tickets,
    AVG(resolution_time_hours)              AS avg_resolution_hours,
    AVG(first_response_time_minutes)        AS avg_first_response_minutes,
    AVG(CASE WHEN satisfaction_score > 0 THEN satisfaction_score END) AS avg_satisfaction_score,
    SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) AS total_escalations
FROM {{ ref('silver_support_tickets') }}
GROUP BY 1, 2
ORDER BY priority_level ASC
