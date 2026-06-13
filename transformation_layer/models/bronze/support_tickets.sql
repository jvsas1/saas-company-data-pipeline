SELECT * FROM {{ source('staging_layer_db', 'ravenstack_support_tickets') }}
