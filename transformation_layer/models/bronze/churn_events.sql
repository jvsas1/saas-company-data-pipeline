SELECT * FROM {{ source('staging_layer_db', 'ravenstack_churn_events') }}
