create schema work;
use work;
select * from absenteeism_at_work;
select * from reasons;
select * from compensation;
-- create a join table --
select * from absenteeism_at_work a
left join compensation b
on a.id = b.id
left join reasons r on
a.Reason_for_absence = r.number;

-- find the healthiest --
select * from absenteeism_at_work
where social_drinker =0 and social_smoker = 0
and Body_mass_index < 25 and 
Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours) from absenteeism_at_work)

-- compension rate increase for non- smoker --
select count(*) as non_smoker from absenteeism_at_work
where social_smoker = 0

-- optimize the query --
select a.id,
r.Reason,
Month_of_absence,
Body_mass_index,
case when Body_mass_index  <18.5 then 'under_weight'
	 when Body_mass_index  between 18.5 and 25 then 'healty_weight'
     when Body_mass_index  between 25  and 30 then 'over_weight'
     when Body_mass_index  > 18.5 then 'obese'
     else 'Unknown' end as BMI_category,
case when Month_of_absence in (12,1,2) then 'winter'
	 when Month_of_absence in (3,4,5) then 'spring'
     when Month_of_absence in (6,7,8) then 'summer'
     when Month_of_absence in (9,10,11) then 'fall'
     else 'Unknown' end as season_names,
seasons,
Month_of_absence,
Transportation_expense,
Day_of_the_week,
Age,
Son,
Education,
Social_drinker,
Social_smoker,
pet,
Disciplinary_failure,
Absenteeism_time_in_hours
from absenteeism_at_work a
left join compensation b
on a.id = b.id
left join reasons r on
a.Reason_for_absence = r.number;
