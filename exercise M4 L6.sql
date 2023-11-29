--1.Ötürülən tarixdəki  ilin leap year olub olmadığını ekrana çıxarın və əgər leap yeardırsa 
--həmin ildəki bazar günlərinin sayını ekrana çıxarın








--2.1-9999 a qədər olan ədədlər icərisində rəqəmlərin cəmi 9 olan ədədlərin cəmini tapın
DECLARE
N_NUM NUMBER;
N_SUM NUMBER;
SUM_NUMBER NUMBER:=0;
BEGIN

FOR NUMB IN 1..9999
  LOOP
    
    N_NUM:=NUMB;
    N_SUM:=0;
    WHILE N_NUM>0
      
      LOOP
    
    N_SUM:=N_SUM+ MOD(N_NUM,10);
    N_NUM:=TRUNC(N_NUM/10);
    
END LOOP;

      IF N_SUM=9 THEN
      SUM_NUMBER:=SUM_NUMBER+NUMB;
      END IF;
 
      END LOOP;

 DBMS_OUTPUT.PUT_LINE(SUM_NUMBER);
END;


--3.Isciler cedvelinde iscilerin ise qebul tarixi ile bu gunku tarix arasinda olan
--illerin siyahisini ekrana cixarin (meselen isci 2010-da ise qebul olubsa ekrana
 --2011 2012 2013..2020)
 
DECLARE
DATE_E NUMBER;
N_NUM NUMBER;
BEGIN  
  
 FOR REC IN (SELECT E.FIRST_NAME, EXTRACT(YEAR FROM E.HIRE_DATE) A FROM EMPLOYEES E )
   LOOP
  DBMS_OUTPUT.PUT_LINE('--'||REC.FIRST_NAME); 
     FOR N_NUM IN REC.A .. 2023
     LOOP
     
       
DBMS_OUTPUT.PUT_LINE(N_NUM);
END LOOP;
END LOOP;
END; 


--4. * * *
--    * *
--     *  verilen neticeni cixaran kod yazin (3 daxil edilib)

















