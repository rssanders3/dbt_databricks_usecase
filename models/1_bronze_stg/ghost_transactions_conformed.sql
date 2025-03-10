{% set deal_code = "GHOST" %}

select 
    transaction_id,
    transaction_date,
    transaction_type,
    amount,
    '{{ deal_code }}' AS deal_code,
    '{{ ref('ghost_transactions_raw').schema }}' as source_schema,
    '{{ ref('ghost_transactions_raw').database }}' as source_database,
    '{{ ref('ghost_transactions_raw').identifier }}' as source_table,
    data_date
from {{ ref('ghost_transactions_raw') }}
where data_date = '{{ var('data_date') }}'
