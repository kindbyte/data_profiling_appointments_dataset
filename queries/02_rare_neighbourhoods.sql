-- Query: Rare Neighbourhoods (frequency < 100)
-- Description: Finds neighbourhoods with fewer than 100 appointments.
-- Goal: Identify rare categories for possible special handling or data issues.
select neighbourhood, count(*) as frequency
from appointments 
group by neighbourhood
having count(*) < 100
order by frequency
;