# 3/5 Effective Java

Date: March 5, 2022 11:22 AM

## Comparable을 구현할지 고려하라

- Comparable을 구현한 객체는 거색, 극단값 계산, 자동 정렬되는 컬렉션 관리도 쉽게 할 수 있다

```java
// 명렬줄 인수들을 알파벳순으로 정렬해준다
// String에서 Comparable을 구현했기 때문
public class WordList {
	public static void main(String[] args){
		Set<String> s = new TreeSet<>();
		Collections.addAll(s, args);
		System.out.println(s);
	}
}
```

- 자바 플랫폼 라이브러리의 모든 값 클래스와 열거타입이 Comparable을 구현했다
- compareTo의 규약은 equals 규약과 비슷하게 동치성, 반사성, 대칭성, 추이성을 충족해야 한다.
- compareTo의 규약을 따르려고 했을 때 기존 클래스를 확장한 구체 클래스에서 새로운 값 컴포넌트를 추가했다면 compareTo를 지킬 방법은 없다.
- 그러므로 우회법 또한 동일하다 → 독립된 클래스를 만들고, 이 클래스에 원래 클래스의 인스턴스를 가리키는 필드를 둔다.
- compareTo의 순서와 equals의 결과가 일관되어야 한다.

```java
// compareTo와 equals가 일관되지 않는 경우
BigDecimal big1 = new BigDecimal("1.0");
BigDecimal big2 = new BigDecimal("1.00");
HashSet<BigDecimal> bigDecimals = new HashSet<>();
System.out.println(big1.equals(big2));// FALSE

bigDecimals.add(big1);
bigDecimals.add(big2);
System.out.println(bigDecimals.size()); // 2

TreeSet<BigDecimal> bigDecimalTreeSet = new TreeSet<>();
bigDecimalTreeSet.add(big1);
bigDecimalTreeSet.add(big2);
System.out.println(bigDecimalTreeSet.size()); // 1
```

- compareTo 메서드는 객체 참조 필드를 비교하려면 compareTo 메서드를 재귀적으로 호출한다.
- compareTo를 구현시 Comparable<SelfClass> 를 구현하여 같은 참조만 비교할 수 있게 한다.
- 박싱된 기본 타입 클래스들의 compare 정적 메서드를 사용하면 compareTo 구현이 편리하다

```java
//기본 타입 필드가 여럿일 때의 비교자
public class PhoneNumber implements Comparable<PhoneNumber> {
    short areaCode;
    short prefix;
    short lineNum;
    
    @Override
    public int compareTo(PhoneNumber pn) {
        int result = Short.compare(areaCode, pn.areaCode);
        if(result == 0){
            result = Short.compare(prefix, pn.prefix);
            if(result == 0){
                result = Short.compare(lineNum, pn.lineNum);
            }
        }
        return result;
    }
}
```

- 자바 8에서는 Comparator 인터페이스가 일련의 비교자 생성 메서드와 팀을 꾸려 메서드 연쇄 방식으로 비교자를 생성할 수 있게 되었다. (성능 저하는 존재한다)

```java
private static final Comparator<PhoneNumber> COMPARATOR = 
            Comparator.comparingInt((PhoneNumber pn) -> pn.areaCode)
            .thenComparingInt(pn -> pn.prefix)
            .thenComparingInt(pn -> pn.lineNum);

    @Override
    public int compareTo(PhoneNumber pn) {
        return COMPARATOR.compare(this, pn);
    }
```

- 정리
    
    : 순서를 고려해야 하는 값 클래스를 작성한다면 꼭 Comparable 인터페이스를 구현하여, 그 인터페이스들을 쉽게 정렬하고, 검색하고, 비교 기능을 제공하는 컬렉션과 어우러지도록 해야 한다. compareTo 메서드에서 필드의 값을 비교할 때 <와 > 연산자는 쓰지 말아야 한다. 그 대신 박싱된 기본 타입 클래스가 제공하는 정적 compare 메서드나 Comparator 인터페이스가 제공하는 비교자 생성 메서드를 사용하자.