--SOLTAN
--1.Her gun saat 5-de employees cedvelindeki datalari silen job yaradin
CREATE OR REPLACE PROCEDURE DEL_EMP
AS
BEGIN
  DELETE EMPLOYEES;
END;


BEGIN
  DEL_EMP;
END;


BEGIN
  DBMS_SCHEDULER.CREATE_JOB(job_name            => 'DELETE_EMP_DATA',
                            job_type            => 'PLSQL_BLOCK',
                            job_action          => 'BEGIN DEL_EMP; END;',
                            repeat_interval     => 'FREQ=DAILY;BYHOUR=08;ByMinute=30',
                            enabled             => TRUE,
                            auto_drop           => FALSE,
                            comments            => 'THIS JOB DELETE EMPLOYEES DATA');
END;


SELECT TO_DATE('09,05','HH.MM') FROM DUAL;
--2. Hemin jobu disable edin

BEGIN
 DBMS_SCHEDULER.disable(job_name         => 'DELETE_EMP_DATA');
END;

--3. Jobun cari statusuna baxin (user_scheduler_jobs-dan istifade ederek ozunuz arasdirin)


select * from user_scheduler_jobs where job_name='DELETE_EMP_DATA';

--4. Test1 ve Test2 adli eyni mentiqli cedvel yaradin. Bu cedvellerde datalar eyni olmalidir.
--Her deqiqe ise dusen ve cedvellerde ferqli datalar varsa onlari eynilesdiren job yaradin
--(prosedurda merge lazim ve ya set operatorlari olacaq)
select * from test2

create or replace noneditionable procedure merg_data
as
begin

  merge into test1 t
  using test2 t1
  on (t.id=t1.id) 
  when matched then
    update set t.name=t1.name
    when not matched then
      insert values (t1.id,t1.name);

  merge into test2 t
  using test1 t1
  on (t.id=t1.id) 
  when matched then
    update set t.name=t1.name
    when not matched then
      insert values (t1.id,t1.name);
end;



select * from test1;
select * from test2;

begin
  
DBMS_SCHEDULER.CREATE_JOB(job_name            => 'insert_tests',
                          job_type            => 'plsql_block',
                          job_action          => 'begin merg_data; commit; end;',
                          repeat_interval     => 'FREQ=minutely; INTERVAL=1;',
                          enabled             => true,
                          auto_drop           => false,
                          comments            => 'merge tables');
end;







--5. Her gun saat 9-da azn valutasina uygun mezenneleri insert eden job yaradin
CREATE TABLE DAILY_VAL (VALYUTA VARCHAR2(20),
                        MEZENNE NUMBER,
                        TARIX DATE);

SELECT * FROM DAILY_VAL

CREATE OR REPLACE PROCEDURE INS_VAL_DATA
AS
BEGIN
  INSERT INTO DAILY_VAL VALUES('USD',1.7,SYSDATE);
  INSERT INTO DAILY_VAL VALUES('EUR',1.8,SYSDATE);
  INSERT INTO DAILY_VAL VALUES('RUB',0.0236,SYSDATE);
  INSERT INTO DAILY_VAL VALUES(NULL,NULL,NULL);
END;

BEGIN
  INS_VAL_DATA;
  COMMIT;
END;

BEGIN
  DBMS_SCHEDULER.CREATE_JOB(job_name            => 'INSERT_DAILY_VAL',
                            job_type            => 'PLSQL_BLOCK',
                            job_action          => 'BEGIN INS_VAL_DATA; COMMIT; END;',
                            repeat_interval     => 'FREQ=DAILY; INTERVAL=1; BYHOUR=00',
                            enabled             => TRUE,
                            auto_drop           => FALSE,
                            comments            => 'THIS JOB INSERTS VALYUTA DATA DAILY');
END;


--6. Her gun verilen gunun heftenin hansi gunu oldugunu insert eden job yaradin
CREATE TABLE WEEK_DAYS (W_DAY VARCHAR2 (30));

SELECT * FROM WEEK_DAYS;

BEGIN
  DBMS_SCHEDULER.CREATE_JOB(job_name            => 'INSERT_DAY_NAME',
                            job_type            => 'PLSQL_BLOCK',
                            job_action          => 'BEGIN INS_DAY; COMMIT; END;',
                            repeat_interval     => 'FREQ=DAILY; INTERVAL=1',
                            enabled             => TRUE,
                            auto_drop           => FALSE,
                            comments            => 'THIS JOB INSERTS WEEK DAYS');
END;



--------------------------------------- for update-----------------

