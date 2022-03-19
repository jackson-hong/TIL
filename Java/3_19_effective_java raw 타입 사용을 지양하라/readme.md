# 3/19 Effective Java

Date: March 19, 2022 12:10 PM

### Raw 타입은 사용하지 말라

- 클래스와 인터페이스 선언에서 타입 매개변수가 쓰이면 이를 제네릭 클래스 혹은 제네릭 인터페이스라고 한다.
- List<String>의 경우는 원소 타입이 String인 리스트를 뜻하는 매개변수화 타입이다.
- Raw 타입이란 List<E>에서 제네릭을 제거한 List이다

```java
//잘못된 로타입 사용
private final Collection stamps = ...;
stamp.add(new Coin(...))
//컬렉션에서 동전을 다시 꺼내기 전까지는 오류를 알아채지 못한다.
for(Iterator i = stamps.iterator(); i.hasNext();){
	Stamp stamp = (Stamp) i.next(); //ClassCastException
	stamp.cancel;
}
```

- 가능한 오류는 컴파일에서 발견하는 것이 가장 이상적이다.
- 위와 같은 코드에서 예외가 발생할 경우 코드 전체를 훑어봐야 할 수도 있다.

```java
private final Collection<Stamp> stamps = ...;
```

- 엉뚱한 타입의 인스턴스를 넣으려 할 경우 컴파일 오류가 발생한다.
- Raw 타입을 쓸 경우 제네릭이 안겨주는 안정성과 표현력을 모두 잃게 된다
    - Raw 타입이 아직 동작하게 놔둔 이유는 이전 버젼으로 짜여진 코드와의 호환성 때문이다