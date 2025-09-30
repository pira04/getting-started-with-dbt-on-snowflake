
{% macro ensure_schema_exists() %}
  {% set sql %}
    create schema if not exists {{ target.database }}.ICEBERG_MARTS;
    create schema if not exists {{ target.database }}.ICEBERG_RAW;
  {% endset %}
  {% do run_query(sql) %}
{% endmacro %}

-- Call this macro from the command line if desired:
-- dbt run-operation ensure_schema_exists
