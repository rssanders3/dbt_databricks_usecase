{{ config(
    materialized='incremental',
    post_hook='{{ soft_delete() }}'
) }}

select 
    cast(ft.transaction_id as char(256)) as transaction_id,
    ft.transaction_date as transaction_date,
    ft.transaction_type,
    ft.amount,
    gd.currency,
    cast(ft.deal_code as char(56)) as deal_code,
    gd.product,
    cast(ft.source_schema as char(256)) as source_schema,
    cast(ft.source_database as char(256)) as source_database,
    cast(ft.source_table as char(256)) as source_table,
    '{{ get_job_run_id() }}' as job_run_id,
    '{{ var('job_flow_name') }}' as job_flow_name,
    cast(null as date) as data_expiration_date,
    ft.data_date
from {{ ref('fin_transactions') }} ft
join {{ ref('gen_deal') }} gd using (deal_code)
where job_run_id = '{{ get_job_run_id() }}'
