# 2/22 SQL_테이블 조인 (심화)

- 테이블 별칭을 사용하는 이유
    - SQL 명령문의 수를 줄이기 위해
    - 하나의 SELECT문 내에서 같은 테이블을 여러 번 사용하기 위해
- Oracle에서는 테이블 별칭을 붙일 때 AS를 생략한다
- 셀프조인을 통한 데이터조회가 서브쿼리보다 훨씬 빠르다
- Oracle에서 ‘열’에는 AS를 붙일 수 있다
- 자연조인 - 반복되는 열을 제거하여 각 열이 한번만 반환되는 것
- 외부조인 사용시 RIGHT나 LEFT 키워드를 명시해 어떤 테이블에 있는 행을 가져올지 지정해야 한다

```sql
select rtrim(vend_name) || ' (' || rtrim(vend_country) || ')' as vend_title
from vendors
order by vend_name;

select cust_name, cust_contact
from customers C, orders O, orderitems OI
where C.cust_id = O.cust_id
and OI.order_num = O.order_num
and prod_id = 'RGAN01';

-- Jim Jones라는 사람과 같은 회사에서 일하는 모든 직원의 메일
select cust_id, cust_name, cust_contact
from customers
where cust_name = (select cust_name
                    from customers
                    where cust_contact = 'Jim Jones')
-- 셀프조인
-- Jim Jones라는 사람과 같은 회사에서 일하는 모든 직원의 메일
select cust_id, cust_name, cust_contact
from customers
where cust_name = (select cust_name
                    from customers
                    where cust_contact = 'Jim Jones');
                    
-- 조인을 사용하면?
select c1.cust_id, c1.cust_name, c1.cust_contact
from customers c1, customers c2
where c1.cust_name = c2.cust_name and c2.cust_contact = 'Jim Jones';

-- 자연조인 
select C.*, O.order_num, O.order_date, OI.prod_id, OI.quantity, OI.item_price
from customers C, orders O, orderitems OI
where C.cust_id = O.cust_id
and OI.order_num = O.order_num
and prod_id = 'RGAN01';

-- 외부조인 - 관련이 없는 행을 가져와야 할 경우

-- 내부조인 예시
select customers.cust_id, orders.order_num
from customers inner join orders
on customers.cust_id = orders.cust_id;

-- 주문하지 않은 고객을 포함하여 모든 고객 목록
select customers.cust_id, orders.order_num
from customers left outer join orders
on customers.cust_id = orders.cust_id;

-- 그룹함수와 함께 사용
select customers.cust_id,
        count(orders.order_num) as num_ord
        from customers inner join orders on customers.cust_id = orders.cust_id
        group by customers.cust_id;
        
-- 도전과제 1
select customers.cust_name, orders.order_num
from customers join orders
on customers.cust_id = orders.cust_id;

-- 도전과제 2
select customers.cust_name, orders.order_num
from customers left outer join orders
on customers.cust_id = orders.cust_id;

-- 도전과제 3
select prod_name, order_num
from products full outer join orderitems
on products.prod_id = orderitems.prod_id
order by prod_name;

-- 도전과제 4
select products.prod_id, count(orderitems.order_num)
from products left outer join orderitems
on products.prod_id = orderitems.prod_id
group by products.prod_id;

-- 도전과제 5
select vendors.vend_id, count(prod_id)
from vendors join products
on vendors.vend_id = products.vend_id
group by vendors.vend_id;
```