# 3/1 Effective Java

Date: March 1, 2022 11:21 PM

## equals는 일반 규약을 지켜 재정의 하라.

- equals 메서드는 재정의하기 쉬워보이지만 자칫하면 끔찍한 결과를 초래할 수 있다
- 그러므로 가장 좋은 방법은 재정의하지 않는 것이다.
- 재정의하지 않아도 되는 케이스
    1. 각 인스턴스가 본질적으로 고유하다
        
        : 주로 동작하는 개체를 표현하는 클래스
        
    2. 논리적 동치성을 검사할 일이 없다
    3. 상위 클래스에서 재정의한 equals가 하위 클래스에도 딱 들어맞는다
    4. 클래스가 private 이거나 package-private이고 equals 메서드를 호출할 일이 없다.
        
        ```java
        //이런 경우에는 호출되는 걸 막기 위해 이렇게 구현한다
        @Override public boolean equals(Object o) {
        	throw new AeertionError();
        }
        ```