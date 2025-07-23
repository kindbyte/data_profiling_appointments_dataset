-- Query: Count of Unique Values in Key Columns
-- Description: Counts distinct values in gender, neighbourhood, age, and appointment date.
-- Goal: Understand the diversity and cardinality of key data fields.
select count(distinct gender) as gender_count, count(distinct neighbourhood) as neighbourhood_count, count(distinct age) as age_count, count(distinct appointmentday::date) as app_date_count 
from appointments
;