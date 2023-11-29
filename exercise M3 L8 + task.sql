--1. Aşağıdakı cədvəldən qiymət dəyərləri 100-dən yuxarı olan müştərilərin təfərrüatlarını 
--tapmaq üçün SQL sorğusu yazın. Müştəri_id, müştəri_adı, şəhər, qiymət və satıcı_idini 
--qaytarın.
select * from customer1 c where c.grade>100; 

--2. Aşağıdakı cədvəldən 'Nyu York' şəhərində qiymət dəyəri 100-dən yuxarı olan bütün 
--müştəriləri tapmaq üçün SQL sorğusu yazın. customer_id, cust_name, city, grade və 
--salesman_id-ni qaytarın.
select * from customer1 c where c.city='New York' and c.grade>100;

--3. Aşağıdakı cədvəldən Nyu-York şəhərindən olan və ya qiyməti 100-dən yuxarı olan 
--müştəriləri tapmaq üçün SQL sorğusu yazın. customer_id, cust_name, city, grade və 
--salesman_id-ni qaytarın.
select * from customer1 c where c.city='New York' or c.grade>100;

--4. Aşağıdakı cədvəldən 'Nyu York' şəhərindən olan və ya qiyməti 100-dən çox olmayan 
--müştəriləri tapmaq üçün SQL sorğusu yazın. Müştəri_id, müştəri_adı, şəhər, qiymət və 
--satıcı_idini qaytarın.
select * from customer1 c where c.city='New York' or c.grade<100;

--5. Aşağıdakı cədvəldən 'Nyu York' şəhərinə aid olmayan və ya qiymət dəyəri 100-dən çox 
--olan müştəriləri müəyyən etmək üçün SQL sorğusu yazın. Müştəri_id, cust_name, şəhər, 
--qiymət və satıcı_idini qaytarın.
select * from customer1 c where c.city!='New York' or c.grade>100;

--6. Aşağıdakı cədvəldən ord_date '2012-09-10' və satıcı_id 5005-dən yuxarı və ya purch_amt
-- 1000-dən böyük olanlar istisna olmaqla bütün sifarişlərin təfərrüatlarını tapmaq üçün 
--SQL sorğusu yazın. satıcı_id.
select * from orders o where not o.ord_date=to_date('2012.09.10','yyyy.mm.dd') and
o.salesman_id>5005 or o.purch_amt>1000; 

--7. Komissiyaları 0,10 ilə 0,12 arasında dəyişən satıcıların təfərrüatlarını tapmaq üçün 
--aşağıdakı cədvəldən SQL sorğusu yazın. Satıcı_id, adı, şəhəri və komissiyanı qaytarın.
select * from salesman1 s where s.commission between 0.10 and 0.12;

--8. Aşağıdakı cədvəldən alış məbləği 200-dən az olan bütün sifarişlərin təfərrüatlarını 
--tapmaq üçün SQL sorğusu yazın və ya sifariş tarixi '2012-02-10' və ya 3009-dan az olan 
--sifarişləri istisna edin. . Ord_no, purch_amt, ord_date, customer_id və salesman_id-i 
--qaytarın.
select * from orders o where  o.purch_amt<200 
or not o.ord_date=to_date('2012.02.10','yyyy.mm.dd') or o.customer_id<3009;

--9. Aşağıdakı cədvəldən aşağıdakı şərtlərə cavab verən bütün sifarişləri tapmaq üçün SQL 
--sorğusu yazın. '2012-08-17'-ə bərabər olan sifariş tarixi və ya 3005-dən çox müştəri ID 
--və 1000-dən az alış məbləği birləşmələrini istisna edin.
select * from orders o where not ((o.ord_date=to_date('2012.08.17','yyyy.mm.dd') 
or o.customer_id>3005) and o.purch_amt<1000);

--10. 6000 hədəf dəyərinin 50%-dən çox olan sifarişlər üçün sifariş nömrəsini, alış 
--məbləğini və əldə edilmiş və əldə olunmamış faizi (%) göstərən SQL sorğusu yazın.
select o.ord_no,o.purch_amt from orders o where o.purch_amt>6000*0.5; 























