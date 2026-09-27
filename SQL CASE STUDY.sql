
__students

create table students (student_id int primary key,student_name text,email text,phone bigint,city text,enrollment_date date);
insert into students values (101,'priya','priya@gmail.com',9876543210,'chennai','2025-01-10');
insert into students values (102,'sivai','siva@gmail.com',9876543211,'madurai','2025-02-15');
insert into students values (103,'guna','guna@gmail.com',9876543212,'trichy','2025-03-20');
insert into students values (104,'divya','divya@gmail.com',9876543213,'chennai','2025-04-25');
insert into students values (105,'santhiya','santhiya@gmail.com',9876543214,'madurai','2024-12-20');
insert into students values (106,'maran','maran@gmail.com',null,'madurai','2025-05-30');
insert into students values (107,'veera',null,9876543211,'madurai','2025-09-30');
insert into students values (108,'sathish','sathish@gmail.com',9876543211,'madurai','2025-07-30');
insert into students values (109,'kavi','kavi@gmail.com',9876543211,'madurai','2025-08-30');
insert into students values (110,'vino','vino@gmail.com',9876543211,'madurai','2025-05-18');

__course
drop table course CASCADE
create table course (course_id int primary key,course_name text,course_fee int);
insert into course values (1,'mba',25000),(2,'bca',30000),(3,'b.com',35000),(4,'data analytics',40000),
(5,'mba',45000),(6,'excel',50000);

__enrollments

create table enrollments (enrollment_id int,student_id int references students (student_id),
course_id int references course (course_id),enrollment_date date);

insert into enrollments values (1,101,1,'2025-01-10'),(2,102,2,'2025-02-15'),(3,103,3,'2025-03-20'),
(4,104,4,'2025-04-25'),(5,105,5,'2025-05-30'),(6,106,6,'2025-03-20');

__payment
drop table payment
create table payment (payment_id int,payment_status text,payment_amount int,payment_date date,student_id int,course_id int,
foreign key(student_id)references students(student_id), 
foreign key (course_id)references course(course_id));
insert into payment values(1,'paid',3000,'2025_09_14',101,1);
insert into payment values(2,'unpaid',13000,'2025_08_12',102,2);
insert into payment values(3,'paid',33000,'2025_07_24',103,3);
insert into payment values(4,'unpaid',39000,'2025_06_14',104,4);
insert into payment values(5,'paid',50000,'2025_05_04',105,5);

select * from students;
select * from course;
select * from enrollments;
select * from payment;


--1
select * from enrollments where enrollment_date >'2025-01-01';

__question_2__
select distinct course_name from course;

__question_3__
select * from students where student_name like 'k%' and city in ('chennai','madurai');

__question_4__
select * from course where course_fee between 15000 and 40000;

__question_5__
select * from course where course_fee>40000 limit 3;

__question_6__
select course_name,count(course_fee)from course group by course_name

__question_7__

select course_name,count(*)from course group by course_name having count(*)>1  

__question_8__
select sum(payment_amount) as total_fees,
avg(payment_amount) as average_payment,
max(payment_amount) as maximum_payment,
min(payment_amount) as minimum_payment
from payment;

__question_9__
select s.student_id,c.course_id,e.enrollment_date from students s
inner join enrollments e on s.student_id=e.student_id 
inner join course c on c.course_id=e.course_id;

__question_10__

select s.student_name,c.course_name,p.payment_amount,p.payment_date
from students s
join enrollments e on s.student_id=e.student_id
join course c on c.course_id=e.course_id 
join payment p on s.student_id=p.student_id;

__question_11__
select*from payment where payment_status='unpaid'

__question_12__
select * from payment where payment_amount >(select avg (payment_amount) from payment)

__question_13__
select course_name,count(*) from course group by course_name having count(*)>1 limit 3

__question_14__
select email,count(*) from student group by email having count(*) >1;

__question_15__
select * from students where phone is null or email is null;

__question_16__
select *,upper(student_name)as students from students;
select *,length(student_name)as students from students


__question_17__
select*,case
when course_fee>30000 then 'basic'
when course_fee between 20000 and 35000 then 'intermediate'
else 'advanced'
end as payment_status from course;

__question_18__
select *,case 
when payment_status='paid' then 'paid'
when payment_amount >=0 then 'partially_paid'
else 'unpaid'
end as payment_status
from payment;

__question_19__
create index idx_students_id on enrollments(student_id);
create index idx_course_id on enrollments(course_id);
select* from enrollments

drop table enrollments CASCADE
__question_20__
select s.student_name, c.course_name, p.payment_amount,case
when payment_status='paid' then 'paid'
when payment_amount >0 then 'partially_paid'
else 'pending'
end as payment_status
from enrollments e
join students s on e.student_id=s.student_id
join course c on e.course_id=c.course_id
join payment p on p.payment_id=p.payment_id
order by p.payment_amount  desc;



