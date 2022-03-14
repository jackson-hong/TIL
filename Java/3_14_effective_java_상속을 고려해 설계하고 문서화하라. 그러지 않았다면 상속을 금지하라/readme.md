# 3/14 Effective Java

Date: March 14, 2022 5:17 AM

## 상속을 고려해 설계하고 문서화하라. 그러지 않았다면 상속을 금지하라

- **상속용 클래스는 재정의할 수 있는 메서드들을 내부적으로 어떻게 이용하는지(자기사용) 문서로 남겨야 한다.**
- 예를 들어 자바 `AbstractCollection` 클래스를 확인해보면

```java
/**
     * {@inheritDoc}
     *
     * <p>This implementation iterates over the collection looking for the
     * specified element.  **If it finds the element, it removes the element
     * from the collection using the iterator's remove method.**
     * <p>Note that this implementation throws an
     * <tt>UnsupportedOperationException</tt> if the iterator returned by this
     * collection's iterator method does not implement the <tt>remove</tt>
     * method and this collection contains the specified object.
     *
     * @throws UnsupportedOperationException {@inheritDoc}
     * @throws ClassCastException            {@inheritDoc}
     * @throws NullPointerException          {@inheritDoc}
*/
```

- `iterator` 메서드를 재정의하면 `remove` 메서드의 동작에 영향을 줌을 확실히 알 수 있다.
- 그러나 “좋은 API 문서란 ‘어떻게'가 아닌 ‘무엇'을 하는지 설명해야 한다”라는 격언과 대치된다 → 상속이 캡슐화를 해치기 때문에 나타나는 결과
- **문서외에 하위클래스를 어려움 없이 만들게 하려면 클래스의 내부 동작 과정 중간에 끼어들 수 있는 훅(hook)을 잘 선별하여 protected 메서드 형태로 공개해야 할 수도 있다.**
- 예를 들어 `AbstractList` 클래스를 확인해보면

```java
/*
Removes from this list all of the elements whose index is between fromIndex, 
inclusive, and toIndex, exclusive. Shifts any succeeding elements to the left 
(reduces their index). This call shortens the list by (toIndex - fromIndex) 
elements. (If toIndex==fromIndex, this operation has no effect.)
This method is called by the clear operation on this list and its subLists. 
Overriding this method to take advantage of the internals of the list 
implementation can substantially improve the performance of the clear 
operation on this list and its subLists.
This implementation gets a list iterator positioned before fromIndex, and 
repeatedly calls ListIterator.next followed by ListIterator.remove until 
the entire range has been removed. Note: **if ListIterator.remove requires** 
**linear time, this implementation requires quadratic time.
ListIterator.remove가 선형 시간이 걸리면 이 구현의 성능은 제곱에 비례한다.**
*/
```

- List 구현체의 최종 사용자는 `removeRange` 메서드에 관심이 없지만 clear 메서드를 고성능으로 만들귀 위해 protected로 `removeRange` 메소드를 제공하였다.
- 상속용 클래스를 설계할 때 어떤 메서드를 protected로 노출해야 할지 결정하는 방법은 직접 하위 클래스를 만들어보는 것이 유일하다.
- 널리 쓰일 클래스를 상속용으로 설계한다면 설계에서 선택한 결정이 영원히 족쇄가 될 수 있으므로 상속용으로 설계한 클래스는 배포 전에 반드시 하위 클래스를 만들어 검증한다.
- **또한, 상속용 클래스의 생성자는 직접적으로든 간적접으로든 재정의 가능 메서드를 호출해서는 안 된다.**
- 예시

```java
public class Super {
	public Super() {
		overrideMe();
	}

	public void overrideMe(){
		
	}
}

public final class Sub extends Super {
	private final Instant instant;

	Sub(){
		instnant = Instant.now();
	}

	@Overide public void overrideMe(){
		System.out.println(isntant);
	}

	public static void main(String[] args) {
		Sub sub = new Sub():
		sub.overrideMe();
	}
	// 첫번째는 null, 두번째는 instant를 출력한다
}
```

- 클래스를 상속용으로 설계하려면 엄청난 노력이 들고 그 클래스에 안기는 제약도 상당하다. 이 문제를 해결하는 가장 좋은 방법은 상속용으로 설계하지 않은 클래스는 상속을 금지하는 것이다.
    1. 둘 중 더 쉬운 쪽의 클래스를 final로 선언한다.
    2. 모든 생성자를 private 나 package-private로 선언하고 public 정적 팩터리를 만들어준다.
- 정리

> 상속용 클래스를 설계하기란 결코 만만치 않다. 클래스 내부에서 스스로를 어떻게 사용하는지(자기사용 패턴) 모두 문서로 남겨야 하며, 일단 문서화한 것은 그 클래스가 쓰이는 한 반드시 지켜야 한다. 그러지 않으면 그 내부 구현 방식을 믿고 활용하던 하위 클래스를 오동작하게 만들 수 있다. 다른 이가 효율 좋은 하위 클래스를 만들 수 있도록 일부 메서드를 protected로 제공해야 할 수도 있다. 그러니 클래스를 확장해야 할 명확한 이유가 떠오르지 않으면 상속을 금지하는 편이 나을 것이다. 상속을 금지하려면 클래스를 final로 선언하거나 생성자 모두 외부에서 접근할 수 없도록 만들면 된다.
>