-- Write your MySQL query statement below
select name from customer where referee_id is null or referee_id!=2;

select tweet_id from Tweets where LENGTH(content) >=15;

-- Left Join
Select EmployeeUNI.unique_id , Employees.name from Employees LEFT JOIN EmployeeUNI on Employees.id = EmployeeUNI.id;

select unique_id, name from employees e
left join employeeuni u on e.id = u.id

--
Select Product.product_name,Sales.year,Sales.price from Sales
left join Product on Sales.product_id = Product.product_id order by Product.product_name ;


Select customer_id, COUNT(customer_id) AS count_no_trans from Visits LEFT JOIN Transactions ON Visits.visit_id = Transactions.visit_id where transaction_id is null group by customer_id ;


SELECT w1.id FROM Weather w1 JOIN Weather w2 on DATEDIFF(w1.recordDate,w2.recordDate)=1 WHERE w1.temperature > w2.temperature;


-- Calling the original Table twice and Calculate as two columns
SELECT a.machine_id,
        ROUND(AVG((b.timestamp - a.timestamp)),3) AS processing_time
FROM Activity a, 
     Activity b
WHERE 
    a.machine_id = b.machine_id
AND 
    a.process_id = b.process_id
AND 
    a.activity_type = 'start'
AND 
    b.activity_type = 'end'
GROUP BY machine_id



--
SELECT student.student_id,student.student_name,subject.subject_name,COUNT(exam.subject_name) as attended_exams
FROM Students as student
JOIN Subjects as subject
LEFT JOIN Examinations as exam
ON student.student_id=exam.student_id AND subject.subject_name=exam.subject_name
GROUP BY student.student_id,subject.subject_name
ORDER BY student_id,subject_name;

SELECT Students.student_id,Students.student_name,Subjects.subject_name,COUNT(Examinations.subject_name) as attended_exams
FROM Students 
JOIN Subjects 
LEFT JOIN Examinations
ON Students.student_id=Examinations.student_id AND Subjects.subject_name=Examinations.subject_name
GROUP BY Students.student_id,Subjects.subject_name
ORDER BY student_id,subject_name;


SELECT
  student.first_name,
  student.last_name,
  course.name
FROM student
JOIN student_course
  ON student.id = student_course.student_id
JOIN course
  ON course.id = student_course.course_id;



-- Mysql Sub Query 
SELECT 
    lastName, firstName
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');

--
SELECT customerNumber,
         checkNumber,
         amount
FROM payments
WHERE amount =
    (SELECT MAX(amount)
    FROM payments);


-- 570. Managers with at Least 5 Direct Reports
SELECT managerId ,COUNT(*) as count_rows from Employee GROUP BY managerId HAVING count_rows >=5;
-- Used a subquery to execute 
-- 1 st subquery get manager id and count the Joined both subquery and table
SELECT name from Employee e
JOIN(
    SELECT managerId ,COUNT(*) as count_rows from Employee GROUP BY managerId HAVING count_rows >=5
) AS subquery ON e.id = subquery.managerId;

-- 1934. Confirmation Rate
'+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |
+---------+---------------------+-----------+'

SELECT a.user_id, round(ifnull(avg(action = 'confirmed'), 0),2) as confirmation_rate
FROM Signups a
LEFT JOIN Confirmations b
ON a.user_id = b.user_id
GROUP BY a.user_id

SELECT a.user_id,ROUND(IFNULL(SUM(action = 'confirmed'),0)/COUNT(*),2) as confirmation_rate
FROM Signups a
LEFT JOIN Confirmations b
ON a.user_id = b.user_id
GROUP BY a.user_id

--

-- Basic Aggregate Functions
--

"
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
"
# Write your MySQL query statement below
SELECT Prices.product_id, IFNULL(ROUND(SUM(Prices.price*UnitsSold.units)/SUM(UnitsSold.units),2),0) as average_price from Prices
LEFT JOIN UnitsSold ON (Prices.product_id = UnitsSold.product_id AND (UnitsSold.purchase_date >= Prices.start_date AND UnitsSold.purchase_date <= Prices.end_date)) Group by product_id
## Best solution

select p.product_id, ifnull(round(sum(price*units)/sum(units),2),0) as average_price
from Prices p left join UnitsSold u
on p.product_id = u.product_id
and u.purchase_date between start_date and end_date
group by product_id;


--

"
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
"
Select p.project_id,ROUND(AVG(e.experience_years),2) As average_years from Project p Left join Employee e on p.employee_id=e.employee_id group by project_id


-- 1633. Percentage of Users Attended a Contest
SELECT 
contest_id,
ROUND((count(Register.user_id)/(
    SELECT COUNT(user_id) from Users
))*100,2) AS percentage  
from Register 
JOIN Users ON Users.user_id = Register.user_id GROUP BY contest_id ORDER BY percentage desc,contest_id

# Better Solution without JOIN 
select 
contest_id, 
round(count(distinct user_id) * 100 /(select count(user_id) from Users) ,2) as percentage
from  Register
group by contest_id
order by percentage desc,contest_id



--

Select query_name,ROUND(SUM(rating/position)/(count(query_name)),2) AS quality,
ROUND((SUM(rating<3)/(select count(query_name)))*100,2) as poor_query_percentage
from Queries WHERE query_name IS NOT NULL group by query_name

select query_name,round(avg((rating/position)),2) as quality, round(avg(case when rating < 3 then 1 else 0 end)*100,2) as poor_query_percentage  from Queries
where query_name is not null 
group by query_name


--
--1193. Monthly Transactions I

"
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+"

SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month ,
country ,
COUNT(*) AS trans_count,
SUM(IF(state = 'approved', 1, 0)) AS approved_count,
SUM(amount) as trans_total_amount,
SUM(IF(state = 'approved', amount, 0)) as approved_total_amount FROM Transactions
GROUP BY month, country

--1174. Immediate Food Delivery II
"
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output: 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+

delivery_id is the column of unique values of this table
"


SELECT CASE WHEN  `order_date` = `customer_pref_delivery_date` THEN "immediate"
    ELSE "scheduled" END as status from Delivery
"
| status    |
| --------- |
| scheduled |
| immediate |
| scheduled |
| immediate |
| scheduled |
| scheduled |
| immediate |

"

Select 
    round(avg(order_date = customer_pref_delivery_date)*100, 2) as immediate_percentage
from Delivery
where (customer_id, order_date) in (
  Select customer_id, min(order_date) 
  from Delivery
  group by customer_id
);

-- 550. Game Play Analysis IV
