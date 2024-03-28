{{
    config(
        materialized='view'
    )
}}

with earthquake_data as 
(
  select * 
  from {{ source('staging','earthquake') }}
  where mag >= 3
)

select
    -- identifiers

    -- timestamps
    event_date,
    
    -- earthquake info
    mag as magnitude,
    {{ get_significance("mag") }} as significance,

    -- geo
    longitude,
    latitude,
    `carto-os.carto.H3_FROMGEOGPOINT`(ST_GEOGPOINT(longitude, latitude), 4) as h3_index

from earthquake_data


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}