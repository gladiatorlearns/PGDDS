use companydb_pp;
SET SQL_SAFE_UPDATES = 0;

-- ------------------------------ Session 3 :: START ------------------------------

-- 3.1a Introduction to User Defined functions:: START

drop function if exists hello;

create function hello (s char(20))
  returns char(50) deterministic
return concat('Hello, ', s, '!');

select hello ('Pooja') as greeting;

-- 3.1a Introduction to User Defined functions:: END

-- 3.1b Introduction to User Defined functions:: START

# Suppose you want to write a function that calculates total_project pay for an employee based on project

select *
from works_on;

# For simplicity we want to compute the project pay by an hourly rate as per project
## Hourly rates being
## Project no. 0 - 5 pays Rs. 1000 per hour
## Project no. 6 - 10 pays Rs. 2000 per hour
## Project no. 11 & above pays Rs. 3000 per hour

drop function if exists project_pay_calc;

DELIMITER $$

create function project_pay_calc( pno int, num_of_hours float(4,2)) 
  returns float(8,2) 
  deterministic
begin
  declare project_pay_per_hour float(8,2);

   if (pno > 0 and pno <=5 ) then
     set project_pay_per_hour = 1000;
   elseif (pno > 5 and pno <= 10) then
     set project_pay_per_hour = 2000;
   else
     set project_pay_per_hour = 3000;
  end if;

return (project_pay_per_hour * num_of_hours);
end
$$

DELIMITER ;

select 
 essn, 
 pno, 
 hours,
 project_pay_calc(pno, hours) as total_project_pay
from
 works_on;

-- 3.1b Introduction to User Defined functions:: END

-- 3.2a Stored Procedures:: START

drop procedure if exists employee_details;

DELIMITER $$
create procedure employee_details
  (in n char(9))
begin
  select *
  from employee
  where 
    ssn = n;
end $$
DELIMITER ;

call employee_details ();
call employee_details ('123456789');

-- 3.2a Stored Procedures:: END
-- 3.2b Stored Procedures:: END

drop procedure if exists employee_salary;

-- Given an employee SSN return both the annual salary as well as cumulative project specific pay based on the project
   -- and number of hours worked.

DELIMITER $$
create procedure employee_salary
  (in n char(9),
   out annual_salary float(10, 2),
   out all_project_pay float(8,2))
begin
  -- Query annual salary
  select salary into annual_salary
  from employee
  where 
    ssn = n;
  
  -- Query project_pay
  select
	sum(per_project_pay) into all_project_pay
  from
  (select
     essn,
     project_pay_calc(pno, hours) as per_project_pay
   from 
     works_on
   where 
     essn = n
   ) a;
end $$
DELIMITER ;

call employee_salary ('123456789', @annual_salary, @all_project_pay);
select @annual_salary, @all_project_pay;

-- Queries to verify if the above StoredProc is returning the correct values
select 
  salary
from 
  employee
where 
  ssn = '123456789';
  
select
  sum(per_project_pay)
from
	(select
	   essn,
	   project_pay_calc(pno, hours) as per_project_pay
	 from 
	   works_on
	 where 
	   essn = '123456789'
	 ) a;



-- 3.2a Stored Procedures:: END

-- ------------------------------ Session 3 :: END ------------------------------