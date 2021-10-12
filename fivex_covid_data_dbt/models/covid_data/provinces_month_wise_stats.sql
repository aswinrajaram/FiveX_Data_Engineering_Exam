{{ config(materialized='table') }}

with source_covid_data as (
    select 
    TO_DATE(CONCAT(TO_CHAR(MONTH(TO_DATE(DATE))),'/', '1','/',TO_CHAR(YEAR(TO_DATE(DATE))))) AS MONTH,
    SUM(NEW_CASES) AS TOTAL_CASES,
    SUM(NEW_RECOVERED) AS TOTAL_RECOVERED, 
    SUM(NEW_DEATHS) AS TOTAL_DEATHS
    from {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}
    WHERE LOCATION_LEVEL = 'Province'
    GROUP BY MONTH(TO_DATE(DATE)),YEAR(TO_DATE(DATE))
    ORDER BY MONTH

)

 SELECT *
 FROM source_covid_data