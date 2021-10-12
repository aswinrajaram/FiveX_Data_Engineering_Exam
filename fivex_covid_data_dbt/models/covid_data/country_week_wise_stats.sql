{{ config(materialized='table') }}

with source_covid_data as (
    SELECT
    WEEK(TO_DATE(DATE)) AS WEEK_NUM,
    YEAR(TO_DATE(DATE)) AS YEAR,
    SUM(NEW_CASES) AS TOTAL_CASES,
    SUM(NEW_RECOVERED) AS TOTAL_RECOVERED, 
    SUM(NEW_DEATHS) AS TOTAL_DEATHS
    from {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}
    WHERE LOCATION_LEVEL = 'Country'
    GROUP BY WEEK_NUM,YEAR
    ORDER BY YEAR ASC, WEEK_NUM ASC

)

 SELECT *
 FROM source_covid_data