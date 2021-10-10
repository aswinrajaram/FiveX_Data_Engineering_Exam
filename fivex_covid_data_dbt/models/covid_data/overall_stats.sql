{{ config(materialized='table') }}


with source_covid_data as (
    select 
    COUNTRY,
    SUM(TOTAL_RECOVERED) AS TOTAL_RECOVERED,
    sum(TOTAL_DEATHS) AS TOTAL_DEATHS,
    SUM(TOTAL_CASES) AS TOTAL_CASES,
    SUM(POPULATION) AS POPULATION
    from {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}
    WHERE LOCATION_LEVEL = 'Country'
    GROUP BY COUNTRY
)
SELECT COUNTRY, 
(TOTAL_RECOVERED/TOTAL_CASES) AS TOTAL_RECOVERY_RATE,
(TOTAL_DEATHS/TOTAL_CASES) AS TOTAL_DEATH_RATE,
(TOTAL_DEATHS * 1000000)/(POPULATION) AS TOTAL_DEATHS_PER_MILLION,
((TOTAL_CASES) - (TOTAL_RECOVERED+TOTAL_DEATHS)) AS TOTAL_ACTIVE_CASES
FROM source_covid_data
