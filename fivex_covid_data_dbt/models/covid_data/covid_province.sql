{{ config(materialized='table') }}

with source_covid_data as (
    select * from {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}

)
select date AS date,
 PROVINCE AS COUNTRY,
 TOTAL_CASES,
 TOTAL_RECOVERED,
 TOTAL_DEATHS,
 NEW_CASES,
 NEW_RECOVERED,
 NEW_DEATHS
 from source_covid_data
 where LOCATION_LEVEL = 'Province'