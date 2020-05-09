Write a SQL query to get the second highest salary from the Employee table.

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+


############################################################

select max(salary) as SecondHighestSalary
from Employee
where Salary NOT IN (select max(salary) from Employee)
