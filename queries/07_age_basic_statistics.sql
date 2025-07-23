-- Query: Basic Age Statistics
-- Description: Calculates minimum, maximum, average, and median age of patients.
-- Goal: Summarize patient age distribution.
select min(age) as min_age, max(age) as max_age, avg(age) as avg_age,
percentile_cont(0.5) within group (order by age) as median_age
from appointments;