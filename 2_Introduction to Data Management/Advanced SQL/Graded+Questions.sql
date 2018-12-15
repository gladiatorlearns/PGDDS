use companydb;

#Graded questions 1
#Set 2
#Question 1

select address from employee;

select sum(substring_index(address, ' ', 1))
from employee;

#Question 2
alter table employee 
add hno int;

update employee
set hno = substring_index(address, ' ', 1);

select name,hno,
rank() over (order by hno) as 'rank'
from employee;

#Question 3

select  avg(abs(hno-(select hno
from employee
where ssn = '123456789'
)))
from employee
where ssn != '123456789';

#Graded question 2
#Set 1
#Question 1

select e.name , b.bdate
from employee e inner join employee b  on e.super_ssn = b.ssn
where e.ssn = '666884444';

#Set 2
#Question 1

update employee
set age = 2018 - year(bdate);

select sum(age)
from employee;

#Question 2

select e.age, b.age, e.name, b.name,abs(e.age-b.age), e.ssn
from employee e inner join employee b on e.super_ssn = b.ssn
where e.ssn ='987654321';

#Question 3

select name,ssn,dno, salary/age,
rank() over(order by (salary/age) desc) as 'Rank'
from employee;


#Graded questions 3
#Set 1
#Question 1

create procedure supervisor 
(in n char(9))
select *
from employee
where ssn = ( select super_ssn from employee where ssn = n );

call supervisor('123456789');

#Question 2

create function distance (s char(20))
returns float (10,4) deterministic
return 
(
select avg(abs(hno-
(select hno 
from employee
where ssn = s)))
from employee
where ssn != s
);

select distance(ssn), ssn
from employee
where super_ssn IS NULL;

#Question 3

create function dep_distance (s char(20), d int)
returns float (10,4) deterministic
return 
(
select avg(abs(hno-
(select hno 
from employee
where ssn = s)))
from employee
where ssn != s and dno = d
);

select dno, hno, name, dep_distance(ssn, dno)
from employee
where name = 'Franklin wong';