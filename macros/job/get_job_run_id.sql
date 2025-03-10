{% macro get_job_run_id() %}
    {{ return(env_var('job_run_id', invocation_id)) }}
{% endmacro %}