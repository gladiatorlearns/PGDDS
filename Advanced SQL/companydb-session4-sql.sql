use companydb_pp;
SET SQL_SAFE_UPDATES = 0;

-- ------------------------------ Session 4 :: START ------------------------------

-- 4.1 Query optimizations:: START

-- avoid a --
select
 *
from 
  employee e
  inner join department d
    on e.dno = d.dnumber
having
  dname like '%Research%'; 

-- instead a --  
select 
  fname,
  bdate
from 
  employee e
  inner join department d
    on e.dno = d.dnumber
where
	dname like '%Research%'
limit 2;

-- avoid b --

select
  fname,
  salary
from
  employee
where
  salary > 10000 and (salary/5) > 6000;

-- instead b --

select
  fname,
  salary
from
  employee
where
  salary > 30000
;

-- 4.1 Query optimizations:: END

-- 4.2 Query optimizations:: START

-- avoid a  -- 

-- instead a  --

-- Apply group by on a single table at a time. 

-- avoid b --
select 
  e.dno, 
  avg(w.hours)
from employee e 
  inner join works_on w
    on e.ssn=w.essn
group by dno, essn;

-- check for uniqueness --
select
ssn, 
count(distinct dno) as dis_dno
from
employee
group by 1
having count(distinct dno) > 1;

-- instead b --
select 
  dno,
  ssn, 
  avg(hours)
from employee
  inner join works_on 
    on employee.ssn=works_on.essn
group by  essn;

-- group by --

-- avoid c --
select
  fname,
  lname,
  bdate
from employee
where 
  fname  like '%a%'
order by bdate;

-- instead c --
select
  fname,
  lname,
  bdate
from employee
where 
  ssn in ('888665555', '333445555', '666884444', '999887777', '987987987')
order by bdate;

-- joins --

-- instead d --
select 
  fname,
  ssn,
  essn,
  dependent_name,
  relationship
from
( select 
     fname,
     ssn,
     dno
   from employee
   where 
     dno=4
) e
inner join
( select 
   essn,
   dependent_name,
   relationship
  from dependent
  where 
    relationship = 'Spouse'
) d 
  on e.ssn = d.essn;
  
-- instead d --
select 
  fname,
  ssn,
  essn,
  dependent_name,
  relationship
from
( select 
     fname,
     ssn,
     dno
   from employee
) e
inner join
( select 
   essn,
   dependent_name,
   relationship
  from dependent
) d 
on e.ssn = d.essn and e.dno=4 and d.relationship= 'Spouse';


-- window functions --

-- avoid e --
select 
  ssn,
  salary,
  row_number() over(order by salary ) as row_number,
  rank()  over(order by salary )             as rank,
  dense_rank()  over(order by salary ) as dense_rank
from employee;

-- instead e --
select 
  ssn,
  salary,
  row_number() over w                  as row_number,
  rank() over w                                  as rank,
  dense_rank() over w                    as dense_rank
from employee
window w as (order by salary);

