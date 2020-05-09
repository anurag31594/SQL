--Team Scores in Football Tournament

--Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches. Result table should be ordered by num_points (decreasing order). In case of a tie, order the records by team_id (increasing order).

--The query result format is in the following example:

Teams table:
+-----------+--------------+
| team_id   | team_name    |
+-----------+--------------+
| 10        | Leetcode FC  |
| 20        | NewYork FC   |
| 30        | Atlanta FC   |
| 40        | Chicago FC   |
| 50        | Toronto FC   |
+-----------+--------------+

Matches table:
+------------+--------------+---------------+-------------+--------------+
| match_id   | host_team    | guest_team    | host_goals  | guest_goals  |
+------------+--------------+---------------+-------------+--------------+
| 1          | 10           | 20            | 3           | 0            |
| 2          | 30           | 10            | 2           | 2            |
| 3          | 10           | 50            | 5           | 1            |
| 4          | 20           | 30            | 1           | 0            |
| 5          | 50           | 30            | 1           | 0            |
+------------+--------------+---------------+-------------+--------------+

##################################################################################

select t1.team_id , t1.team_name , num as 'num_points'
from
(select team_id , team_name ,
SUM(CASE WHEN (team_id = m.host_team) and (m.host_goals > m.guest_goals)
   or (team_id = m.guest_team) and (m.guest_goals > m.host_goals) THEN 3
   WHEN (m.host_goals = m.guest_goals) THEN 1
   ELSE 0 END) as num
   from Matches m
   
   right join
   
   Teams t on t.team_id = m.host_team
   or t.team_id = m.guest_team
   group by team_id
   order by num desc , team_id) as NT1
   
   left join
   
   Teams t1 on t1.team_id = NT1.team_id
   order by num desc , t1.team_id