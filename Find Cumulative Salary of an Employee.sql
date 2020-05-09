--Find Cumulative Salary of an Employee

--The Employee table holds the salary information in a year.

--Write a SQL to get the cumulative sum of an employee's salary over a period of 3 months but exclude the most recent month. The result should be displayed by 'Id' ascending, and then by 'Month' descending.

--Example

Input

| Id | Month | Salary |
|----|-------|--------|
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 1  | 2     | 30     |
| 2  | 2     | 30     |
| 3  | 2     | 40     |
| 1  | 3     | 40     |
| 3  | 3     | 60     |
| 1  | 4     | 60     |
| 3  | 4     | 70     |

###############################################################################

select e1.id , e1.Month , sum(e2.Salary) as Salary
from Employee e1
inner join 
Employee e2 on e1.id = e2.id
and e2.month <= e1.month
where e1.month <> (Select max(month) from Employee where id = e1.Id)
group by e1.id , e1.month
order by e1.id , e1.month desc
