# 2/27 Effective Java

Date: February 27, 2022 11:18 AM

## 따 쓴 객체 참조를 해제하라

- GC를 사용한다고 해서 메모리 관리에 더 이상 신경을 쓰지 않아도 되는 것이 아니다

```java
public class Stack {
    private Object[] elements;
    private int size = 0;
    private static final int DEFAULT_INITIAL_CAPACITY = 16;
    
    public Stack(){
        elements = new Object[DEFAULT_INITIAL_CAPACITY];
    }
    
    public void push(Object e){
        ensureCapacity();
        elements[size++] = e;
    }
    
    public Object pop(){
        if (size == 0){
            throw new EmptyStackException();
        }
        return elements[--size];
    }
    
    /*
    * 원소를 위한 공간을 적어도 하나 이상 확보한다.
    * 배열 크기를 늘려야 할 때마다 대략 두 배씩 늘린다
    * */
    
    private void ensureCapacity(){
        if (elements.length == size){
            elements = Arrays.copyOf(elements, 2 * size + 1);
        }
    }
}
```

- 위 코드의 문제는 스택이 커졌다가 줄어들었을 때 스택에서 꺼내진 객체들을 가비지 컬렉터가 회수하지 않는다.
    - 이 스택은 elements 배열로 저장소 풀을 직접 만들어 원소들을 관리한다
    - 배열의 활성영역과 비활성영역은 GC가 알 수 없다
    - GC는 비활성 영역도 유효한 객체로 판단한다
    - 그러므로 비활성영역이 되는 순간 null 처리를 해줘야 한다.

```java
// 제대로 구현된 pop 메서드
public Object pop(){
	if(size == 0) throw new EmptyStackException();
	Object result = elements[--size];
	elements[size] == null // 다 쓴 참조 해제
	return result;
}
```

- 그러나 객체 참조를 null 처리 하는 일은 예외적인 경우여야 한다.
- 다 쓴 참조를 해제하는 가장 좋은 방법은 그 참조를 담은 변수를 유효 범위 밖으로 밀어내는 것이다.
- **자기 메모리를 직접 관리하는 클래스라면 항시 메모리 누수에 주의해야 한다.**
- **캐시 역시 메모리 누수를 일으키는 주범이다**
    - 캐시 외부에서 키를 참조하는 동안만 엔트리가 살아있는 캐시가 필요한 상황이라면 `WeakHashMap` 을 사용해 캐시를 만든다. 다 쓴 엔트리는 그 즉시 자동으로 제거된다.
    - 캐시를 만들 때 유효기간을 정확히 정의하기 어렵기 때문에 이따금 청소해줘야 한다.
        - `ScheduledThreadPoolExecutor` 같은 백그라운드 쓰레드를 활용하거나
        - `LinkedHashMap.removeEldestEntry` 같은 메소드를 통해 새로운 엔트리를 추가할 때 수행해주는 방법이 있다