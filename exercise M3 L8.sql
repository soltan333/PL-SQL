--1. Ötürülən id-li işçinin maaşını ekrana çıxaran blok yazın. 
--Əgər həmin işçi mövcud deyilsə ekrana işçi tapılmadı mesajını çıxarın
declare
a number;

begin
for emp in (select * from employees)
  
 loop
   if 
   emp.employee_id=&a
   then
     dbms_output.put_line(emp.salary);
   end if;
   end loop;
 exception
   when others
  then
dbms_output.put_line ('Data tapilmadi');

 end;
 
 
 
declare
a number;
b number;
begin
  
  select e.salary into b from employees e  where e.employee_id=&a;
  
  dbms_output.put_line(b);
   exception
   when others
  then
dbms_output.put_line ('işçi tapılmadı');
  end;


--2. Ötürülən faiz qədər işçinin maaşını azaldın. Əgər faiz olaraq 100 qeyd edilibsə onda 
--ekrana maaş sıfırlana bilməz errorunu çıxarın
declare 
a number;
b number;
c exception;
maash number;
faiz number;
begin
  select e.salary into maash from employees e where e.employee_id=100; 
  faiz := &a;
  b:=maash-(faiz*maash/100);
  
  
  if faiz=100 then
    raise c;
    end if;
  dbms_output.put_line(b);
exception when c then
  dbms_output.put_line('maaş sıfırlana bilmez');

  end;

--3. Ötürülən id-li işçini silən blok yazın. Əgər id 1-10 aralığındadırsa ekrana bu işçi 
--silinə bilməz errorunu çıxarın
declare
a number;
b number;
c exception;

begin
 b:=&a;
 if b between 100 and 110 then
   raise c;
   end if;
   delete from employees e where e.employee_id=b;
exception
  when c then
    dbms_output.put_line('bu işçi siline bilmez');

end;


--4. Departments cedveli yaradin. Bu cedvele mueyyen bir data insert edin. 
--Eger insert etdiyiniz id ve ya adda departament movcuddursa insert edilmesine icazə 
--verməyin və log cedveli yaradib ora hemin id-ni ve ya adi insert edin

  



--5. Eger koddan too_many_rows erroru yaranma ehtimali varsa onda hemin halda setirlerin 
--sayi coxdur mesaji cixarin
