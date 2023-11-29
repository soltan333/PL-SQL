--1. EMPLOYEES_OPERATİONS adında package yaradın və bu package-də aşağıda qeyd edilən 
--funksiya və prosedurları elan edin
create or replace package emp_operations is
--
function get_salary (emp_id employees.employee_id%type)
return employees.employee_id%type;
--
function get_salary(emp_p_num employees.phone_number%type)
return employees.phone_number%type;
--
procedure emp_insert(emp_id employees.employee_id%type,
                                       emp_f_name employees.first_name%type,
                                       emp_l_name employees.last_name%type,
                                       emp_email employees.email%type,
                                       emp_p_number employees.phone_number%type,
                                       emp_h_date employees.hire_date%type,
                                       emp_j_id employees.job_id%type,
                                       emp_salary employees.salary%type,
                                       emp_c_pct employees.commission_pct%type,
                                       emp_m_id employees.manager_id%type,
                                       emp_dep_id employees.department_id%type);
                                       
--                                       
procedure emp_arch_insert;
--
procedure emp_reduce_salary (emp_id employees.employee_id%type);
end;


-------------------------------------------------------
create or replace package body emp_operations is
--
function get_salary (emp_id employees.employee_id%type)
return employees.employee_id%type
is
emp_salary employees.salary%type;
begin
  select e.salary into emp_salary from employees e where e.employee_id=emp_id;

  return emp_salary ;
  end get_salary;
--  
function get_salary(emp_p_num employees.phone_number%type)
return employees.phone_number%type
is
emp_h_date employees.hire_date%type;
begin
  select e.hire_date into emp_h_date from employees e where e.phone_number=emp_p_num;
  return emp_h_date;
  end get_salary;
--  
procedure emp_insert(emp_id employees.employee_id%type,
                                       emp_f_name employees.first_name%type,
                                       emp_l_name employees.last_name%type,
                                       emp_email employees.email%type,
                                       emp_p_number employees.phone_number%type,
                                       emp_h_date employees.hire_date%type,
                                       emp_j_id employees.job_id%type,
                                       emp_salary employees.salary%type,
                                       emp_c_pct employees.commission_pct%type,
                                       emp_m_id employees.manager_id%type,
                                       emp_dep_id employees.department_id%type)
as
begin
  insert into employees values(emp_id,emp_f_name,emp_l_name,emp_email,emp_p_number,
  emp_h_date,emp_j_id,emp_salary,emp_c_pct,emp_m_id,emp_dep_id);
  end emp_insert;  
  
--  
procedure emp_arch_insert
as
begin
  for rec in (select * from employees where to_char(hire_date,'day')='monday   ')
  loop
    insert into employees_archive values( rec.employee_id,
                                    rec.first_name,
                                    rec.last_name,
                                    rec.email,
                                    rec.phone_number,
                                    rec.hire_date,
                                    rec.job_id,
                                    rec.salary,
                                    rec.commission_pct,
                                    rec.manager_id,
                                    rec.department_id);
    end loop;
    end emp_arch_insert; 
--   
procedure emp_reduce_salary (emp_id employees.employee_id%type)
as
emp_salary employees.salary%type;
except_code varchar2(20);
except_msg varchar2 (200);
a exception;
begin
  select e.salary into emp_salary from employees e where e.employee_id=emp_id;
  
  if emp_salary<10000 then
    raise a;
    end if;
 update employees e set e.salary=emp_salary-10000 where e.employee_id=emp_id;

  exception
    when a then
      except_msg:=sqlerrm;
      except_code:=sqlcode;

      insert into error_log values (except_code,except_msg,sysdate,emp_id);
 end emp_reduce_salary;    
 
 end  emp_operations;
  
 begin
   
 emp_operations.emp_arch_insert;
 
 end;

 
--1. Ötürülən id-li işçinin maaşını ekrana çıxaran funksiya yazın və əgər ötürülən id-də işçi
-- yoxdursa exception loglamasından istifadə edərək loglayın.
--Sonra bu funksiyanı run edib nəticəni yoxlayın
create or replace  function get_salary (emp_id employees.employee_id%type)
return employees.employee_id%type
is
emp_salary employees.salary%type;
begin
  select e.salary into emp_salary from employees e where e.employee_id=emp_id;

  return emp_salary ;
  end;
  
  
  
declare
m_salary number;
begin 
m_salary:= emp_operations.get_salary(emp_id => 20);
dbms_output.put_line( m_salary);
end;


--2. Employees cədvəlinə insert edən prosedur yaradın. Sonra bu prosedur-dan istifadə edərək
-- 5 işçi insert edin

create or replace procedure emp_insert(emp_id employees.employee_id%type,
                                       emp_f_name employees.first_name%type,
                                       emp_l_name employees.last_name%type,
                                       emp_email employees.email%type,
                                       emp_p_number employees.phone_number%type,
                                       emp_h_date employees.hire_date%type,
                                       emp_j_id employees.job_id%type,
                                       emp_salary employees.salary%type,
                                       emp_c_pct employees.commission_pct%type,
                                       emp_m_id employees.manager_id%type,
                                       emp_dep_id employees.department_id%type)
as
begin
  insert into employees values(emp_id,emp_f_name,emp_l_name,emp_email,emp_p_number,
  emp_h_date,emp_j_id,emp_salary,emp_c_pct,emp_m_id,emp_dep_id);
  end;
 

 
begin
  emp_operations.emp_insert(emp_id       => 209,
             emp_f_name   => 'Suyama',
             emp_l_name   => 'Michael',
             emp_email    => 'SMICHAEL',
             emp_p_number => '590.175.8499',
             emp_h_date   => to_date('23.10.2020','dd.mm.yyyy'),
             emp_j_id     => 'FI_ACCOUNT',
             emp_salary   => 7900,
             emp_c_pct    => null,
             emp_m_id     => 108,
             emp_dep_id   => 100);
             
end;
  



--3. Ötürülən department id-yə görə axtarln ki əgər həmin id department cədvəlində yoxdursa 
--amma departmenst-də varsa həmin dep_id -də olan işçiləri employees-dən silin və 
--employees_archive adında cədvələ insert edin (prosedur-da edilməlidir bu proseslər)








--4. Bazar günü işə qəbul olan işçilərin datasını employees_archive cədvəlinə insert edin
create or replace  procedure emp_arch_insert
as
begin
  for rec in (select * from employees where to_char(hire_date,'day')='monday   ')
  loop
    insert into employees_archive values( rec.employee_id,
                                    rec.first_name,
                                    rec.last_name,
                                    rec.email,
                                    rec.phone_number,
                                    rec.hire_date,
                                    rec.job_id,
                                    rec.salary,
                                    rec.commission_pct,
                                    rec.manager_id,
                                    rec.department_id);
    end loop;
    end;
  
  
                               
begin
emp_operations.emp_arch_insert;
end;

select * from employees_archive
--5. 1-ci bənddəki funksiya ilə eyniadlı yeni bir funksiya yaradın və burada ötürülən 
--telefon nömrəsinə görə işçinin işə qəbul tarixini ekrana çıxarın
create or replace function get_salary(emp_p_num employees.phone_number%type)
return employees.phone_number%type
is
emp_h_date employees.hire_date%type;
begin
  select e.hire_date into emp_h_date from employees e where e.phone_number=emp_p_num;
  return emp_h_date;
  end;
  
  
declare 
m_date date;
begin
m_date:= emp_operations.get_salary(emp_p_num => '590.423.4567');
  
dbms_output.put_line( m_date);
end; 


--6. İşçilərin maaşını 10000 qədər azaldın. Əgər azaltmadan alınan nəticə mənfi olursa həmin
-- işçinin datalarını loglayın

create or replace procedure emp_reduce_salary (emp_id employees.employee_id%type)
as
emp_salary employees.salary%type;
except_code varchar2(20);
except_msg varchar2 (200);
a exception;
begin
  select e.salary into emp_salary from employees e where e.employee_id=emp_id;
  
  if emp_salary<5000 then
    raise a;
    end if;
 update employees e set e.salary=emp_salary-5000 where e.employee_id=emp_id;

  exception
    when a then
      except_msg:=sqlerrm;
      except_code:=sqlcode;

      insert into error_log values (except_code,except_msg,sysdate,emp_id);
 end;





begin
emp_operations.emp_reduce_salary(emp_id => 104);  

end;



select * from employees;

select * from error_log;
