
use companydb;
SET SQL_SAFE_UPDATES = 0;

-- ------------------------------ Session 2 :: START ------------------------------

-- 2.1 Introduction to Windowing functions :: START

select 
  * 
from
  employee;

select
  dno,
  sum(salary)                                     as dep_salary
from 
  employee
group by
  dno;

select 
  ssn, 
  concat(fname, ' ', lname)                 as emp_name, 
  dno, 
  salary,
  sum(salary) over ()                          as total_salary,
  sum(salary) over (partition by dno) as dep_salary
from 
  employee
order by 
  dno;

-- 2.1 Introduction to Windowing functions :: END

-- 2.2 Window functions Applications :: START

select 
  ssn, 
  concat(fname, ' ', lname)                 as emp_name, 
  dno, 
  salary,
  sum(salary) over (partition by dno order by ssn rows unbounded preceding)                            as cumulative_total,
  sum(salary) over (partition by dno order by ssn rows between 1 preceding and 1 following )   as one_above_and_one_below
from employee;

select 
  ssn, 
  concat(fname, ' ', lname)                 as emp_name, 
  dno, 
  salary,
  first_value(salary) over (partition by dno order by ssn rows unbounded preceding)                  as first_val,   -- similarly last_value
  nth_value(salary,2) over (partition by dno order by ssn rows unbounded preceding)                as second_val
from employee;

-- 2.2 Window functions Applications :: END

-- 2.3 Named Windows :: START

select 
  ssn,
  salary,
  row_number() over (order by salary)                   as 'row_number',
  rank() over (order by salary)                                as 'rank',
  dense_rank() over (order by salary)                    as 'dense_rank'
from employee;

select 
  ssn,
  salary,
  row_number() over w                   as 'row_number',
  rank() over w                                as 'rank',
  dense_rank() over w                    as 'dense_rank'
from employee 
window w as (order by salary);

select 
  ssn,
  salary,
  dno,
  row_number() over w                   as 'row_number',
  rank() over w                                as 'rank',
  dense_rank() over w                    as 'dense_rank'
from employee 
window w as (partition by dno order by salary);

-- 2.3 Named Windows :: END

-- ------------------------------ Session 2 :: END ------------------------------