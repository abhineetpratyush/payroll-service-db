#PayrollService

# To see existing databases
show databases;

# Create a new database
create database payroll_service;

# To use a particular database
use payroll_service;

# To see currently used database
select database();

# Create table
create table employee_payroll
(
  id 	       int unsigned not null auto_increment,
  name	       varchar(150) not null,
  salary       double not null,
  start        date not null,
  primary key  (id)
);

# Drop table
drop table employee_payroll;

# Display details of fields of table
describe employee_payroll;

# Insert employee records into the table
insert into employee_payroll 
(name, salary, start)
values
   ('Bill', 1000000.00, '2018-01-03'),
   ('Mark', 2000000.00, '2019-11-13'),
   ('Charlie', 3000000.00, '2020-05-21');

# Ability to retrieve all data from employee_payroll table
select * from employee_payroll;

# Ability to get salary for a particular employee
select salary from employee_payroll where name = 'Bill';

# Ability to delete a particular record 
delete from employee_payroll where name = 'Bill';

# Ability to select all fields for employees acording to start date in a range
select * from employee_payroll 
	where start between cast('2018-01-01' as date) and date(now());

# Ability to add gender field in the table
alter table employee_payroll add gender char(1) after name;

# Ability to drop a field
alter table employee_payroll drop gender;

# Ability to update gender fields for all employees
update employee_payroll set gender = 'M' where name = 'Bill' or name = 'Charlie';

update employee_payroll set gender = 'F' where name = 'Mark';

# Ability to find sum, averagem, min, max and number of male and female employees

select sum(salary) from employee_payroll where gender = 'F' group by gender;

select sum(salary) from employee_payroll where gender = 'M' group by gender;

select gender, sum(salary) from employee_payroll group by gender;

select gender, avg(salary) from employee_payroll group by gender;

select gender, count(name) from employee_payroll group by gender;

select min(salary) from employee_payroll;

select max(salary) from employee_payroll;

# Extend to insert new fields for phone_number, address (default value TBD), department

alter table employee_payroll 
add phone_number varchar(250) after name;

alter table employee_payroll
add address varchar(250) after phone_number;

alter table employee_payroll
alter address set deafult 'TBD';

alter table employee_payroll
add department varchar(150) not null after address;

insert into employee_payroll
(name, salary, start, gender, department)
values
('Terissa', 2500000.00, '2020-04-01', 'F', 'Marketing');

# Extend to add fields related to salary and tax calculation

alter table employee_payroll rename column salary to basic_pay;

alter table employee_payroll add deductions double not null after basic_pay;

alter table employee_payroll add taxable_pay double not null after deductions;

alter table employee_payroll add tax double not null after taxable_pay;

alter table employee_payroll add net_pay double not null after tax;

# Ability to make Terissa part of both sales and marketing department

insert into employee_payroll
(name, start, gender, department, basic_pay, deductions, taxable_pay, tax, net_pay)
values
('Terissa', '2020-04-01', 'F', 'Sales', 2500000.00, 100000.00, 2400000.00, 100000.00, 2300000.00);

select * from employee_payroll where name = 'Terissa';

# Implement ER diagram into payroll_service database

drop table employee_payroll;

create table company 
(
  comp_id      int unsigned not null,
  comp_name    varchar(150) not null,
  primary key  (comp_id)
);

insert into company 
values
(1,'XYZ Global');

create table department
(
	department varchar(50) not null;
	primary key (department)
);

insert into department
values 
('Finance'),
('IT'),
('Marketing'),
('Operations'),
('Sales');

create table employee
(
	emp_id int unsigned not null,
	comp_id int unsigned,
	name varchar(150) not null,
	gender char(1),
	address varchar(300) not null,
	phone_number varchar(50) not null,
	start date not null,
	primary key (emp_id),
	foreign key (comp_id) references company(comp_id)
);

insert into employee
values
(1,1,'Bill','M','d-208, bhiwandi','1234567891','2018-01-03'),
(2,1,'Mark','F','e-208, bangalore','1234567892','2019-11-13'),
(3,1,'Charlie','M','f-218, delhi','1233567892','2020-05-21'),
(4,1,'Terissa','F','g-278, mumbai','0233567892','2020-04-01');

create table employee_department
(
	emp_id     int unsigned,
	department varchar(50),
	foreign key (emp_id) references employee(emp_id),
	foreign key (department) references department(department)
);

insert into employee_department
values
(4,'Sales'),
(4,'Marketing'),
(1,'IT'),
(2,'Finance'),
(3,'Operations');

create table payroll
(
	emp_id int unsigned,
	basic_pay double not null,
	deductions double not null,
	taxable_pay double not null,
	tax double not null,
	net_pay double not null,
	foreign key (emp_id) references employee(emp_id)
);

insert into payroll
values
(1,2000,500,1500,100,1400),
(2,2500,400,2100,100,2000),
(3,2600,300,2300,200,2100),
(4,1000,200,800,50,750);
