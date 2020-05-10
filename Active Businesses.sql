--Write an SQL query to find all active businesses.

--An active business is a business that has more than one event type with occurences greater than the average occurences of that event type among all businesses.

--The query result format is in the following example:

--Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          |
| 3           | reviews    | 3          |
| 1           | ads        | 11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         |
+-------------+------------+------------+

########################################################################

select business_id from
(select business_id , e.event_type , occurences , aver
from Events e
inner join
(select event_type , avg(occurences) as aver
from Events
group by event_type) as FT1
on FT1.event_type = e.event_type
where occurences > aver
group by business_id
having count(*) > 1) as ZT1