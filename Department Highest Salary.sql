--The Employee table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
--The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

--Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

#################################################################################

select d.Name as Department , FT1.Name as Employee , ft1.Salary
from
((select Name , Salary , e1.DepartmentId
from Employee e1
inner join
(select DepartmentId , max(Salary) as Sal
from Employee
group by DepartmentId) as NT1
on e1.DepartmentId = NT1.DepartmentId
and e1.Salary = NT1.Sal)) as FT1
INNER JOIN
Department d on FT1.DepartmentId = d.Id