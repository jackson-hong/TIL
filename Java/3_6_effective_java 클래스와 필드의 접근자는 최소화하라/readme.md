# 3/6 Effective Java

Date: March 6, 2022 12:25 PM

## 클래스와 멤버의 접근 권한을 최소화하라

- 어설프게 설계된 컴포넌트와 잘 설계된 컬포넌트의 가장 큰 차이는 클래스 내부 데이터와 구현 정보를 외부 컴포넌트로부터 얼마나 잘 숨겼느냐다
- 정보 은닉(캡슐화)의 장점
    - **개발 속도 향상** : 여러 컴포넌트를 병렬로 개발할 수 있다
    - **관리 비용 축소** : 컴포넌트를 빨리 파악하여 디버깅 할 수 있고 교체 비용도 적다
    - **성능 최적화** : 최적화할 컴포넌트를 정하고 다른 컴포넌트에 영향 없이 해당 컴포넌트만 최적화 할 수 있다
    - **재사용성** : 의존하지 않고 독자적인 컴포넌트는 함께 개발되지 않는 낯선 환경에서도 유용하게 쓰일 수 있다.
    - 대규모 시스템 제작 난이도 하락 : 시스템 전체의 완성 전에 개별 컴포넌트의 동작 검증 가능
- 기본 원칙 : **모든 클래스와 멤버의 접근성을 가능한 한 좁혀야 한다.**
- 탑레벨 클래스는 패키지 외부에서 쓸 이유가 없다면 default로 선언하자.
- protected 클래스의 경우 멤버는 가능하면 private로 정의하자.
- 그러나 상위 클래스에서 정의된 메서드의 경우 리스코프 치환 원칙에 의해 접근성을 좁힐 수 없다.
- 단지 테스트하려는 목적으로 클래스, 인터페이스, 멤버의 접근 범위를 넓히려 할 때가 있으나 그 허용 범위는 default까지이다. 또한 테스트 코드를 테스트 대상과 같은 패키지에 두면 default 요소에 접근할 수 있다.
- public 클래스의 인스턴스 필드는 되도록 public이 아니어야 한다.
    
    → public 가변 필드를 갖는 클래스는 일반적으로 Thread-Safe 하지 않다
    
- 클래스에서 public static final 배열 필드를 두거나 이 필드를 반환하는 접근자 메서드를 제공해서는 안 된다.

```java
public static final Thing[] VALUS = {...}; // 변경 가능한 상태이다

// 해결방법 - 불변리스트 활용
private static final Thing[] PRIVATE_VALUES = {...};
public static final List<Thing> VALUES =
	Collections.unmodifiableList(Arrays.asList(PRIVATE_VALUES));

// 해결방법 2 - 방어적 복사
private static final Thing[] PRIVATE_VALUES = {...};
public static final Thing[] valus(){
	return PRIVATE_VALUES.clone();
}
```

- 정리
    
    : 프로그램 요소의 접근성은 가능한 한 최소한으로 하라. 꼭 필요한 것만 골라 최소한의 public API를 설계하자. 그 외에는 클래스, 인터페이스, 멤버가 의도치 않게 API로 공개되는 일이 없도록 해야 한다. public 클래스는 상수용 public static final 필드 외에는 어떠한 public 필드도 가져서는 안 된다. public static final 필드가 참조하는 객체가 불변인지 확인하라.
    
- TODO : 자바 9에서부터 도입된 모듈 시스템 확인 (지난 프로젝트에서 사용했으나 제대로 뜯어보지 않았다)