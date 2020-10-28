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


