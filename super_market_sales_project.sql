## Q1 Number of gun deaths by year
	## Q2 Intent mix %
	## Q3 Average age of homicides, suicides
	## Q4 Deaths by place ranked 
	## Q5 Which race has the most homicides, suicides

## Got dataset from Kaggle. Issue with imported whole dataset due to number of rows. 
## Broke up dataset into 6 smaller datasets for import. 

## Explored each of the 6 datasets. 

select *
from gun_deaths_2012_1st_half;

## Verfied counts of each to make sure no data was missing.
## 16477 2012_1st_half
## Identified error 33700 gun_deaths_2012_2nd_half has data for whole year. DO NOT USE first_half 

select count(*)
from gun_deaths_2012_2nd_half;

select distinct(month)
from gun_deaths_2012_2nd_half
order by month; 

## 16617 2013_1st_half
## 17008 2013_2nd_half
## 16351 2014_1st_half
## 17244 2014_2nd_half

## Fomatting: Union to bring together all tables to one. Saved it as a view for ease. 

CREATE VIEW deaths_of_guns as
(Select *
from gun_deaths_2012_2nd_half ## all of 2012
union all
select *
from gun_deaths_2013_1st_half
union all
select *
from gun_deaths_2013_2nd_half
union all
select *
from gun_deaths_2014_1st_half
union all
select *
from gun_deaths_2014_2nd_half);

##checked view to make sure its correct

select *
from gun_deaths;

## checked for NULLs and blanks, I am not answering questions on education, so keeping all records. 
## Place column had many blank values as well. I will account for this when answering Q4

select * 
from gun_deaths
where education is NULL;

select *
from gun_deaths
where education  = "";

## Q1 Number of gun deaths by year

SELECT year, count(*) as deaths
FROM gun_deaths
GROUP BY year
ORDER BY year;
## Q1A Number of gun deaths by year by intent
SELECT year, intent, count(*) as deaths
FROM gun_deaths
WHERE intent != ""
GROUP BY year, intent
ORDER BY year;

## Q2 Intent mix %
##(you can use this query below to double check percentages)
select intent, count(*) as total_deaths
from deaths_of_guns
group by intent

select intent, count(*) * 100/(select count(*) from deaths_of_guns) as percentage_of_total
from deaths_of_guns
group by intent


## Q3 Average age of homicides, suicides
SELECT intent,
	avg(age) as average_age
FROM gun_deaths
WHERE intent IN ('homicide', 'suicide', 'accidental')
GROUP BY intent;

## Q4 Deaths by place ranked 
SELECT place, count(*) as death_count
FROM gun_deaths
WHERE place != ""
GROUP BY place
ORDER BY death_count desc;

## Q5 Which race has the most homicides, suicides

SELECT race, intent, count(*) as death_count
FROM gun_deaths
WHERE race != "" and intent != ""
GROUP BY race, intent
ORDER BY death_count desc
