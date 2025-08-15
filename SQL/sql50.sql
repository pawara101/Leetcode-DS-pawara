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


--
SELECT orders.order_id, customers.customer_name, products.product_name
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id;



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
-- Write your MySQL query statement below
SELECT Prices.product_id, IFNULL(ROUND(SUM(Prices.price*UnitsSold.units)/SUM(UnitsSold.units),2),0) as average_price from Prices
LEFT JOIN UnitsSold ON (Prices.product_id = UnitsSold.product_id AND (UnitsSold.purchase_date >= Prices.start_date AND UnitsSold.purchase_date <= Prices.end_date)) Group by product_id
-- Best solution

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

-- Better Solution without JOIN 
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

SELECT DATE_FORMAT(trans_date, '%Y-%m') AS trans_month ,country as trans_count FROM Transactions


Select 
    round(avg(order_date = customer_pref_delivery_date)*100, 2) as immediate_percentage
from Delivery
where (customer_id, order_date) in (
  Select customer_id, min(order_date) 
  from Delivery
  group by customer_id
);


-- 550. Gampe play analysis IV
SELECT (ROUND(COUNT(A1.player_id)/(SELECT COUNT(DISTINCT A3.player_id) FROM Activity A3),2)) AS fraction
        from Activity A1
    where 
    (A1.player_id, DATE_SUB(A1.event_date, INTERVAL 1 DAY)) IN (
        -- the sub query
        SELECT A2.player_id, min(A2.event_date) from Activity A2 GROUP BY A2.player_id
    )

-- 1141. User Activity for the Past 30 Days I

Select activity_date as day ,(count(distinct user_id)) as active_users from Activity where (activity_date > DATE_SUB("2019-07-27", INTERVAL 30 DAY) AND activity_date<= "2019-07-27") group by activity_date 
------ (sale_id, year) is the primary key

SELECT product_id,year as first_year,quantity,price from Sales where (product_id,year) IN (
    SELECT 
  product_id, 
  MIN(year) AS year 
FROM 
  Sales 
GROUP BY 
  product_id

)

-- 596. Classes More Than 5 Students

SELECT class from Courses group by class having count(student)>=5 -- HAVING is used here


-- 619. Biggest Single Number

Select max(num) as num from (
    select num from MyNumbers Group by num having count(*)=1
) as test


--
select customer_id from Customer 
group by 
customer_id
having count(distinct product_key) = (select count(product_key) from Product)


"Advaced Selects n=and joins"
" use self join"
SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition;
-- 1731. The Number of Employees Which Report to Each Employee

FROM employees e1 JOIN employees e2 ON e1.reports_to = e2.employee_id

select * FROM employees e1 JOIN employees e2 ON e1.reports_to = e2.employee_id

select e2.employee_id,e2.name,count(e2.employee_id) as reports_count,ROUND(avg(e1.age)) as average_age FROM employees e1 JOIN employees e2 ON e1.reports_to = e2.employee_id group by e2.employee_id order by employee_id

-- 1327. List the Products Ordered in a Period
with orders_feb as
(select product_id,sum(unit) as unit from Orders 
    where DATE_FORMAT(order_date, '%Y-%m') = '2020-02'
    group by product_id order by unit desc)

select p.product_name,
        o.unit from orders_feb o join Products p 
    on o.product_id=p.product_id 
    where o.unit >= 100
    order by unit desc


-- 185. Department Top Three Salaries
with employee_dept as (
    select e.id,
        e.name as Employee,
        e.salary as Salary,
        d.id as departmentId,
        d.name Department from Employee e join Department d on
    e.departmentId = d.id),
-- select Salary,Employee, Department,Rank() over(partition by Department order by Salary desc) as sal_rank from employee_dept 
ranked_salaries as
(select Department,Employee,Salary,dense_rank() over(partition by Department order by Salary desc) as sal_rank from employee_dept )

select Department,Employee,Salary from ranked_salaries where sal_rank<= 3 order by Salary desc,Department
