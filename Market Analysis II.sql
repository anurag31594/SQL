--Write an SQL query to find for each user, whether the brand of the second item (by date) they sold is their favorite brand. If a user sold less than two items, report the answer for that user as no.

--It is guaranteed that no seller sold more than one item on a day.

--The query result format is in the following example:

Users table:
+---------+------------+----------------+
| user_id | join_date  | favorite_brand |
+---------+------------+----------------+
| 1       | 2019-01-01 | Lenovo         |
| 2       | 2019-02-09 | Samsung        |
| 3       | 2019-01-19 | LG             |
| 4       | 2019-05-21 | HP             |
+---------+------------+----------------+

Orders table:
+----------+------------+---------+----------+-----------+
| order_id | order_date | item_id | buyer_id | seller_id |
+----------+------------+---------+----------+-----------+
| 1        | 2019-08-01 | 4       | 1        | 2         |
| 2        | 2019-08-02 | 2       | 1        | 3         |
| 3        | 2019-08-03 | 3       | 2        | 3         |
| 4        | 2019-08-04 | 1       | 4        | 2         |
| 5        | 2019-08-04 | 1       | 3        | 4         |
| 6        | 2019-08-05 | 2       | 2        | 4         |
+----------+------------+---------+----------+-----------+

Items table:
+---------+------------+
| item_id | item_brand |
+---------+------------+
| 1       | Samsung    |
| 2       | Lenovo     |
| 3       | LG         |
| 4       | HP         |
+---------+------------+

################################################################################

select user_id as seller_id , 
CASE WHEN u.favorite_brand = item_brand then 'yes'
    else 'no' END as '2nd_item_fav_brand'
from
(select seller_id , i.item_id , item_brand
from
(select NT1.seller_id , o.item_id , NT1.order_date
from
(select seller_id , order_date ,
RANK() over (partition by seller_id order by order_date) as Row_Num
from Orders
group by seller_id , order_date) as NT1
inner join
Orders o on NT1.seller_id = o.seller_id
and NT1.order_date = o.order_date
where Row_Num = 2) as NT2
right join
Items i on NT2.item_id = i.item_id) as ZT1
right join
Users u on ZT1.seller_id = u.user_id

