{% set deal_code = "FALCON" %}

select 
    md5(concat(`year`, `month`, data_dt)) as transaction_id,
    date(concat(`year`, '-', `month`, '-01')) as transaction_date,
    case when agg_amount >= 0 then 'C' else 'D' end as transaction_type,
    abs(agg_amount) as amount,
    '{{ deal_code }}' AS deal_code,
    '{{ ref('falcon_summary_raw').schema }}' as source_schema,
    '{{ ref('falcon_summary_raw').database }}' as source_database,
    '{{ ref('falcon_summary_raw').identifier }}' as source_table,
    data_dt as data_date
from {{ ref('falcon_summary_raw') }}
where data_dt = '{{ var('data_dt') }}'
