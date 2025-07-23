-- Query: Missing vs Present Values in Gender
-- Description: Counts how many records have missing or present gender values.
-- Goal: Assess data completeness for the gender field.
select 'missing' as status, count(*) as count
from appointments
where gender is null
union all
select 'present' as status, count(*) as count
from appointments
where gender is not null;