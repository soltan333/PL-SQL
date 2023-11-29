--1. Bütün satış işçiləri haqqında bütün məlumatları əks etdirən SQL ifadəsini yazın.
select * from salesman1;

--2. "Bu, SQL İşi, Təcrübəsi və Həllidir" sətirini göstərmək üçün SQL ifadəsini yazın.
select 'This is SQL Exercise, Practice and Solution' from dual;

--3. Üç ədədi üç sütunda göstərmək üçün SQL sorğusu yazın.
select 1,2,3 from dual;

--4. RDBMS serverindən iki ədəd 10 və 15-in cəmini göstərmək üçün SQL sorğusu yazın.
select 15+10 from dual;

--5. Arifmetik ifadənin nəticəsini göstərmək üçün SQL sorğusu yazın.
select 25+10-3*5/4 from dual;

--6. Bütün satış işçiləri üçün adlar və komissiyalar kimi xüsusi sütunları göstərmək üçün 
--SQL ifadəsi yazın.
select s.name,s.commission from salesman1 s;

--7. Sifariş tarixi, satıcı ID-si, sifariş nömrəsi və bütün sifarişlər üçün satınalma 
--məbləği kimi sütunları müəyyən bir sıra ilə göstərmək üçün sorğu yazın.
select o.ord_date,o.salesman_id,o.ord_no,o.purch_amt from orders o;

--8. Aşağıdakı cədvəldən unikal satış işçiləri ID-sini müəyyən etmək üçün SQL sorğusu yazın.
-- Satıcı_id-i qaytarın.
select distinct o.salesman_id  from orders o;

--9. Aşağıdakı cədvəldən 'Paris' şəhərində yaşayan satıcıları tapmaq üçün SQL sorğusu yazın.
-- Satıcının adını, şəhərini qaytarın.
select s.name,s.city from salesman1 s where s.city='Paris';

--10. Qiyməti 200 olan müştəriləri tapmaq üçün aşağıdakı cədvəldən SQL sorğusu yazın. 
--customer_id, cust_name, city, grade, salesman_id-ni qaytarın.
select * from customer1 c where c.grade=200;

--11. Aşağıdakı cədvəldən ID ilə satıcı tərəfindən çatdırılan sifarişləri tapmaq üçün SQL 
--sorğusu yazın. 5001. Ord_no, ord_date, purch_amt qaytarın.
select o.ord_no,o.ord_date,o.purch_amt from orders o where o.salesman_id=5001;

--12. Aşağıdakı cədvəldən 1970-ci il üçün Nobel mükafatı laureat(lar)ını tapmaq üçün SQL 
--sorğusu yazın. İl, mövzu və qalibi qaytarın.
select * from nobel_win n where n.date=1970;

--13. Aşağıdakı cədvəldən 1971-ci il üçün “Ədəbiyyat” üzrə Nobel mükafatı laureatını tapmaq
-- üçün SQL sorğusu yazın. Qalibi qaytarın.
select * from nobel_win n where n.date = 1971 and n.subject='Literature';

--14. Aşağıdakı cədvəldən Nobel mükafatı laureatı “Dennis Gabor”u tapmaq üçün SQL sorğusu 
--yazın. Qayıdış ili, mövzu.
select * from nobel_win n where n.winner='Dennis Gabor';

--15. Aşağıdakı cədvəldən 1950-ci ildən “Fizika” sahəsində Nobel mükafatı laureatlarını 
--tapmaq üçün SQL sorğusu yazın. Qalibi qaytarın.
select * from nobel_win n where n.date=1950 and n.subject='Physics';

--16. Aşağıdakı cədvəldən 1965 və 1975-ci illər arasında “Kimya” üzrə Nobel Mükafatı 
--laureatlarını tapmaq üçün SQL sorğusu yazın. Başlanğıc və son dəyərlər daxil edilir. 
--İl, mövzu, qalib və ölkəni qaytarın.
select * from nobel_win n where n.date between 1965 and 1975 and n.subject='Chemistry';

--17. Menachem Begin və Yitzhak Rabin 1972-ci ildən sonra Baş Nazirlik qaliblərinin bütün 
--təfərrüatlarını göstərmək üçün SQL sorğusu yazın.
select * from nobel_win n where n.date>1972 and winner in('Menachem Begin','Yitzhak Rabin');

--18. Aşağıdakı cədvəldən adları “Louis” sətri ilə uyğun gələn qaliblərin təfərrüatlarını 
--əldə etmək üçün SQL sorğusu yazın. İl, mövzu, qalib, ölkə və kateqoriyanı qaytarın.
select * from nobel_win n where n.winner like 'Louis%';

--19. Aşağıdakı cədvəldən Fizika, 1970 və İqtisadiyyat, 1971-də qalibləri birləşdirən SQL 
--sorğusu yazın. Qayıdış ili, mövzu, qalib, ölkə və kateqoriya.
select * from nobel_win n where n.subject='Physics' and n.date=1970
union
select * from nobel_win n1 where n1.subject='Economics' and n1.date=1971;

--20. Fiziologiya və İqtisadiyyat fənləri istisna olmaqla, 1970-ci ildə Nobel Mükafatı 
--laureatlarını tapmaq üçün aşağıdakı cədvəldən SQL sorğusu yazın. 
--İl, mövzu, qalib, ölkə və kateqoriyanı qaytarın.
select * from nobel_win n where n.date=1970 and n.subject not in('Physiology','Economics');

















