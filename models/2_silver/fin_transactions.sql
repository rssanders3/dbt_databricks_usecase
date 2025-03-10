{{ config(
    materialized='incremental',
    post_hook='{{ soft_delete() }}'
) }}

  -- depends_on: {{ ref('falcon_transactions_conformed') }}
  -- depends_on: {{ ref('ghost_transactions_conformed') }}
  -- depends_on: {{ ref('hummingbird_transactions_conformed') }}

select 
    transaction_id,
    transaction_date,
    transaction_type,
    amount,
    deal_code,
    source_schema,
    source_database,
    source_table,
    '{{ get_job_run_id() }}' as job_run_id,
    '{{ var('job_flow_name') }}' as job_flow_name,
    cast(null as date) as data_expiration_date, 
    data_date

{% if var("job_flow_name") == 'falcon_transactions_jobflow' %}
from {{ ref('falcon_transactions_conformed') }}

{% elif var("job_flow_name") == 'ghost_transactions_jobflow' %}
from {{ ref('ghost_transactions_conformed') }}

{% elif var("job_flow_name") == 'hummingbird_transactions_jobflow' %}
from {{ ref('hummingbird_transactions_conformed') }}

{% else %}
from (select null)
where 1=0

{% endif %}
