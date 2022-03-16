# 3/15 Effective Java

Date: March 15, 2022 6:16 AM

## 추상 클래스보다는 인터페이스를 우선하라

- 자바는 당일 상속만 지원하기 때문에 추상 클래스 방식은 새로운 타입을 정의하는 데 커다란 제약을 안게 된다.
- 반면 인터페이스가 잘 정의된 클래스는 **기존 클래스에도 손쉽게 새로운 인터페이스를 구현해넣을 수 있다.**
- 자바에서도 Comparable, Iterable, AutoCloseable 인터페이스가 새로 추가 됐을 때 표준 라이브러리의 수많은 기존 클래스가 이 인터페이스들을 구현한 채 릴리스 됐다.
- 하지만 기존 클래스위에 새로운 추상 클래스를 끼워넣기는 어렵다
- 인터페이스는 Mixin 정의에 안성맞춤이다 - 주된 기능에 선택적 기능을 혼합하는 것
- 또한 인터페이스로는 계층구조가 없는 타입 프레임워크를 만들 수 있다.

```java
public interface Singer {
	AudioClip sing(Song s);
}

public interface Songwriter {
	Song compose(int chartPosition);
}

public SingerSongwriter extends Singer, Songwriter {
	AudioClip strun();
	void actSensitive();
}
```

- 이러한 유연성을 제공하며 같은 구조를 클래스로 만들 경우 조합 폭발이라 부르는 현상이 일어난다.
- 인터페이스의 메서드 중 구현 방법이 명백한 것이 있다면 디폴트 메소드를 사용할 수 있다.
- 그러나 디폴트의 메서드의 경우 제약이 많이 존재하므로 **골격 구현 클래스**를 추천한다
- 예시

```java
public class AbstractMapEntry<K,V> implements Map.Entry<K,V>{
    
    @Override
    // 변경 가능한 엔트리는 이 메서드를 반드시 재정의해야 한다.
    // Exception으로 강제한다.
    public V setValue(V value) {
        throw new UnsupportedOperationException();
    }

    @Override
    public int hashCode() {
        // hashCode 일반 규약...
    }

    @Override
    public boolean equals(Object obj) {
        // equals의 일반 규약...
    }

    @Override
    public String toString() {
        // toString의 일반 규약..
    }
}
```

- 정리

> 일반적으로 다중 구현용 타입으로는 인터페이스가 가장 적합하다. 복잡한 인터페이스라면 구현하는 수고를 덜어주는 골격 구현을 제공하는 방법을 꼭 고려해보자. 골격 구현은 ‘가능한 한' 인터페이스의 디폴트 메서드로 제공하여 그 인터페이스를 구현한 모든 곳에서 활용하도록 하는 것이 좋다. ‘가능한 한'이라고 한 이유는, 인터페이스에 걸려있는 구현상의 제약 때문에 골격 구현을 추상 클래스로 제공하는 경우가 더 흔하기 때문이다.
>