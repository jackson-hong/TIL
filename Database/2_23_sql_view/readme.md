# 2/23 SQL in 10 mins

Date: February 23, 2022 5:20 AM

- 뷰는 가상 테이블이다. 테이블을 가진 테이블과는 달리, 뷰는 사용될 때 동적으로 데이터를 가져오는 쿼리들을 담고 있을 뿐이다.
- 뷰를 사용하는 이유
    - SQL 문을 재사용하기 위해
    - 복잡한 SQL 작업을 단순화하기 위해
    - 완전한 테이블이 아니라 테이블의 일부만을 노출하기 위해서
    - 데이터를 보호하기 위해
    - 테이터 형식을 변경하기 위해
- 뷰는 사용할 때마다 쿼리를 실행시키기 때문에 여러겹의 뷰를 생성한다면 성능은 저하된다

```sql
-- create view productcustomers as
-- select cust_name, cust_contact, prod_id
-- from customers C, orders O, orderitems OI
-- where C.cust_id = O.cust_id
-- and OI.order_num = O.order_num;

select cust_name, cust_contact
from productcustomers
where prod_id = 'RGAN01';

-- create view vendorlocation as
-- select rtrim(vend_name) || ' (' || rtrim(vend_country) || ')'
-- as vend_title
-- from vendors;

select * from vendorlocation;

-- 도전과제 1
-- create view as CustomersWithOrders
-- select customers.*
-- from customers join orders on customers.cust_id = orders.cust_id;
```

: JPA에서도 뷰를 이용할 수 있다..!