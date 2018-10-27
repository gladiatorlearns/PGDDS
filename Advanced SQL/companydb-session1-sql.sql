

use companydb_pp;
SET SQL_SAFE_UPDATES = 0;

-- ------------------------------ Session 1 :: START ------------------------------

-- 1.1 Adding and deleting column :: START

select
  *
from 
  employee;
 
 -- adding a new column
 alter table employee
  add des varchar(50) default 'manager';
 
 
 -- updating a value of a column in a particular row
update employee
  set des = 'dummy1'
where 
  ssn = 123456789;
 
 
 -- removing a column
 alter table employee
  drop column des;
 
 -- 1.1 Adding and deleting column :: END
 
 
 
 
 
 
 
 -- 1.2 : Changing column name and data type :: START

select
  *
from 
  employee;

desc employee;

-- Modifying the column data-type
alter table employee
  modify salary float(10,4);

-- Changing the column name
alter table employee
  change minit minitial char(1);
  

-- 1.2 : Changing column name and data type :: END

-- 1.3: Adding and Removing Key :: START

drop table if exists recipes;
# creating a new table
create table recipes (
  recipe_id int not null,
  recipe_name varchar(30) not null,
  nothing int not null,
  primary key (recipe_name),
  unique (recipe_id)
);

# inserting values into thee new table
insert into recipes 
    (recipe_id, recipe_name,nothing) 
values 
    (1,"Tacos",4),
    (2,"Tomato Soup",5),
    (3,"Grilled Cheese",4),
    (4,"Something good",6),
    (5,"Something not so good",3),
    (6,"Something wonderful",5);
    
select *
from recipes;

desc recipes;

# dropping primary key
alter table recipes
drop primary key;

#adding primary key
alter table recipes
add primary key (recipe_id);

desc employee;

# dropping foreign key
alter table employee
drop foreign key fk_super_ssn;

#adding a foreign key
alter table employee
	add constraint fk_super_ssn foreign key (super_ssn) references employee(ssn);

-- 1.3: Adding and Removing Key :: END

-- 1.4: String Manipulation :: START

-- selecting a sub-string using delimiter occurences
-- +ve is left and -ve is right
select 
  recipe_name                                          as orig_recipe_name, 
  substring_index(recipe_name, ' ', 1)      as upd_reciper_name
from recipes;

#concat two or more string
select 
  concat(fname, ' ' , lname) as name,
  -- substring_index( concat(fname, ' ' , lname) , ' ' , -1)  as test_name,
  ssn
from employee;

-- 1.4 String Manipulation :: END

-- 1.5 Date Manipulation :: START

select * 
from employee;

select 
  bdate, 
  extract(year from bdate)      as year,
  extract(month from bdate)   as month,
  extract(day from bdate)       as day
from employee;

-- 1.5 Date Manipulation :: END

-- ------------------------------ Session 1 :: END ------------------------------
