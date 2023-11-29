
--1.1-dən 100-ə qədər cüt ədədlərin cəmini ekrana çıxarın
declare
  n_number number:=0;
begin 
 LOOP
 n_number:=n_number+1;
   if n_number>100 then
   exit;
   end if;
  if mod(n_number,2)!=1 then
  dbms_output.put_line(n_number);
  end if;
 end loop;
end;


--2.1-dən 5-ə  qədər ədədlər üçün ekrana 'Oracle', 6-dan 10-a qədər ədədlər üçün ekrana
--'SQL' sözünü çıxarın (exit when və if-dən istifadə edərək)
declare 
n_number number:=0;
begin 
  loop
    n_number:=n_number+1;
    if n_number>5 then
      exit;
      end if;
      dbms_output.put_line('Oracle');
      end loop;
      
  loop
    n_number:=n_number+1;
      
       if n_number>10 then
      exit;
      end if;
      dbms_output.put_line('Sql');
      end loop;
      end;
        


--3. Employees cədvəlindəki max id-ni 5-5 azaldaraq ekrana çıxarın mənfi olana qədər
declare
id_number employees.employee_id%type;
begin
select max(e.employee_id) into id_number from employees e;

while id_number>0
  loop
    dbms_output.put_line(id_number);
    id_number:=id_number-5;
    end loop;
    end;

--4. 1 və 100 aralığında 5-ə və 6-ya bölünən ədədlər üçün ekrana '5,6' və ədədin özünü,
-- 7 və 8-ə bölünən ədədlər üçün ekrana '7,8' və ədədin özünü ekrana çıxaran blok yazın
begin
  for n_number in 1 .. 100
    loop 
      if
        
      mod(n_number,5)=0 and mod(n_number,6)=0 then
      dbms_output.put_line('5,6 '||n_number);
      
      end if;
      if 
        mod(n_number,7)=0 and mod(n_number,8)=0 then
      dbms_output.put_line('7,8 '||n_number);
        end if;
      end loop;
      end;

--5. Bütün işçilərin hansı gün işə qəbul olduğunu tapın və ekrana çıxarın. 
--Əgər işçi bazar günü işə qəbul olubsa əlavə olaraq isçinin id-si və doğru deyil sözü 
--ekrana çıxsın

         














