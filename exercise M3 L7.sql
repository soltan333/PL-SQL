--1. 1-dən 100-ə qədər 5-ə bölünməyən ədədlərin cəmini tapın\
declare
n_num number;
n_sum number:=0;

begin
  for n_num in 1 .. 100
loop
  
if mod(n_num,5)!=0 then
  
n_sum:=n_sum+n_num;
 end if;
end loop;
dbms_output.put_line(n_sum);
end;

--2. Hər şöbədəki işçilərin mail adreslərini ekrana çıxarın (Yuxarıda şöbə adı qeyd edilməlidir)
select * from employees;


begin
  for emp in (select distinct e.department_id from employees e)
loop
  dbms_output.put_line (emp.department_id);
  for emp1 in(select e1.email from employees e1 where e1.department_id = emp.department_id )
  loop
  dbms_output.put_line(emp1.email);
  end loop;
  end loop;
end;

--3. Employee cədvəlindəki işçilərin maaşı 1000- den asagidirsa orta emekhaqqi,
--eks halda yuksek emekhaqqi cumlesini ve maasin ozunu və işçinin adını ekrana cixaran 
--blok yazmaq (case vasitesile)
declare
avg_salary employees.salary%type;
begin
  select avg(salary) into avg_salary from employees;  
  
for emp_d in (select e.first_name,e.salary from employees e)
  loop
case
  when emp_d.salary<5000 then
    dbms_output.put_line(avg_salary);
    else
      dbms_output.put_line('Yuksek maas '|| emp_d.salary ||' '||emp_d.first_name);
end case;
  end loop;
end;
select * from employees;
--4. Ilk 100 Fibonacci ededini cixaran PL/SQL bloku yazin
declare
n_f number:=0;
n_num number;
begin 
n_num:=100; 
while n_num>0
  loop
    n_f:=n_f+n_num;
    n_num:= n_num-1;
    
  end loop;
  dbms_output.put_line(n_f); 
end;

--5. Oturulen ededin faktorialini tapan PL/SQL bloku yazin
declare
n_faktorial number:=1;
n_num number;
begin 
n_num := 7;
while n_num>0
  loop
    n_faktorial:=n_num*n_faktorial;
    n_num:=n_num-1; 
  end loop;
  dbms_output.put_line(n_faktorial) ; 
end;
