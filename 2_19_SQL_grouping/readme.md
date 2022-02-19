# 2/19 SQL in 10 minutes

### 10장 데이터 그룹핑

**GROUP BY 중요 원칙**

- GROUP BY 절에는 원하는 만큼의 열을 써서, 중첩(nested) 그룹을 만들 수 있다. 이 방식은 데이터를 그룹핑하는 방식을 좀 더 세밀하게 제어할 수 있게 해준다.
- GROUP BY 절에 중첩된 그룹이 있다면, 데이터는 마지막으로 지정된 그룹에서 요약된다. 즉, 지정된 열은 그룹핑할 때 같이 측정된다 (그래서 각 열 단위로는 데이터를 얻지 못한다).
- GROUP BY 절에 있는 열은 가져오는 열이거나, 그룹 함수는 아니면서 유효한 수식이여야 한다. SELECT 절에서 수식을 사용한다면, GROUP BY 절에서도 같은 수식을 사용해야 한다. **별칭은 사용할 수 없다**
- 대부분의 SQL 실행환경에서는 GROUP BY 절에서 문자나 메모와 같은 가변형 길이의 데이터형은 사용할 수 없다.
- 그룹 함수 명령문을 제외하고 SELECT 절에 있는 모든 열은 GROUP BY 절에 존재해야 한다.
- 그룹핑하는 열의 행에 NULL 값이 있다면, NULL도 그룹으로 가져온다. 여러 행이 NULL 값을 가진다면, 모두 함께 그룹핑된다.
- GROUP BY 절은 WHERE 절 뒤에 그리고 ORDER BY 절 앞에 와야 한다.

→ HAVING과 WHERE는 비슷 하지만 WHERE는 행을 필터링하고, HAVING은 그룹을 필터링한다

→ GROUP BY를 사용할 경우 ORDER BY를 사용해서 정렬 순서를 명시해주자

```sql
// 가격이 4달러 이상인 제품을 두 개 이상 가진 판매처
select vend_id, count(*) as num_prods
from products
where prod_price >= 4
group by vend_id
having count(*) >= 2;

// 세개 이상의 제품을 주문한 경우, 주문 번호와 주문 수량
select order_num, count(*) as items
from orderitems
group by order_num
having count(*) >= 3;

// 도전과제 1
select order_num, count(*) as order_lines
from orderitems
group by order_num
order by order_lines;

// 도전과제 2
select vend_id, min(prod_price) as cheapest_item
from products
group by vend_id
order by cheapest_item;

// 도전과제 3
select order_num, sum(quantity)
from orderitems
having sum(quantity) >= 100
group by order_num;
order by order_num

// 도전과제 4
select order_num, sum(quantity*item_price) as total_price
from orderitems
group by order_num
having sum(quantity*item_price) >= 1000
order by order_num;
```