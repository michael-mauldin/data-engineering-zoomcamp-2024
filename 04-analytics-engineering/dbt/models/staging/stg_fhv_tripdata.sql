with 

source as (

    select * from {{ source('staging', 'ny_fhv_taxi_2019_partitioned') }}

),

renamed as (

    select
        dispatching_base_num,
        pickup_datetime,
        dropoff_datetime,
        pulocationid as pickup_locationid,
        dolocationid as dropoff_locationid,
        sr_flag,
        affiliated_base_number

    from source
    where pickup_datetime between '2019-01-01' and '2019-12-31'

)

select * from renamed


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}