{% macro soft_delete() %}
    update {{ this }}
    set data_expiration_date = current_date
    where job_flow_name = '{{ var('job_flow_name') }}' and job_run_id != '{{ get_job_run_id() }}' and data_expiration_date is null
{% endmacro %}