# 2/18 SQL in 10 Minutes

> JPA 덕분에 흐릿해진 나의 쿼리 실력을 다시 올려보자.
> 
- 내림차순 - Top to Down - DESC
- DESC 키워드는 명시된 열에만 적용된다 - 나머지는 자동으로 ASC
- 와일드 카드와 LIKE는 한몸이다
- ‘%’ 와일드 카드는 임의의 수(**0~**)의 문자를 의미한다
- 일부 DBMS는 열을 공백으로 채운다 50개의 문자를 넣을 수 있는 열에 길이가 17인 열을 저장하면 열을 채우기 위해 33개의 공백이 추가될 수 있다
    
    → ‘F%y’ 와 같이 y로 끝나는 문자열을 찾으려고 했으나 실제로는 공백때문에 조회가 되지 않는 경우가 있음 
    
    → 이런경우 ‘F%y%’와 와일드카드를 추가해준다
    
- **와일드카드 검색은 시간이 오래 걸린다**
- **계산된 필드로 조회하는 경우 어플리케이션에서 수행하는 것보다 훨씬 빠르다**

**p.34 도전 과제**

```sql
1. 
SELECT CUST_NAMES 
FROM CUSTOMERS
ORDER BY CUST_NAMES DESC
```

```sql
2.
SELECT CUST_ID, ORDER_NUM
FROM ORDERS
ORDER BY CUST_ID, ORDER_NUM DESC
```

```sql
3.
SELECT ITEM_AMOUNT, ITEM_PRICE
FROM ORDER_ITEMS
ORDER BY ITEM_AMOUNT DESC, ITEM_PRICE DESC
```

**P.42 도전과제**

```sql
1.
SELECT PROD_ID, PROD_NAME
FROM PRODUCTS
WHERE PROD_PRICE == 9.49
```

```sql
2.
SELECT PRODUCT_ID, PRD_NAME
FROM PRODUCTS
WHERE PROD_PRICE >= 9
```

```sql
3.
SELECT DISTINCT ORDER_NUM
FROM ORDERITEMS
WHERE ORDER_AMOUNT >= 100
```

```sql
4. SELECT PROD_NAME, PROD_PRICE
FROM PRODUCTS
WHERE PROD_PRICE >= 3 AND PROD_PRICE <= 6
ORDER BY PROD_PRICE
```

P.61 도전과제

```sql
1.
select prod_name, prod_desc 
from products 
where prod_desc like '%toy%';
```

```sql
2.
select prod_name, prod_desc 
from products 
where prod_desc not like '%toy%';
```

```sql
3.
select prod_name, prod_desc 
from products 
where prod_desc like '%toy%' AND prod_desc like '%carrots%';
```

```sql
4.
select prod_name, prod_desc 
from products 
where prod_desc like '%toy%carrots%';
```

P.73 도전과제

```sql
1.
select vend_id, vend_name as vname, vend_address as vaddress, vend_city as vcity
from Vendors;
```

```sql
2.
select prod_id, prod_price, prod_price*(1-0.1) as sale_price from products
```