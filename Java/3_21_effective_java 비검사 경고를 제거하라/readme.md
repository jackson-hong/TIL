# 3/21 Effective Java

Date: March 21, 2022 6:22 AM

### 비검사 경고를 제거하라

- 제네릭 사용시 많은 컴파일러 경고를 보게 된다
- 비겸사 형변환 경고, 비검사 메서드 호출 경고, 비검사 매개변수화 가변인수 타입 경고, 비검사 변환 경고 등등

```java
Set<Lark> exaltation = new HashSet();
```

- javac 명령줄 인수에 `Xlint:uncheck` 를 추가해주면 컴파일러가 잘못된 부분을 설명해준다. (인텔리제이도 해준다.)
- 경고를 제거할 수는 없지만 타입 안전하다고 확신할 수 있다면 `@SuppressWarnings(”unchecked”)` 애너테이션을 달아 경고를 숨기자

```java
public <T> T[] toArray(T[] a) {
        if (a.length < size)
            return (T[]) Arrays.copyOf(elementData, size, a.getClass());
        System.arraycopy(elementData, 0, a, 0, size);
        if (a.length > size)
            a[size] = null;
        return a;
    }
// 컴파일시 (T[]) Arrays.copyOf(elementData, size, a.getClass()); 에서 경고가 발생한다.
public <T> T[] toArray(T[] a) {
        if (a.length < size)
						@SuppressWarnings("unchecked") T[] result 
							= (T[]) Arrays.copyOf(elementData, size, a.getClass());
						return result;
				}
        System.arraycopy(elementData, 0, a, 0, size);
        if (a.length > size)
            a[size] = null;
        return a;
    }
//생성한 배열과 매개변수로 받은 배열의 타입이 같으므로 올바른 형변환이다.
```

- `@SuppressWarnings(”unchecked”)` 사용법
    - 사용시 가능한 한 좁은 범위에서 사용할 것
    - 사용시 경고를 무시해도 안전한 이유를 항상 주석으로 남길 것