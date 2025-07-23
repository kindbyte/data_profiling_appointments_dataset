-- Query: Detect Age Outliers Using IQR Method
-- Description: Calculates Q1, Q3, and IQR, then selects appointments with age outside 1.5*IQR range.
-- Goal: Identify unusual age values that might be data entry errors or special cases.
with percentiles as (
select 
percentile_cont(0.25) within group (order by age) as q1,
percentile_cont(0.75) within group (order by age) as q3
from appointments 
),
iqr as (
select q1, q3, q3-q1 as iqr
from percentiles 
)
select a.*, i.iqr
from appointments a
cross join iqr i
where a.age < i.q1 - 1.5 * i.iqr
or a.age > i.q3 + 1.5 * i.iqr;