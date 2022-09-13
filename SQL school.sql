/*
create table teachers(
	teacher_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	homeroom_number varchar(50),
	department varchar(200) not null,
	email varchar(250) unique,
	phone varchar(50) unique
);

create table students(
	student_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	homeroom_number varchar(50),
	phone varchar(50) not null unique,
	email varchar(250) unique,
	graduation_year smallint
);
*/

/*
insert into students(first_name, last_name, homeroom_number, phone, graduation_year)
values('Mark', 'Watney', '5', '777-555-1234', 2035)

insert into students(first_name, last_name, homeroom_number, phone, graduation_year)
values('Juan', 'Torres', '2', '888-555-1234', 2035)

select * from students
*/

/*
insert into teachers(first_name, last_name, homeroom_number, department, email, phone)
values('Jonas', 'Salk', 5, 'Biology', 'jsalk@school.org', '777-555-4321')
*/

select * from teachers