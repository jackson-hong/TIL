# 2/26 Effective Java

Date: February 26, 2022 10:14 AM

## 불필요한 객체 생성을 피하라

- 똑같은 기능의 객체를 매번 생성하기 보다는 객체 하나를 재사용하는 편이 나을 때가 많다.
- 나쁜 예
    - 실행될 때 마다 String 인스턴스를 새로 만든다

```java
String s = new String("jackson")
```

- 개선된 예
    - 하나의 String 인스턴스를 사용한다

```java
String s = "jackson";
```

- 생성자 대신 정적 팩터리 메서드를 제공하는 불변 클래스에서는 정적 팩터리 메서드를 사용해 불필요한 객체 생성을 피할 수 있다
    - 생성자는 호출할 때마다 새로운 객체를 만들지만, 팩터리 메서드는 그렇지 않다.

```java
Boolean j = new Boolean("true"); // <- 좋지 않은 예시 (Deprecated from 9)

Boolean j = Boolean.valueOf("jackson") <- GOOD

// 실제로 Boolean 클래스를 살펴보면

public final class Boolean implements java.io.Serializable,
                                      Comparable<Boolean>
{
    public static final Boolean TRUE = new Boolean(true);

    public static final Boolean FALSE = new Boolean(false);
		
		...

// 이렇게 Static 으로 하나의 주소값만 참조하고
		public static Boolean valueOf(String s) {
        return parseBoolean(s) ? TRUE : FALSE;
    }
		...
}
// Static의 주소값을 반환해준다
```

- 생성 비용이 비싼 객체의 예시
    - 하지만 개선된 방식이 초기화된 후 한번도 호출하지 않는다면 쓸데 없이 초기화 된 것이다.

```java
// Not Bad!
static boolean isRomanNumeral(String s){
	return s.matches("{정규식}");
}
// String.matches 메서드의 경우 내부에서 Pattern 인스턴스가 한 번 쓰고 버려져 gc의 대상이 된다.
```

```java
// GOOD!
// 값비싼 객체를 재사용해 성능을 개선한다
// 필자의 컴퓨터에서 6.5배 정도 빨라졌다
public class RomanNumerals {
	private static final Pattern ROMAN = Pattern.compile("{정규식}");

	static boolean isRomanNumeral(String s){
		return ROMAN.matcher(s).matches();
	}
}
```

- 불필요한 오토박싱
    - 박싱된 기본 타입보다는 기본 타입을 사용하고, 의도치 않은 오토박싱이 숨어들지 않도록 주의하자.

```java
private static long sum(){
	Long sum = 0L;
	for (long i = 0; i <= Integer.MAX_VALUE; i++){
		sum += i;
	}
	return sum;
}
// 불필요한 Long 인스턴스가 2^31개나 만들어진 것이다.
```