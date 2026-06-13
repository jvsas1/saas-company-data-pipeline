-- depends_on: {{ ref('support_tickets') }}
SELECT
    ticket_id,
    account_id,
    CAST(submitted_at AS TIMESTAMP)                         AS submitted_at,
    CAST(closed_at AS TIMESTAMP)                            AS closed_at,
    CAST(resolution_time_hours AS NUMERIC)                  AS resolution_time_hours,
    priority,
    CASE
        WHEN priority = 'urgent' THEN 1
        WHEN priority = 'high'   THEN 2
        WHEN priority = 'medium' THEN 3
        WHEN priority = 'low'    THEN 4
    END                                                     AS priority_level,
    CAST(first_response_time_minutes AS NUMERIC)            AS first_response_time_minutes,
    COALESCE(CAST(satisfaction_score AS NUMERIC), 0)        AS satisfaction_score,
    CAST(escalation_flag AS BOOL)                           AS escalation_flag
FROM {{ ref('support_tickets') }}
WHERE ticket_id IS NOT NULL
