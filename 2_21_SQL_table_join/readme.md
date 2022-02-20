# 2/21 SQL_테이블 조인

- 관계형 데이터베이스가 비관계형 데이터베이스보다 확장성이 훨씬 좋다
- 대부분 DBMS는 모호한 쿼리의 경우 완전한 열 이름을 쓰지 않으면 에러가 발생한다
- 카티전 곱 : 조인 조건 없이 테이블 관계에 의해 반환된 결과
- Inner join = Equi join
- 불필요한 테이블을 조인하는 경우 성능이 저하될 수 있다

```sql
-- equi join
select vend_name, prod_name, prod_price
from vendors, products
where vendors.vend_id = products.vend_id;

-- 올바른 inner join
select vend_name, prod_name, prod_price
from vendors inner join products
on vendors.vend_id = products.vend_id;

select prod_name, vend_name, prod_price, quantity
from orderitems, products, vendors
where products.vend_id = vendors.vend_id
and orderitems.prod_id = products.prod_id
and order_num = 20007;

select cust_name, cust_contact
from customers, orders, orderitems
where customers.cust_id = orders.cust_id
and orderitems.order_num = orders.order_num
and prod_id = 'RGAN01';

-- 도전과제 1, 2
select customers.cust_name, orders.order_num, orderitems.item_price*orderitems.quantity as order_total
from customers, orders, orderitems
where customers.cust_id = orders.cust_id
and orders.order_num = orderitems.order_num
order by cust_name, order_num;

-- 도전과제 3
select cust_id, order_date
from orders
where order_num in (select order_num from orderitems where prod_id = 'BR01')
order by order_date;
-- 같은 결과 내기
select cust_id, order_date
from orders, orderitems
where orders.order_num = orderitems.order_num
and prod_id = 'BR01'
order by order_date;

-- 도전과제 4
select cust_email
from customers
where cust_id in (select cust_id
                from orders
                where order_num in (select order_num 
                                    from orderitems 
                                    where prod_id = 'BR01'));
-- 같은 결과 내기
select cust_email
from orders, orderitems, customers
where orders.order_num = orderitems.order_num
and customers.cust_id = orders.cust_id
and prod_id = 'BR01'
order by order_date;

-- 도전과제 5
select order_num, sum(quantity*item_price) as total_price
from orderitems
group by order_num
having sum(quantity*item_price) >= 1000
order by order_num;

select cust_name, sum(quantity*item_price) as total_price
from customers, orders, orderitems
where customers.cust_id = orders.cust_id
and orders.order_num = orderitems.order_num
having sum(quantity*item_price) >= 1000
group by cust_name
order by cust_name;
```