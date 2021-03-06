# 1/7 RxJava - Operators - 결합연산자

### 결합 연산자

**merge**

- 다수의 Observable에서 통지된 데이터를 받아서 다시 하나의 Observable로 통지한다
- 통지 시점이 빠른 Observable의 데이터부터 순차적으로 통지되고 통지 시점이 같을 경우에는 merge()함수의 파라미터로 먼저 지정된 Observable 데이터부터 통지된다.

![스크린샷 2022-01-07 오후 12.39.28.png](1.png)

![스크린샷 2022-01-07 오후 12.40.42.png](2.png)

![스크린샷 2022-01-07 오후 12.41.27.png](3.png)

**concat**

- 다수의 Observable에서 통지된 데이터를 받아서 다시 하나의 Observable로 통지한다.
- 하나의 Observable에서 통지가 끝나면 다음 Observable에서 연이어 통지가 된다.
- 각 Observable의 통지 시점과는 상관없이 concat() 함수의 파라미터로 먼저 입력된 Observable의 데이터부터 모두 통지된 후, 다음 Observable의 데이터가 통지된다.

![스크린샷 2022-01-07 오후 12.47.39.png](4.png)

![스크린샷 2022-01-07 오후 12.47.53.png](5.png)

**zip**

- 다수의 Observable에서 통지된 데이터를 받아서 다시 하나의 Observable로 통지한다.
- 각 Observable에서 통지된 데이터가 모두 모이면 각 Observable에서 동일한 index의 데이터로 새로운 데이터를 생성한 후 통지한다.
- 통지하는 데이터 개수가 가장 적은 Observable의 통지 시점에 완료 통지 시점을 맞춘다.
    
    : 갯수가 맞지 않는 경우 반환하지 않는다
    

![스크린샷 2022-01-07 오후 12.57.15.png](6.png)

![스크린샷 2022-01-07 오후 1.00.50.png](7.png)

![스크린샷 2022-01-07 오후 1.01.58.png](8.png)