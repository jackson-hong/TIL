# 2/23 Effective Java

Date: February 23, 2022 5:58 AM

### 1. 생성자 대신 정적 팩터리 메서드를 고려하라

- 클래스를 생성자와 별도록 정적 팩터리 메서드를 제공할 수 있다

```java
public static Boolean valueOf(boolean b){
	return b ? Boolean.TRUE : Boolean.FALSE;
}
```

- 장점
    1. **이름을 가질 수 있다**
    - BigInteger(int, int, Random)과 정적 팩터레 메서드인 BigInteger.probablePrime 중 어느쪽이 ‘값이 소수인 BigInteger를 반환한다'는 의미를 더 잘 설명할 것 같은지 생각해보라
    1. **호출될 때마다 인스턴스를 새로 생성하지는 않아도 된다**
    - 인스턴스를 캐싱하는 식으로 불필요한 객체 생성을 피할 수 있다. 위의 코드는 객체를 아예 생성하지 않는다.
    1. **반환타입의 하위타입 객체를 반환할 수 있는 능력이 있다.**
    - 구현 클래스를 공개하지 않고도 그 객체를 반환할 수 있어 API를 작게 유지할 수 있다
    1. 입력 매개변수에 따라 매번 다른 클래스의 객체를 반환할 수 있다
    - 반환 타입의 하위 타입이기만 하면 어떤 클래스의 객체를 반환하든 상관없다.
    1. 정적 팩터리 메서드를 작성하는 시점에는 반환할 객체의 클래스가 존재하지 않아도 된다
- 단점
    1. 상속을 하려면 public이나 protected 생성자가 필요하니 정적 팩터리 메서드만 제공하면 하위 클래스를 만들 수 없다.
    2. 정적 팩터리 메서드는 프로그래머가 찾기 어렵다
- Naming Convention
    - from : 매개변수를 하나 받아서 해당 타입의 인스턴스를 반환하는 형변환 메서드
    
    ```java
    Date d = Date.from(instant);
    ```
    
    - of : 여러 매개변수를 받아 적합한 타입의 인스턴스를 반환하는 집계 메서드
    
    ```java
    Set<Rank> faceCards = EnumSet.of(JACK, QUEEN, KING);
    ```
    
    - valueOf : from과 of의 더 자세한 버전
    
    ```java
    BigInteger prime = BigInteger.valueOf(Integer.MAX_VALUE);
    ```
    
    - instance 혹은 getInstance : (매개변수를 받는다면) 매개변수로 명시한 인스턴스를 반환하지만, 같은 인스턴스임을 보장하지는 않는다
    
    ```java
    StackWalker luke = StackWalker.getInstance(options);
    ```
    
    - create 혹은 newInstance : instance 혹은 getInstance와 같지만 매번 새로운 인스턴스를 생성해 반환함을 보장한다.
    
    ```java
    Object newArray = Array.newInstance(classObject, arrayLen);
    ```
    
    - getType : getInstance와 같으나, 생성할 클래스가 아닌 다른 클래스에 팩터리 메서드를 정의할 때 쓴다. “Type”은 팩터리 메서드가 반환할 객체의 타입이다.
    
    ```java
    FileStore fs = Files.getFileStore(path);
    ```
    
    - newType : newInstance와 같으나, 생성할 클래스가 아닌 다른 클래스에 팩터리 메서드를 정의할 때 쓴다. “Type”은 팩터리 메서드가 반환할 객체의 타입이다.
    
    ```java
    BufferedReader br = Files.newBufferedReader(path);
    ```
    
    - type : getType과 newType의 간결한 버전
    
    ```java
    List<Complaint> litany = Collections.list(legacyLitany);
    ```