{{ config(materialized='table') }}


with source_covid_data as (
    select 
    PROVINCE,
    sum(TOTAL_CASES) AS TOTAL_CASES,
    SUM(TOTAL_RECOVERED) AS TOTAL_RECOVERED
    from {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}
    WHERE LOCATION_LEVEL = 'Province'
    GROUP BY PROVINCE
)
SELECT PROVINCE, (TOTAL_RECOVERED/TOTAL_CASES) AS TOTAL_RECOVERY_RATE
FROM source_covid_data
ORDER BY TOTAL_RECOVERY_RATE DESC
LIMIT 3
