{{ config(
    materialized='table',
    full_refresh=true
) }}

select
    deal_code,
    transaction_date,
    currency,
    SUM(amount) as total_transaction_amount,
    COUNT(transaction_id) as transaction_count,
    '{{ get_job_run_id() }}' as job_run_id,
    '{{ var('job_flow_name') }}' as job_flow_name
from {{ ref('fin_transactions_denorm') }}
where data_expiration_date is null
group by deal_code, transaction_date, currency
