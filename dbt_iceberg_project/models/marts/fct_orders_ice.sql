
{{
  config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='order_id',
    catalog_name='catalog_snowflake_managed'  -- <-- uses catalogs.yml integration
    # If you're on older adapters, use legacy:
    # table_format='iceberg'
  )
}}

with orders as (
  select * from {{ source('lake','orders_ice') }}
),
customers as (
  select * from {{ source('lake','customers_ice') }}
)

select
  o.order_id,
  o.order_ts,
  c.customer_id,
  c.segment,
  o.amount
from orders o
join customers c using (customer_id)
{% if is_incremental() %}
  where o.order_ts > (select coalesce(max(order_ts), '1900-01-01') from {{ this }})
{% endif %}
