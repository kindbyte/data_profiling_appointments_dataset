-- Query: Frequency of Gender
-- Description: Counts the number of appointments grouped by patient gender.
-- Goal: Understand gender distribution in the dataset.
select gender, count(*) as frequency
from appointments
group by gender
order by frequency;