--The Trips table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are both foreign keys to the Users_Id at the Users table. Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).

+----+-----------+-----------+---------+--------------------+----------+
| Id | Client_Id | Driver_Id | City_Id |        Status      |Request_at|
+----+-----------+-----------+---------+--------------------+----------+
| 1  |     1     |    10     |    1    |     completed      |2013-10-01|
| 2  |     2     |    11     |    1    | cancelled_by_driver|2013-10-01|
| 3  |     3     |    12     |    6    |     completed      |2013-10-01|
| 4  |     4     |    13     |    6    | cancelled_by_client|2013-10-01|
| 5  |     1     |    10     |    1    |     completed      |2013-10-02|
| 6  |     2     |    11     |    6    |     completed      |2013-10-02|
| 7  |     3     |    12     |    6    |     completed      |2013-10-02|
| 8  |     2     |    12     |    12   |     completed      |2013-10-03|
| 9  |     3     |    10     |    12   |     completed      |2013-10-03| 
| 10 |     4     |    13     |    12   | cancelled_by_driver|2013-10-03|
+----+-----------+-----------+---------+--------------------+----------+
--The Users table holds all users. Each user has an unique Users_Id, and Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).

+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|    1     |   No   | client |
|    2     |   Yes  | client |
|    3     |   No   | client |
|    4     |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+
--Write a SQL query to find the cancellation rate of requests made by unbanned users (both client and driver must be unbanned) between Oct 1, 2013 and Oct 3, 2013. The cancellation rate is computed by dividing the number of canceled (by client or driver) requests made by unbanned users by the total number of requests made by unbanned users.

########################################################################################
select Request_at as "Day" , coalesce(CancellationRate , 0) as "Cancellation Rate"
from
(select Request_at , ROUND((cancelledtotal/total),2) as CancellationRate
from
(select ZT1.Request_at , ZT1.total , ZT2.cancelledtotal
from
(select Request_at , count(*) as total
from
(select T1.Id , T1.Client_Id , T2.Driver_Id , Status , Request_at
from
(select id , Client_Id , Status , Request_at
from Trips
where Client_Id IN (select users_id  from Users where Banned = 'No')) as T1
inner join
(select id , Driver_Id
from Trips 
where Client_Id IN (select users_id  from Users where Banned = 'No')) as T2
on T1.Id = T2.id
where Request_at BETWEEN '2013-10-01' AND '2013-10-03') F1
group by Request_at)  as ZT1

left join

(select Request_at , count(*) as cancelledtotal
from
(select T1.Id , T1.Client_Id , T2.Driver_Id , Status , Request_at
from
(select id , Client_Id , Status , Request_at
from Trips
where Client_Id IN (select users_id  from Users where Banned = 'No')) as T1
inner join
(select id , Driver_Id
from Trips 
where Client_Id IN (select users_id  from Users where Banned = 'No')) as T2
on T1.Id = T2.id
where Request_at BETWEEN '2013-10-01' AND '2013-10-03'
and Status = 'cancelled_by_driver' or status = 'cancelled_by_client') F1
group by Request_at)  as ZT2
on ZT1.request_at = ZT2.request_at) as YT1
group by Request_at) as MT1