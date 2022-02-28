# 2/28 Effective Java

Date: February 28, 2022 6:22 AM

## finalizer와 cleaner 사용을 피하라

- Java의 두 가지 객체 소멸자 - **finalizer, cleaner**
- finalizer는 예측할 수 없고, 상황에 따라 위험할 수 있어 일반적으로 **불필요** 하다.
- Java 9부터 ~~finalize()~~
- 그 대안으로 cleaner가 존재하지만 여전히 예측 불가, 느림, 일반적으로 **불필요**
- 이 두 가지 객체 소멸자는 실행되기까지 얼마나 걸릴지 알 수 없으므로 **제때 실행될 수 없다.**
- 수행 속도는 GC 알고리즘에 따라 다르고 천차만별이다.
- finalizer **스레드의 우선순위는 프로그래머가 조작하기 어렵다**
- 그러므로 상태를 영구적으로 수정하는 작업에서는 절대 finalizer나 cleaner에 의존해서는 안 된다
- 대안 → Autoclosable을 구현해주고, 클라이언트에서 인스턴스를 다 쓰고 나면 close 메서드를 호출하면 된다. (일반적으로 예외가 발생해도 제대로 종료되도록 try-with-resources를 사용해야 한다.)

```java
// cleaner를 안전망으로 활용하는 AutoCloseable 클래스
public class Room implements AutoCloseable{
    private static final Cleaner cleaner = Cleaner.create();

    // 청소가 필요한 자원.
    private static class State implements Runnable {

        int numJunkPiles; // Room 안의 쓰레기 수

        State(int numJunkPiles){
            this.numJunkPiles = numJunkPiles;
        }

        // close 메서드나 cleaner가 호출한다.

        @Override
        public void run() {
            System.out.println("방 청소");
            numJunkPiles = 0;
        }
    }

    // 방의 상태. cleanable과 공유한다.
    private final State state;

    // cleanble 객체. 수거 대상이 되면 방을 청소한다.
    private final Cleaner.Cleanable cleanable;

    public Room(int numJunkPiles) {
        this.state = new State(numJunkPiles);
        this.cleanable = cleaner.register(this, state);
    }

    @Override
    public void close() throws Exception {
        cleanable.clean();
    }
}
```