# 2/25 Effective Java

Date: February 25, 2022 6:18 AM

## private 생성자나 열거 타입으로 싱글턴임을 보증하라

- 싱글턴 : 인스턴스를 오직 하나만 생성할 수 있는 클래스.
- 클래스를 싱글턴으로 만들면 이를 사용하는 클라이언트를 테스트하기가 어려워질 수 있다.
    
    → 실제로 실무에서 테스트하는 경우에 Static으로 구현된 API를 Mocking할 필요가 있는 경우가 있었다
    
- public static final 필드 방식의 싱글턴
    - 클래스에서 싱글턴임이 명백히 드러난다
    - 간결하다
    - 예외적으로 Reflection API를 사용하면 접근할 수 있다

```java
public class Elvis {
	**public** static final Elvis INSTANCE = new Elvis();
	private Elvis(){...}
	
	public void leaveTheBuilding() {...}
}
// private 생성자는 Elvis.INSTANCE를 초기화할 때 딱 한번 호출된다.
```

- 정적 팩터리 방식의 싱글턴
    - API 변환 없이 싱글턴이 아니게 변경할 수 있다.
    - 정적 팩터리를 제네릭 싱글턴 팩터리로 만들 수 있다
    - Supplier로 사용할 수 있다

```java
public class Elvis {
	**private** static final Elvis INSTANCE = new Elvis();
	private Elvis() {...}
	public static Elvis getInstance() {return INSTANCE;}

	public void leaveTheBuilding() {...}
}
// Elvis.getInstance는 항상 같은 객체의 참조를 반환하므로 제2의 Elvis 인스턴스란 
// 결코 만들어지지 않는다
```

- 위의 두가지 방식에서 직렬화를 해야 하는 경우 모든 인스턴스 필드를 transient 선언하고 readResolve 메서드를 제공해야 한다.

```java
private Object readResolve() {
	return INSTANCE;
}
```

- 열거 타입 방식의 싱글턴
    - public 필드 방식과 비슷하지만 더 간결하고 직렬화 가능
    - 리플렉션을 사용해도 제2의 인스턴스가 생기는 일을 막아준다
    - 대부분 상황에서는 원소가 하나뿐인 열거 타입이 싱글턴을 만드는 가장 좋은 방법이다.

```java
public enum Elvis {
	INSTANCE;

	public void leaveTheBuilding() {...}
}
```

## 자원을 직접 명시하지 말고 의존 객체 주입을 사용하라

```java
// 정적 유틸리티를 잘못 사용한 예 - 유연하지 않고 테스트하기 어렵다
public class SpeelChecker {
	private static final Lexicon dictionary = ...;
	private SpellChecker(){}

	public static boolean isValid(String word){...}
	public static List<String> suggestions(String typo) {...}
}
```

```java
// 싱글턴을 잘못 사용한 예 - 유연하지 않고 테스트하기 어렵다
public class SpeelChecker {
	private final Lexicon dictionary = ...;

	private SpellChecker(){}
	public static SpellChecker INSTANCE = new SpellChecker(...);

	public static boolean isValid(String word){...}
	public static List<String> suggestions(String typo) {...}
}
```

- 사전 하나 밖에 없다는 가정으로는 여러 케이스에 대응할 순 없다
- SpellChecker가 여러 사전을 사용할 수 있도록 하기 위해서는 final 제거, 교체하는 메서드 추가할 수 있지만 멀티쓰레드 환경에서는 쓸 수 없다.

```java
// 의존 객체 주입 방식 - 이것은 스프링 DI..!
public class SpeelChecker {
	private final Lexicon dictionary = ...;
	private SpellChecker(Lexicon dictionary){
		this.dictionary = Objects.requeireNonNull(dictionary);
	}

	public static boolean isValid(String word){...}
	public static List<String> suggestions(String typo) {...}
}
```