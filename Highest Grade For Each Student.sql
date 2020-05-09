--Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id. The output must be sorted by increasing student_id.

--The query result format is in the following example:

Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+

###############################################################################

select FT1.student_id , min(e1.course_id) as course_id, FT1.grade
from
(select student_id , max(grade) as grade
from Enrollments
group by student_id) as FT1
inner join
Enrollments e1 on FT1.student_id = e1.student_id
and FT1.grade = e1.grade
group by FT1.student_id
order by FT1.student_id;
