--Soltan
--1)employee tablesinin butun ID lerini her hansi arraya menimsederek idleri bir bir alt-alta 
--ekranan cixardan blok yazmaq


--2) EDEDLER ADLI array elan edib arraya 10 eded menimsetmek ve arrayin 2 e bolunen 
--elementlerini ve qarsisinda cut sozunu ,2 e bolunmeyen elementlerinin qarsisinda ededin ozu
--ve tek sozunu yazraraq butun elementleri ekrana vermek
DECLARE
TYPE EDEDLER IS VARRAY(10) OF NUMBER;
LOC EDEDLER;
L_ID NUMBER;
BEGIN
  LOC:=EDEDLER(11,12,13,14,15,16,17,18,19,20);
  L_ID:=LOC.FIRST;
  
  WHILE L_ID IS NOT NULL
    
   LOOP
      IF MOD(LOC(L_ID),2)=0 THEN
   DBMS_OUTPUT.PUT_LINE('CUT '||LOC(L_ID));
   
  ELSE
   DBMS_OUTPUT.PUT_LINE('TEK '||LOC(L_ID));
   END IF;
   L_ID:= LOC.NEXT(L_ID);
   END LOOP;
  END;
  

--3)array elan etmek ve item menimsetmek 5 eded.Arrayin elementlerini loopdan istifade ederek 
--en sonuncudan evvele dogru ekrana vermek
DECLARE
TYPE EDEDLER IS VARRAY(5) OF NUMBER;
LOC EDEDLER;
L_ID NUMBER;
BEGIN
  LOC:=EDEDLER(1,2,3,4,5);
  L_ID:=LOC.LAST;
  
  WHILE L_ID>0
  LOOP
   DBMS_OUTPUT.PUT_LINE(LOC(L_ID));
   L_ID:=L_ID-1;
   END LOOP;
   END;   
  


--4)First ve lastdan istifade ederek 3 elementli  ixtiyari arrayin elementlerini capa vermek



--5)ozunde 5 proqramlasdirma dilinin adini saxlayan array elan etmeli ve sonra arrayi iki defe
-- extend ederek 7 elementli hala getirib ekrana cixartmaq
DECLARE
TYPE DİLLER IS VARRAY(7) OF VARCHAR2(20);
LOC DİLLER;
L_ID NUMBER;

BEGIN
  LOC:=DİLLER('PYTHON','JAVA','JAVASCRIPT','C#','C/C++');

LOC.EXTEND(2);
LOC(6):='SWIFT';
LOC(7):='PHP';

L_ID:=LOC.FIRST;
WHILE L_ID IS NOT NULL
  LOOP
    DBMS_OUTPUT.PUT_LINE(LOC(L_ID));
    L_ID:= LOC.NEXT(L_ID);
  
END LOOP;
END;


--6)ozunde 3 SQL objecttiin adini saxlayan array elan edib arrayin 3 cu elementini silmek ve 
--diger iki elementi capa vermek (varray-dan istifade ederek)
DECLARE
TYPE L_NAME IS VARRAY(3) OF VARCHAR2 (20);
LOC L_NAME;
L_ID NUMBER;
BEGIN

LOC:=L_NAME('Steven','Neena','Alexander');

L_ID:=LOC.FIRST;

LOC.TRIM(L_ID);

WHILE L_ID IS NOT NULL
LOOP
 DBMS_OUTPUT.PUT_LINE(LOC(L_ID));
 L_ID:= LOC.NEXT(L_ID);
 END LOOP;
 END;






























