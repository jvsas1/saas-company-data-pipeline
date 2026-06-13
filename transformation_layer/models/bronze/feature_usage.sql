SELECT * FROM {{ source('staging_layer_db', 'ravenstack_feature_usage') }}

