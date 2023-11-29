--1.Create a cursor to fetch all the employees from the "employees" table in the HR schema of 
--the Oracle database.
--1.Oracle verilənlər bazasının HR sxemindəki "işçilər" cədvəlindən bütün işçiləri gətirmək 
--üçün kursor yaradın.
DECLARE 
CURSOR C_EMP IS SELECT * FROM EMPLOYEES;
CUR_EMP C_EMP%ROWTYPE;
BEGIN
  OPEN C_EMP;
  LOOP
  FETCH C_EMP INTO CUR_EMP;
  
  EXIT WHEN C_EMP%NOTFOUND;
  
  DBMS_OUTPUT.PUT_LINE(CUR_EMP.EMPLOYEE_ID ||' '||CUR_EMP.FIRST_NAME ||' '||CUR_EMP.LAST_NAME);
  
  END LOOP;
  CLOSE C_EMP;
  END;



--2.Create a cursor to fetch all the departments from the "departments" table in the HR schema 
--of the Oracle database where the location is "New York".
--2. Oracle verilənlər bazasının HR sxemindəki "departamentlər" cədvəlindən bütün şöbələri 
--əldə etmək üçün kursor yaradın, burada yer "Nyu York"dur.
DECLARE
CURSOR C_DEP IS SELECT * FROM DEPARTMENTS WHERE LOCATION_ID IN(SELECT l.location_id FROM LOCATIONS l WHERE CITY='Tokyo');
CUR_DEP C_DEP%ROWTYPE;
BEGIN
OPEN C_DEP;
LOOP
FETCH C_DEP INTO CUR_DEP;
EXIT WHEN C_DEP%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(CUR_DEP.DEPARTMENT_ID);
END LOOP;

CLOSE C_DEP;
END;



--3.Create a cursor to fetch all the employees from the "employees" table in the HR schema of 
--the Oracle database where the salary is between 5000 and 10000.
--3. Əmək haqqının 5000 ilə 10000 arasında olduğu Oracle verilənlər bazasının HR sxemindəki 
--"işçilər" cədvəlindən bütün işçiləri gətirmək üçün kursor yaradın.
DECLARE 
CURSOR C_EMP IS SELECT * FROM EMPLOYEES E WHERE E.SALARY BETWEEN 5000 AND 10000;
CURS_EMP C_EMP%ROWTYPE;
BEGIN
  OPEN C_EMP;
  LOOP
    
 FETCH C_EMP INTO CURS_EMP;
 EXIT WHEN C_EMP%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE(CURS_EMP.EMPLOYEE_ID ||' '||CURS_EMP.FIRST_NAME ||' '||CURS_EMP.LAST_NAME ||' '||CURS_EMP.SALARY);
 END LOOP;
 CLOSE C_EMP;
 END;


--4.Use a cursor to fetch all the products from the "products" table in the "OE" schema of the 
--Oracle database where the product category is "Electronics".
--4. Məhsul kateqoriyasının "Elektronika" olduğu Oracle verilənlər bazasının "OE" sxemindəki 
--"məhsullar" cədvəlindən bütün məhsulları almaq üçün kursordan istifadə edin.
select * from mallar
SELECT * FROM KATEQORIA

DECLARE
CURSOR C_PROD IS SELECT * FROM MALLAR M WHERE M.KATEQORIA_ID IN 
(SELECT K.K_ID FROM KATEQORIA K WHERE K.K_NAME='et');
CUR_PROD C_PROD%ROWTYPE;
BEGIN
  OPEN C_PROD;
  LOOP
    FETCH C_PROD INTO CUR_PROD;
    EXIT WHEN C_PROD%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(CUR_PROD.MAL_NAME);
    END LOOP;
    CLOSE C_PROD;
    END;


--5.Create a stored procedure that takes a department ID as input parameter and returns a 
--SYS_REFCURSOR containing all the employees in that department.

--5. Şöbənin identifikatorunu giriş parametri kimi qəbul edən və həmin şöbənin bütün 
--işçilərini ehtiva edən SYS_REFCURSOR qaytaran saxlanılan prosedur yaradın.

CREATE OR REPLACE NONEDITIONABLE PROCEDURE PRO_EMP (P_DEP_ID EMPLOYEES.DEPARTMENT_ID%TYPE,
                                                    CURSOR_EMP OUT  SYS_REFCURSOR )
AS
BEGIN
  OPEN CURSOR_EMP FOR
  SELECT E.EMPLOYEE_ID,
         E.FIRST_NAME,
         E.LAST_NAME,
         E.EMAIL FROM EMPLOYEES E WHERE E.DEPARTMENT_ID= P_DEP_ID;

  END;
  
  


DECLARE
CURSOR_EMP1  SYS_REFCURSOR;
emp_a employees%rowtype;

BEGIN 
PRO_EMP(P_DEP_ID => 90,CURSOR_EMP => CURSOR_EMP1 );

DBMS_OUTPUT.PUT_LINE(CURSOR_EMP1);
  LOOP
    FETCH
    CURSOR_EMP1 INTO emp_a;
    EXIT WHEN CURSOR_EMP1%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(emp_a.employee_id);
    
     END LOOP;
     CLOSE CURSOR_EMP1; 


END;



--6.Create a function that takes a customer ID as input parameter and returns a 
--SYS_REFCURSOR containing all the orders placed by that customer.
--6. Müştəri identifikatorunu giriş parametri kimi qəbul edən və həmin müştərinin verdiyi 
--bütün sifarişləri ehtiva edən SYS_REFCURSOR qaytaran funksiya yaradın.


CREATE OR REPLACE FUNCTION F_EMP_C (C_ID CUSTOMER1.CUSTOMER_ID%TYPE)
RETURN SYS_REFCURSOR
AS 
C_COSTUMER SYS_REFCURSOR;
BEGIN
  OPEN C_COSTUMER FOR
  SELECT C.CUSTOMER_ID,
         C.CUST_NAME,
         C.CITY,
         C.GRADE,
         C.SALESMAN_ID FROM CUSTOMER1 C WHERE C.CUSTOMER_ID= C_ID;
  RETURN C_COSTUMER;
  END;
  
  
DECLARE 
C_COSTUMER SYS_REFCURSOR;
L_ID CUSTOMER1.CUSTOMER_ID%TYPE;
L_NAME CUSTOMER1.CUST_NAME%TYPE;
L_CITY CUSTOMER1.CITY%TYPE;
L_GRADE CUSTOMER1.GRADE%TYPE;
L_SMAN CUSTOMER1.SALESMAN_ID%TYPE;
BEGIN
  C_COSTUMER:=F_EMP_C(C_ID => 3001);
  LOOP
    FETCH
    C_COSTUMER INTO L_ID, L_NAME,L_CITY,L_GRADE,L_SMAN;
    EXIT WHEN C_COSTUMER%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(L_ID||' '|| L_NAME||' '||L_CITY||' '||L_GRADE||' '||L_SMAN);
     END LOOP;
     CLOSE C_COSTUMER;
END;
        
  

--7.Write a PL/SQL block that declares a SYS_REFCURSOR variable and uses it to fetch all the 
--departments from the HR schema of the Oracle database.
--7.SYS_REFCURSOR dəyişənini elan edən və Oracle verilənlər bazasının HR sxemindən bütün 
--şöbələri əldə etmək üçün ondan istifadə edən PL/SQL blokunu yazın.
DECLARE
C_DEP SYS_REFCURSOR;
DEP_ID NUMBER;
BEGIN
OPEN C_DEP FOR
SELECT D.DEPARTMENT_ID FROM DEPARTMENTS D;
LOOP
  FETCH C_DEP INTO DEP_ID;
  EXIT 
  WHEN C_DEP%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(DEP_ID);
  END LOOP;

  END;

--8.Write a PL/SQL block that declares a SYS_REFCURSOR variable and uses it to fetch all the 
--employees from the "employees" table in the HR schema of the Oracle database where the 
--salary is greater than 10000.
--8. SYS_REFCURSOR dəyişənini elan edən və əmək haqqının 10000-dən çox olduğu Oracle 
--verilənlər bazasının HR sxemindəki "işçilər" cədvəlindən bütün işçiləri götürmək üçün 
--istifadə edən PL/SQL blokunu yazın.
DECLARE
EMP_1 SYS_REFCURSOR;
emp_a employees%rowtype;

BEGIN
  OPEN EMP_1 
  FOR SELECT * FROM EMPLOYEES E WHERE E.SALARY>10000;
  LOOP
    FETCH EMP_1 INTO emp_a;
    EXIT WHEN EMP_1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(emp_a.employee_id);
    END LOOP;
  
END;





--9.Write a PL/SQL block that uses a cursor to retrieve the data from the "orders" table.
--For each row in the cursor, update the "total_amount" column to be 10% higher than its 
--current value.
--9. "Sifarişlər" cədvəlindən məlumatları əldə etmək üçün kursordan istifadə edən 
--PL/SQL blokunu yazın.Kursordakı hər bir sıra üçün "ümumi_məbləğ" sütununu cari dəyərindən 
--10% yüksək olaraq yeniləyin.
SELECT * FROM ORDERS;

DECLARE
CURSOR ORD_C IS SELECT * FROM ORDERS;
ORD_CURSOR ORD_C%ROWTYPE;
BEGIN
  OPEN ORD_C;
  LOOP
  FETCH ORD_C INTO ORD_CURSOR;
  EXIT WHEN  ORD_C%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(ORD_CURSOR.ORD_NO|| ' ' ||ORD_CURSOR.PURCH_AMT);
   ORD_CURSOR.PURCH_AMT:= ORD_CURSOR.PURCH_AMT*1.1; 
   DBMS_OUTPUT.PUT_LINE('new'|| ' ' ||ORD_CURSOR.ORD_NO|| ' ' ||ORD_CURSOR.PURCH_AMT);
  END LOOP;
  CLOSE ORD_C;
  END;










