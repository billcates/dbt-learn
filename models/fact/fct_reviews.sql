{{
    config(
        materialized='incremental',
        on_schema_change='fail'
    )
}}
with  fct_reviews as(
    select * from {{ref('src_reviews')}}
)
select * from fct_reviews
where review_text is not NULL
{% if is_incremental() %}
  and review_date > (select max(review_date) from {{this}})
{% endif %}