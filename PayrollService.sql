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
