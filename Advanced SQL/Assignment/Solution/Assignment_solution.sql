drop schema assignment;

# Creating new databse schema
create schema assignment;

# Initiating the schema
use assignment;

# Import tables bajaj, eicher, hero, infosys, tcs, tvs
# Testing

select *
from bajaj;

# Note the absence of limit.

-------------------------------------------------------------------------------------

# Creating bajaj1

create table bajaj1 as 
select Date, round(`Close Price`,2) as 'Close Price', 
round(avg(`Close Price`) over (rows between 0 preceding and 19 following),2) as 20_Day_MA,
round(avg(`Close Price`) over (rows between 0 preceding and 49 following),2) as 50_Day_MA from bajaj;

# Checking bajaj1

select * 
from bajaj1
limit 5;


# Creating eicher1

create table eicher1 as 
select Date, round(`Close Price`,2) as 'Close Price', 
round(avg(`Close Price`) over (rows between 0 preceding and 19 following),2) as 20_Day_MA,
round(avg(`Close Price`) over (rows between 0 preceding and 49 following),2) as 50_Day_MA from eicher;

# select * from eicher1;


# Creating hero1

create table hero1 as 
select Date, round(`Close Price`,2) as 'Close Price', 
round(avg(`Close Price`) over (rows between 0 preceding and 19 following),2) as 20_Day_MA,
round(avg(`Close Price`) over (rows between 0 preceding and 49 following),2) as 50_Day_MA from hero;

# select * from hero1;


# Creating infosys1

create table infosys1 as 
select Date, round(`Close Price`,2) as 'Close Price', 
round(avg(`Close Price`) over (rows between 0 preceding and 19 following),2) as 20_Day_MA,
round(avg(`Close Price`) over (rows between 0 preceding and 49 following),2) as 50_Day_MA 
from infosys;

# select * from infosys1;


# Creating tcs1

create table tcs1 as 
select Date, `Close Price`, 
round(avg(`Close Price`) over (rows between 0 preceding and 19 following),2) as 20_Day_MA,
round(avg(`Close Price`) over (rows between 0 preceding and 49 following),2) as 50_Day_MA from tcs;

# select * from tcs1;


# Creating tvs1

create table tvs1 as 
select Date, round(`Close Price`,2) as 'Close Price', 
round(avg(`Close Price`) over (rows between 0 preceding and 19 following),2) as 20_Day_MA,
round(avg(`Close Price`) over (rows between 0 preceding and 49 following),2) as 50_Day_MA from tvs;

# select * from tvs1;



-------------------------------------------------------------------------------------------

# Creating the master table

create table master_table as
select tvs.Date, 
round(tvs.`Close Price`,2) as TVS,
round(tcs.`Close Price`,2) as TCS,
round(infosys.`Close Price`,2) as Infosys, 
round(eicher.`Close Price`,2) as Eicher, 
round(hero.`Close Price`,2) as Hero, 
round(bajaj.`Close Price`,2) as Bajaj
from tvs 
left join tcs on tvs.Date = tcs.Date
left join infosys on tvs.Date = infosys.Date
left join eicher on tvs.Date = eicher.Date
left join hero on tvs.Date = hero.Date
left join bajaj on tvs.Date = bajaj.Date;

select * 
from master_table
limit 5;

SET SQL_SAFE_UPDATES = 0;

------------------------------------------------------------------------------------------------

# Creating bajaj2
# Notice we are dropping 20 day ma and 50 day ma as we are now interested in differnece
# Also note that we have added a column named row number and using that in join as opposed to date. Why?
# Because trading is off on weekends

create table bajajx 
select `Date`, `Close Price`,
20_day_MA - 50_day_ma 'Flag' , 
row_number() over () as 'Row'
from bajaj1;

# Adding a signal column (Populate it with the default hold)

alter table bajajx
add column `Signal` varchar(6) default 'Hold';


# Testing

select * 
from bajajx
limit 5;



# We need to look for a change in the sign of flag. (positive to negative and vice versa) 
# Need to bring the previuos flag in the same row for the purpose of comparison
# Will use self join for the same. This is where our row number column will come in handy.


# Testing to create a new table

select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from bajajx a inner join bajajx b on a.row = b.row-1
limit 5;


# Create a new table bajaj2

create table bajaj2 as
select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from bajajx a inner join bajajx b on a.row = b.row-1;


# Important to keep track of our tables

select *
from bajaj2
limit 5;

# All left now is to update the signal column based on the values of flag and flagp.
# Remember flag is defined as 20 Day MA - 50 Day MA. 
# When the sign changes from -ve to +ve, buy as the stock is on an upturn
# When the sign changes from +ve to -ve , sell 
# Note that when the flag and flagp are of same sign no signal is generated (Hold default)

update bajaj2
set `signal` = 'Buy'
where flag > 0 and flagp <0 ;

select *
from bajaj2
where `signal` = 'buy';

update bajaj2
set `signal` = 'Sell'
where flag < 0 and flagp > 0 ;

select *
from bajaj2
where `signal` = 'sell' or `signal` = 'buy';


# Repeating the operation for eicher

create table eicherx 
select `Date`, `Close Price`,
20_day_MA - 50_day_ma 'Flag' , 
row_number() over () as 'Row'
from eicher1;

# Adding a signal column (Populate it with the default hold)

alter table eicherx
add column `Signal` varchar(6) default 'Hold';

# Testing

select * 
from eicherx
limit 5;



# We need to look for a change in the sign of flag. (positive to negative and vice versa) 
# Need to bring the previuos flag in the same row for the purpose of comparison
# Will use self join for the same. This is where our row number column will come in handy.


# Testing to create a new table

select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from eicherx a inner join eicherx b on a.row = b.row-1
limit 5;


# Create a new table eicher2

create table eicher2 as
select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from eicherx a inner join eicherx b on a.row = b.row-1;


# Important to keep track of our tables

select *
from eicher2
limit 5;

# All left now is to update the signal column based on the values of flag and flagp.
# Remember flag is defined as 20 Day MA - 50 Day MA. 
# When the sign changes from -ve to +ve, buy as the stock is on an upturn
# When the sign changes from +ve to -ve , sell 
# Note that when the flag and flagp are of same sign no signal is generated (Hold default)

update eicher2
set `signal` = 'Buy'
where flag > 0 and flagp <0 ;

select *
from eicher2
where `signal` = 'buy';

update eicher2
set `signal` = 'Sell'
where flag < 0 and flagp > 0 ;

select *
from eicher2
where `signal` = 'sell' or `signal` = 'buy';

# Creatin hero2

create table herox 
select `Date`, `Close Price`,
20_day_MA - 50_day_ma 'Flag' , 
row_number() over () as 'Row'
from hero1;

# Adding a signal column (Populate it with the default hold)

alter table herox
add column `Signal` varchar(6) default 'Hold';

# Testing

select * 
from herox
limit 5;



# We need to look for a change in the sign of flag. (positive to negative and vice versa) 
# Need to bring the previuos flag in the same row for the purpose of comparison
# Will use self join for the same. This is where our row number column will come in handy.


# Testing to create a new table

select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from herox a inner join herox b on a.row = b.row-1
limit 5;


# Create a new table hero2

create table hero2 as
select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from herox a inner join herox b on a.row = b.row-1;


# Important to keep track of our tables

select *
from hero2
limit 5;

# All left now is to update the signal column based on the values of flag and flagp.
# Remember flag is defined as 20 Day MA - 50 Day MA. 
# When the sign changes from -ve to +ve, buy as the stock is on an upturn
# When the sign changes from +ve to -ve , sell 
# Note that when the flag and flagp are of same sign no signal is generated (Hold default)

update hero2
set `signal` = 'Buy'
where flag > 0 and flagp <0 ;

select *
from hero2
where `signal` = 'buy';

update hero2
set `signal` = 'Sell'
where flag < 0 and flagp > 0 ;

select *
from hero2
where `signal` = 'sell' or `signal` = 'buy';

# Creating infosys1

create table infosysx 
select `Date`, `Close Price`,
20_day_MA - 50_day_ma 'Flag' , 
row_number() over () as 'Row'
from infosys1;

# Adding a signal column (Populate it with the default hold)

alter table infosysx
add column `Signal` varchar(6) default 'Hold';

# Testing

select * 
from infosysx
limit 5;



# We need to look for a change in the sign of flag. (positive to negative and vice versa) 
# Need to bring the previuos flag in the same row for the purpose of comparison
# Will use self join for the same. This is where our row number column will come in handy.


# Testing to create a new table

select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from infosysx a inner join infosysx b on a.row = b.row-1
limit 5;


# Create a new table infosys2

create table infosys2 as
select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from infosysx a inner join infosysx b on a.row = b.row-1;


# Important to keep track of our tables

select *
from infosys2
limit 5;

# All left now is to update the signal column based on the values of flag and flagp.
# Remember flag is defined as 20 Day MA - 50 Day MA. 
# When the sign changes from -ve to +ve, buy as the stock is on an upturn
# When the sign changes from +ve to -ve , sell 
# Note that when the flag and flagp are of same sign no signal is generated (Hold default)

update infosys2
set `signal` = 'Buy'
where flag > 0 and flagp <0 ;

select *
from infosys2
where `signal` = 'buy';

update infosys2
set `signal` = 'Sell'
where flag < 0 and flagp > 0 ;

select *
from infosys2
where `signal` = 'sell' or `signal` = 'buy';

# Creating TCS2

create table tcsx 
select `Date`, `Close Price`,
20_day_MA - 50_day_ma 'Flag' , 
row_number() over () as 'Row'
from tcs1;

# Adding a signal column (Populate it with the default hold)

alter table tcsx
add column `Signal` varchar(6) default 'Hold';

# Testing

select * 
from tcsx
limit 5;



# We need to look for a change in the sign of flag. (positive to negative and vice versa) 
# Need to bring the previuos flag in the same row for the purpose of comparison
# Will use self join for the same. This is where our row number column will come in handy.


# Testing to create a new table

select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from tcsx a inner join tcsx b on a.row = b.row-1
limit 5;


# Create a new table tcs2

create table tcs2 as
select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from tcsx a inner join tcsx b on a.row = b.row-1;


# Important to keep track of our tables

select *
from tcs2
limit 5;

# All left now is to update the signal column based on the values of flag and flagp.
# Remember flag is defined as 20 Day MA - 50 Day MA. 
# When the sign changes from -ve to +ve, buy as the stock is on an upturn
# When the sign changes from +ve to -ve , sell 
# Note that when the flag and flagp are of same sign no signal is generated (Hold default)

update tcs2
set `signal` = 'Buy'
where flag > 0 and flagp <0 ;

select *
from tcs2
where `signal` = 'buy';

update tcs2
set `signal` = 'Sell'
where flag < 0 and flagp > 0 ;

select *
from tcs2
where `signal` = 'sell' or `signal` = 'buy';


# Creating tvs2

create table tvsx 
select `Date`, `Close Price`,
20_day_MA - 50_day_ma 'Flag' , 
row_number() over () as 'Row'
from tvs1;

# Adding a signal column (Populate it with the default hold)

alter table tvsx
add column `Signal` varchar(6) default 'Hold';

# Testing

select * 
from tvsx
limit 5;



# We need to look for a change in the sign of flag. (positive to negative and vice versa) 
# Need to bring the previuos flag in the same row for the purpose of comparison
# Will use self join for the same. This is where our row number column will come in handy.


# Testing to create a new table

select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from tvsx a inner join tvsx b on a.row = b.row-1
limit 5;


# Create a new table tvs2

create table tvs2 as
select a.`Date`, a.`close price`, a.flag, b.flag 'Flagp' , a.row , a.signal
from tvsx a inner join tvsx b on a.row = b.row-1;


# Important to keep track of our tables

select *
from tvs2
limit 5;

# All left now is to update the signal column based on the values of flag and flagp.
# Remember flag is defined as 20 Day MA - 50 Day MA. 
# When the sign changes from -ve to +ve, buy as the stock is on an upturn
# When the sign changes from +ve to -ve , sell 
# Note that when the flag and flagp are of same sign no signal is generated (Hold default)

update tvs2
set `signal` = 'Buy'
where flag > 0 and flagp <0 ;

select *
from tvs2
where `signal` = 'buy';

update tvs2
set `signal` = 'Sell'
where flag < 0 and flagp > 0 ;

select *
from tvs2
where `signal` = 'sell' or `signal` = 'buy';

----------------------------------------------------------------------- Done

# All tables have been created

# Now to create a User defined function

select `signal`
from bajaj2 where `date` = '18-May-2018';

create function result (d char(20))
returns char(10) deterministic
return 
(
select `signal`
from bajaj2 where `date` = d
);


# Testing

select `date`, result(`date`)
from bajaj2
where result(`date`) = 'buy';

# Thank you
