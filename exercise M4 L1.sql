--1. Ötürülən 2 ədəddən hansının böyük olduğunu ekrana çıxaran funksiya yazın
create or replace function get_number(number_1 number,number_2 number)
return number
is
r_result number;


begin
if number_1>number_2 then
  
  r_result:=number_1;
  return r_result;
  else
    r_result:=number_2;
    return r_result;
   
    end if;
    end;
    
select get_number(number_1 => &a, number_2 =>&b ) from dual;
  

--2. valutaları və məzənnələri göstərən cədvəl yaradın. Ötürülən tarixdə ötürülən valutanın 
--azn-ə uyğun məzənnəsini çıxarın
create table valyuta_m (valyuta varchar2(20),
                        mezenne number);

insert into valyuta_m values ('USD',1.70);
insert into valyuta_m values ('EUR',1.80);
insert into valyuta_m values ('RUB',0.0236);
insert into valyuta_m values ('GBP',2.05);


create or replace noneditionable function val_m 
(val_name valyuta_m.valyuta%type , cash number)
return number
is
r_result number;

begin
for rec in(select * from valyuta_m v where v.valyuta=val_name)
loop
  
  r_result:=cash*rec.mezenne;
  end loop;
  return r_result;
    end;
    
    
select val_m(val_name => 'USD', cash =>100 ) FROM DUAL;
    


--3. İş günlərini özündə saxlayan cədvəl yaradın. Bu cədvəli prosedur vasitəsilə doldurun. 
--Əgər ötürülən tarix sysdate-dən kiçikdirsə ekrana error qaytarın
create table work_days (dates date,
                        w_h varchar2(20));
select * from work_days;



create or replace noneditionable procedure p_data (tarix date,gunler work_days.w_h%type)
as
c exception;
begin
  if tarix<sysdate then
    raise c;
    end if;
  insert into work_days values(tarix,gunler);

  exception when c then
    dbms_output.put_line('Yanlish tarix');
    end;
  
begin
    p_data(tarix =>to_date('07.12.2023','dd.mm.yyyy'), gunler =>'Work' );
end;

begin
    p_data(tarix =>to_date('03.12.2023','dd.mm.yyyy'), gunler =>'Holiday' );
end;


--4. 3-cü taskdakı datanı çəkmək üçün funksiya yaradın. Yəni tarix ötürün və bu tarixin iş 
--günü olub olmaması nəticəsini ekrana çıxarın
--Əgər ötürülən tarix cədvəldə yoxdursa ekrana tarix tapılmadı errorunu çıxarın

create or replace  function get_data(g_date date)
return work_days.w_h%type
is
days work_days.w_h%type;
begin
  select a.w_h into days from work_days a where a.dates = g_date;
  return days;

  end;


declare
r_result varchar2(20);
begin
  r_result:=get_data(to_date('01.12.2023','dd.mm.yyyy'));
  dbms_output.put_line(r_result);
  exception when 
   no_data_found then
   dbms_output.put_line('Tarix tapilmadi');
 
  end;
  










