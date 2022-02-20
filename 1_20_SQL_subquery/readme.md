# 2/20 SQL_Sub_Query

- 서브쿼리는 항상 안에 있는 쿼리를 먼저 처리하고, 그 다음 바깥 쪽에 있는 쿼리를 처리한다. → 실제로 두번의 작업을 수행한다.
- 너무 많은 서브쿼리는 성능을 저하시킨다
- 서브쿼리는 하나의 열만 검색할 수 있다.

```sql
select order_num
from orderitems
where prod_id = 'RGAN01';

// RGAN01이라는 제품을 구매한 고객 목록
SELECT cust_id
from orders
where order_num in (select order_num from orderitems where prod_id = 'RGAN01');

// RGAN01이라는 제품을 구매한 고객의 정보

SELECT cust_name, cust_contact
from customers
where cust_id in (
                SELECT cust_id 
                from orders 
                where order_num in (select order_num 
                                    from orderitems 
                                    where prod_id = 'RGAN01'));

// 고객별 주문 수량
select cust_name,
        cust_state,
        (select count(*)
        from orders
        where orders.cust_id = customers.cust_id) as orders
from customers
order by cust_name;

// 도전과제 1
select cust_id
from orders
where order_num in (select ORDER_NUM from orderitems where item_price >= 10);

// 도전 과제2
select cust_id, order_date
from orders
where order_num in (select order_num from orderitems where prod_id = 'BR01')
order by order_date;

// 도전 과제3
select cust_email
from customers
where cust_id in (select cust_id
                from orders
                where order_num in (select order_num 
                                    from orderitems 
                                    where prod_id = 'BR01'));
                                    
// 도전과제 4
select cust_id,
        (select sum(item_price*quantity)
        from orderitems
        where orders.order_num = orderitems.order_num) as total_ordered
from orders
order by total_ordered desc;
```