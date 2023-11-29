
--1.ID-si 110 olan işçinin 1 il ərzində aldığı maaşı ekrana çıxaran blok yazın
select * from employees e where e.employee_id=110; 

declare
l_id number default 110;
salary employees.salary%type;
begin
select e.salary*12 into salary from employees e where e.employee_id=l_id; 

dbms_output.put_line(salary);
end;

     
--2. Keçirilən hər bir data tipinə aid declaration-da dəyişən elan edib onlara data 
--mənimsədib ekrana çıxarın
declare
l_name varchar2(20);
l_age number;
l_date date;
begin
dbms_output.put_line('Soltan');
dbms_output.put_line(21);
dbms_output.put_line(sysdate);
end;


--3. Block yazilir, muvafiq deyishene verilen qiymete gore Employees cedvelinden hemin 
--departmentde chalishan emekdashlarin minimum ve maksimum emek haqlarini output edir.
--Meselen:
--Dep ID: 90
--Min salary: 17,000.00
--Max salary: 24,000.00
declare 
l_dep number default 90;
min_salary employees.salary%type;
max_salary employees.salary%type;
begin
select min(e.salary),max(e.salary) 
into min_salary,max_salary
from employees e where e.department_id=l_dep; 

dbms_output.put_line('Min Salary:'||min_salary);
dbms_output.put_line('Max Salary:'||max_salary);
end;


--4. Block yazilir, iki deyishen elan olunur. Birinci deyishen insan adi bildirir(v_name), 
--ikinci deyishen yashi(v_age) bildirir. Default qiymetler veririlir ve beginden sonra 
--derhal output edilir. Body hissede yeniden qiymet verilir ve output edilir.
--Meselen:
--Zakir - 18
--Aysel - 27
declare
v_name varchar2(20) default 'Zakir';
v_age number default 18;
begin
dbms_output.put_line(v_name||'-'||v_age);
v_age:=21;
end;


--5. Block yazilir, muvafiq deyishene verilen qiymete gore Departments cedvelinden 
--department_id-sine gore department name ve location id-ni output edir.
select * from departments;

declare
l_dep_id number :=56546;
l_department_name departments.department_name%type;
l_location_id departments.location_id%type;
begin
select d.department_name,d.location_id
into l_department_name,l_location_id
from departments d where department_id=l_dep_id;

dbms_output.put_line('Department name:'|| l_department_name);
dbms_output.put_line('Location ID:'|| l_location_id);
end;


--6.Block yazilir, deyishene verilen qiymet esasinda, Countries cedvelinden region_id-ye 
--gore, hemin region id-li butun country name-leri cergulle ayrilmish shekilde output etsin.
--Meselen:
--Region ID: 5
--Countries: Olke1, Olke2, Olke3
--(Sizin cavabinizda konkret olke adlari chixacaq)









