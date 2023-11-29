
--1.Create a stored procedure that uses bulk collect to fetch all the employees from the 
--"employees" table in the HR schema of the Oracle database and inserts them into a new table 
--called "employees_backup".

--1.Oracle verilənlər bazasının HR sxemindəki "işçilər" cədvəlindən bütün işçiləri əldə etmək 
--üçün bulk collect istifadə edən və onları "employees_backup" adlı yeni cədvələ daxil 
--edən saxlanılan prosedur yaradın.

create or replace noneditionable procedure p_emp
as
 TYPE e_result IS TABLE OF employees%rowtype INDEX BY PLS_INTEGER;
  e_results e_result;
begin
  SELECT *
  BULK COLLECT INTO e_results
  FROM employees;

   forall i in  e_results.first..e_results.last
  insert into employees_archive values (e_results(i).employee_id,
                                        e_results(i).first_name,
                                        e_results(i).last_name,
                                        e_results(i).email,
                                        e_results(i).phone_number,
                                        e_results(i).hire_date,
                                        e_results(i).job_id,
                                        e_results(i).salary,
                                        e_results(i).commission_pct,
                                        e_results(i).manager_id,
                                        e_results(i).department_id
                                        );

end;


begin
  p_emp;
end;


SELECT * FROM EMPLOYEES_ARCHIVE
--2.Write a PL/SQL block that uses forall to update the salary of all the employees in the 
--"employees" table in the HR schema of the Oracle database by adding 10% to their current 
--salary.

--2.Oracle verilənlər bazasının HR sxemindəki "işçilər" cədvəlindəki bütün işçilərin əmək 
--haqqını cari əmək haqqına 10% əlavə etməklə yeniləmək üçün forall-dan istifadə edən 
--PL/SQL bloku yazın.
DECLARE
TYPE E_ARRAY IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE INDEX BY PLS_INTEGER;
EMP_D E_ARRAY;

BEGIN
SELECT E.EMPLOYEE_ID BULK  COLLECT INTO EMP_D FROM EMPLOYEES E;

FORALL i IN EMP_D.FIRST .. EMP_D.LAST
UPDATE EMPLOYEES E SET SALARY=SALARY+SALARY*0.1
WHERE E.EMPLOYEE_ID=EMP_D(i);

  
END;

SELECT * FROM EMPLOYEES
--3.Create a stored procedure that uses bulk collect to fetch all the orders from the 
--"orders" table in the "sales" schema of the Oracle database where the total order amount 
--is greater than 1000 and inserts them into a new table called "high_value_orders".

--3.Ümumi sifariş məbləğinin 1000-dən çox olduğu Oracle verilənlər bazasının "satış" sxemindəki
-- "sifarişlər" cədvəlindən bütün sifarişləri əldə etmək üçün bulk collect istifadə edən 
--saxlanılan prosedur yaradın və onları "high_value_orders" adlı yeni cədvələ daxil edin.

CREATE OR REPLACE NONEDITIONABLE PROCEDURE PRO_ORD
AS
TYPE OR_D IS TABLE OF ORDERS%ROWTYPE INDEX BY PLS_INTEGER;
OR_DATA  OR_D;
BEGIN
  SELECT * BULK COLLECT INTO OR_DATA FROM ORDERS O WHERE O.PURCH_AMT>1000;

  FORALL i IN OR_DATA.FIRST .. OR_DATA.LAST
  INSERT INTO high_value_orders VALUES (OR_DATA(i).ORD_NO,
                                        OR_DATA(i).PURCH_AMT,
                                        OR_DATA(i).ORD_DATE,
                                        OR_DATA(i).CUSTOMER_ID,
                                        OR_DATA(i).SALESMAN_ID
                                        );
END;


BEGIN
  PRO_ORD;
END;


select * from high_value_orders


--4.Write a PL/SQL block that uses forall to delete all the orders in the "orders" table in 
--the "sales" schema of the Oracle database that were placed before a specific date.

--4.Müəyyən bir tarixdən əvvəl yerləşdirilən Oracle verilənlər bazasının "satış" sxemindəki 
--"sifarişlər" cədvəlindəki bütün sifarişləri silmək üçün forall-dan istifadə edən 
--PL/SQL bloku yazın.

SELECT * FROM ORDERS;

DECLARE
TYPE ORD_DEL IS TABLE OF ORDERS.ORD_NO%TYPE INDEX BY PLS_INTEGER;
ORD_DELETE ORD_DEL;
BEGIN
  
SELECT O.ORD_NO  BULK COLLECT INTO ORD_DELETE FROM ORDERS O 
WHERE O.ORD_DATE<TO_DATE('27.06.2012','dd.mm.yyyy');

FORALL i IN ORD_DELETE.FIRST .. ORD_DELETE.LAST
DELETE ORDERS O WHERE O.ORD_NO=ORD_DELETE(i);

END;


--5.Create a stored procedure that uses bulk collect to fetch all the products from the 
--"products" table in the "sales" schema of the Oracle database where the product category 
--is "Electronics" and updates their price by adding 5%.

--5.Məhsul kateqoriyasının "Elektronika" olduğu Oracle verilənlər bazasının "satış" sxemindəki 
--"məhsullar" cədvəlindən bütün məhsulları əldə etmək üçün toplu toplamadan istifadə edən 
--saxlanılan prosedur yaradın və 5% əlavə edərək onların qiymətini yeniləyin.

SELECT * FROM MALLAR


CREATE OR REPLACE PROCEDURE PRICE_INCREASE
AS
TYPE M_RESULT IS TABLE OF MALLAR.MAL_ID%TYPE INDEX BY PLS_INTEGER;
M_RESULTS M_RESULT
BEGIN
  
  SELECT M.MAL_ID BULK COLLECT INTO M_RESULTS FROM MALLAR M WHERE M.KATEQORIA_ID =
  (SELECT K.K_ID FROM KATEQORIA K WHERE K.K_NAME='et');
  
  FORALL i IN M_RESULTS.FIRST .. M_RESULTS.LAST
  UPDATE MALLAR M SET M.MAL_QIYMETI=M.MAL_QIYMETI+M.MAL_QIYMETI*0.05
  WHERE M.MAL_ID=M_RESULTS(i);
  END;
  
  
 
BEGIN
PRICE_INCREASE; 
END;

--6.Write a PL/SQL block that uses forall to update the manager ID of all the employees in 
--the "employees" table in the HR schema of the Oracle database who have a manager ID of 100 
--by setting their manager ID to 200.

--6.Oracle verilənlər bazasının HR sxemindəki "işçilər" cədvəlindəki bütün işçilərin menecer 
--ID-sini 200-ə təyin etməklə 100 menecer ID-sini yeniləmək üçün forall istifadə edən 
--PL/SQL bloku yazın.
SELECT * FROM EMPLOYEES

DECLARE 
TYPE MANAGER_E IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE INDEX BY PLS_INTEGER;
EMP_MAN MANAGER_E;

BEGIN
SELECT E.EMPLOYEE_ID BULK COLLECT INTO EMP_MAN FROM EMPLOYEES E WHERE E.MANAGER_ID=100;

FORALL i IN EMP_MAN.FIRST .. EMP_MAN.LAST
UPDATE EMPLOYEES E SET E.MANAGER_ID=200 WHERE E.EMPLOYEE_ID=EMP_MAN(i);

END;    



--7.Create a stored procedure that uses bulk collect to fetch all the orders from the 
--"orders" table in the "sales" schema of the Oracle database where the order status is 
--"Pending" and updates their status to "In Progress".

--7.Sifariş statusunun "Gözləmədədir" olduğu və onların statusunu "Davam edir" olaraq yeniləyən
-- Oracle verilənlər bazasının "satış" sxemindəki "sifarişlər" cədvəlindən bütün sifarişləri 
--əldə etmək üçün BULK COLLECT istifadə edən saxlanılan prosedur yaradın.




--8.Write a PL/SQL block that uses forall to delete all the customers in the "customers" 
--table in the "sales" schema of the Oracle database who have not placed any orders.

--8.Oracle verilənlər bazasının "satış" sxemindəki "müştərilər" cədvəlində heç bir sifariş 
--verməmiş bütün müştəriləri silmək üçün forall-dan istifadə edən PL/SQL bloku yazın.
SELECT * FROM CUSTOMER1;
SELECT * FROM ORDERS;

INSERT INTO CUSTOMER1 VALUES (1345,'HGFCVBH','BAKU',100,5003);


CREATE OR REPLACE NONEDITIONABLE PROCEDURE DEL_CUST
AS
TYPE CUST_ARRAY IS TABLE OF CUSTOMER1.CUSTOMER_ID%TYPE INDEX BY PLS_INTEGER;
CUST_IDD  CUST_ARRAY;
BEGIN
  SELECT C.CUSTOMER_ID  BULK COLLECT INTO CUST_IDD FROM CUSTOMER1 C WHERE C.CUSTOMER_ID 
  NOT IN
(SELECT O.CUSTOMER_ID FROM ORDERS O);

FORALL i IN  CUST_IDD.FIRST .. CUST_IDD.LAST
DELETE CUSTOMER1 C WHERE C.CUSTOMER_ID=CUST_IDD(i);

END;

BEGIN 
  DEL_CUST;
END;

--9.Create a stored procedure that uses bulk collect to fetch all the employees from the 
--"employees" table in the HR schema of the Oracle database who have a job title of "Manager"
-- and inserts them into a new table called "managers".

--9.Oracle verilənlər bazasının HR sxemində "Menecer" vəzifəsi olan bütün işçiləri "işçilər" 
--cədvəlindən almaq və onları "menecerlər" adlı yeni cədvələ daxil etmək üçün BULK 
--COLLECT istifadə edən saxlanılan prosedur yaradın.
SELECT * FROM MANAGER_EMP

CREATE OR REPLACE NONEDITIONABLE PROCEDURE MANAGER_T
AS
TYPE MANAGER_ARRAY IS TABLE OF EMPLOYEES%ROWTYPE INDEX BY PLS_INTEGER;
MANAGER_D MANAGER_ARRAY;

BEGIN
  
SELECT * BULK COLLECT INTO MANAGER_D FROM EMPLOYEES E 
WHERE E.EMPLOYEE_ID IN
(SELECT E1.MANAGER_ID FROM EMPLOYEES E1);

FORALL i IN MANAGER_D.FIRST .. MANAGER_D.LAST
INSERT INTO MANAGER_EMP VALUES (MANAGER_D(i).employee_id,
                                MANAGER_D(i).first_name,
                                MANAGER_D(i).last_name,
                                MANAGER_D(i).email,
                                MANAGER_D(i).phone_number,
                                MANAGER_D(i).hire_date,
                                MANAGER_D(i).job_id,
                                MANAGER_D(i).salary,
                                MANAGER_D(i).commission_pct,
                                MANAGER_D(i).manager_id,
                                MANAGER_D(i).department_id);

END;



BEGIN
 MANAGER_T; 
END;

SELECT * FROM MANAGER_EMP;
--10.Write a PL/SQL block that uses forall to update the quantity of all the products in the 
--"products" table in the "sales" schema of the Oracle database by adding 50% to their 
--current quantity.

--10.Oracle verilənlər bazasının "satış" sxemindəki "məhsullar" cədvəlindəki bütün 
--məhsulların kəmiyyətini cari kəmiyyətinə 50% əlavə etməklə yeniləmək üçün forall istifadə 
--edən PL/SQL blokunu yazın.

CREATE OR REPLACE NONEDITIONABLE PROCEDURE PRICE_INCREASE_1
AS
TYPE M_RESULT IS TABLE OF MALLAR.MAL_ID%TYPE INDEX BY PLS_INTEGER;
M_RESULTS M_RESULT;
BEGIN

  SELECT M.MAL_ID BULK COLLECT INTO M_RESULTS FROM MALLAR M;

  FORALL i IN M_RESULTS.FIRST .. M_RESULTS.LAST
  UPDATE MALLAR M SET M.MAL_QIYMETI=M.MAL_QIYMETI+M.MAL_QIYMETI*0.5
  WHERE M.MAL_ID=M_RESULTS(i);
  END;


BEGIN
  PRICE_INCREASE_1;
END;

SELECT * FROM MALLAR










