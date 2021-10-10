{{ config(materialized='table') }}


with source_covid_data as (
    select 
    PROVINCE,
    sum(TOTAL_DEATHS) AS TOTAL_DEATHS,
    SUM(TOTAL_CASES) AS TOTAL_CASES
    from {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}
    WHERE LOCATION_LEVEL = 'Province'
    GROUP BY PROVINCE
)
SELECT PROVINCE, (TOTAL_DEATHS/TOTAL_CASES) AS TOTAL_DEATH_RATE
FROM source_covid_data
ORDER BY TOTAL_DEATH_RATE DESC
LIMIT 3
