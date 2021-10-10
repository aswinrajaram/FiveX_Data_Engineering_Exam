{{ config(materialized='table') }}

with source_covid_data as (
    select * from {{ source("covid_data", "COVID_19_INDONESIA_ASWIN_RAJARAM") }}

)
select DISTINCT
COUNTRY,
TIME_ZONE,
POPULATION,
POPULATION_DENSITY,
TOTAL_DISTRICTS,
TOTAL_REGENCIES,
TOTAL_CITIES,
TOTAL_RURAL_VILLAGES,
TOTAL_URBAN_VILLAGES,
AREA_KM_2_ AS AREA_IN_SQ_KM,
CONTINENT
 from source_covid_data
 where LOCATION_LEVEL = 'Country'