{% set deal_code = "HUMMINGBIRD" %}

select 
    md5(concat(`date`, amount, yearmo)) as transaction_id,
    `date` as transaction_date,
    case when amount >= 0 then 'C' else 'D' end as transaction_type,
    cast(abs(amount) as decimal(12,2)) as amount,
    '{{ deal_code }}' AS deal_code,
    '{{ ref('hummingbird_transactions_raw').schema }}' as source_schema,
    '{{ ref('hummingbird_transactions_raw').database }}' as source_database,
    '{{ ref('hummingbird_transactions_raw').identifier }}' as source_table,
    date(concat(left(yearmo, 4), '-', right(yearmo, 2), '-01')) as data_date
from {{ ref('hummingbird_transactions_raw') }}
where yearmo = '{{ var('yearmo') }}'
