
{{ config(materialized='table') }}

with source_covid_data as (
    SELECT PROVINCE, 
    SUM(NEW_DEATHS) AS TOTAL_DEATHS
    FROM  {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}
    WHERE LOCATION_LEVEL = 'Province'
    GROUP BY PROVINCE
    ORDER BY TOTAL_DEATHS DESC
    LIMIT 3

)

SELECT *
FROM source_covid_data
