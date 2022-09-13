/*
create table account(
	user_id serial primary key,
	username varchar(50) unique not null,
	password varchar(50) not null,
	email varchar(250) unique not null,
	created_on timestamp not null,
	last_login timestamp
)

create table job(
	job_id serial primary key,
	job_name varchar(200) unique not null
)

create table account_job(
	user_id integer references account(user_id),
	job_id integer references job(job_id),
	hire_date timestamp
)

insert into account(username, password, email, created_on)
values
('Jose', '123', 'jose@gmail.com', current_timestamp)

select * from account

insert into job(job_name)
values('Astronaut')

insert into job(job_name)
values('President')

select * from job

insert into account_job(user_id, job_id, hire_date)
values(1, 1, current_timestamp)

select * from account_job

update account
set last_login = created_on
returning account_id, last_login

update account_job
set hire_date=account.created_on
from account
where account_job.user_id=account.user_id


update account
set last_login=current_timestamp
returning email, created_on, last_login

insert into job(job_name)
values('Cowboy')

select * from job

delete from job
where job_name = 'Cowboy'

select * from job

create table information(
	info_id serial primary key,
	title varchar(500) not null,
	person varchar(50) not null unique
)

select * from information

alter table information
rename to new_info

select * from new_info

alter table new_info
rename column person to people

select * from new_info

alter table new_info
alter column people drop not null

insert into new_info(title)
values
('some new title')

select * from new_info

alter table new_info
drop column people

select * from new_info

alter table new_info
drop column if exists people

create table employees(
	emp_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birthdate date check (birthdate>'1900-01-01'),
	hiredate date check (hiredate>birthdate),
	salary integer check (salary>0)
)

insert into employees(
	first_name, last_name, birthdate, hiredate, salary
)
values
('Jose', 'Portilla', '1990-02-19', '2010-03-22', 1000)

insert into employees(
	first_name, last_name, birthdate, hiredate, salary
)
values
('Sammy', 'Smith', '1990-11-03', '2010-03-22', 1000)

select * from employees
*/

----------------------------------------------------------------
-- NULLIF
----------------------------------------------------------------
/*
create table depts(
	first_name varchar(50),
	department varchar(50)
);

insert into depts(first_name, department)
values
('Victor', 'A'),
('Laura', 'A'),
('Claire', 'B');
*/

--select * from depts;
/*
select 
	sum(case when department='A' then 1 else 0 end) / 
	nullif(sum(case when department='B' then 1 else 0 end), 0) as dept_ratio
from depts;
*/

----------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------
