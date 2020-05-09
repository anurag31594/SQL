--Write a SQL query to find all numbers that appear at least three times consecutively.

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+

#################################################################

select distinct(L1.Num) as ConsecutiveNums 
from Logs L1 , Logs L2 , Logs L3
where L2.Id = L1.Id + 1
and L3.Id = L2.Id + 1
and L1.Num = L2.Num
and L2.Num = L3.Num;