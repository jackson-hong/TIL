# 3/3 Effective Java

Date: March 3, 2022 9:41 PM

## `equals`를 재정의하려거든 `hashCode`도 재정의하라

- Object 명세 규약
    - equals 비교에 사용되는 정보가 변경되지 않았다면, 애플리케이션이 실행되는 동안 그 객체의 hashCode 메서드는 몇 번을 호출해도 일관되게 항상 같은 값을 반환해야 한다. 단, 애플리케이션을 다시 실행한다면 이 값이 달라져도 상관없다.
    - equals(Object)가 두 객체를 같다고 판단했다면, 두 객체의 hashCode는 똑같은 값을 반환해야 한다.
    - equals(Object)가 두 객체를 다르다고 판단했더라도, 두 객체의 hashCode가 서로 다른 값을 반환할 필요는 없다. 단, 다른 객체에 대해서는 다른 값을 반환해야 해시테이블의 성능이 좋아진다.
- 논리적으로 같은 객체(`equals(Object) TRUE`)는 같은 해시코드를 반환해야 한다. (두번째 조항)

```java
Map<PhoneNumber, String> m = new HashMap<>();
m.put(new PhoneNumber(707, 867, 5309), "제니");

m.get(new PhoneNumber(707, 867, 5309)) // null
```

- 위의 예시에서 2개의 PhoneNumber 인스턴스가 사용되었다.
- HashMap은 해시코드가 다른 엔트리끼리는 동치성 비교를 시도조차 하지 않도록 최적화되어 있다

```java
// 내가 실험해 본 코드
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {

    private int id;
    private String name;
    private String nick;

    @Override
    public boolean equals(Object obj) {
        if(obj == this) return true;
        if(!(obj instanceof Product)) return false;
        Product product = (Product) obj;
        return product.id == id
                && product.name.equals(name)
                && product.nick.equals(nick);
    }

    @Override
    public int hashCode() {
        return 42;
    }

    public void changeId(){
        this.id = id + 1;
    }

    public static void main(String[] args) {
        Map<Product, String> map = new HashMap<>();
        map.put(new Product(1, "jackson", "jack"), "HI!!");

        System.out.println(map.get(new Product(1, "jackson", "jack")));
				// hashCode, equals 둘 중에 하나라도 구현하지 않으면 null을 반환한다.
    }
}
```

- 전형적인 hashCode 메서드

```java
@Override
    public int hashCode() {
        // 31은 홀수이면서 소수이기 때문
        int result = Integer.hashCode(id);
        result = 31 * result + name.hashCode();
        result = 31 * result + nick.hashCode();
        return result;
    }

// 성능이 아쉬운 hashCode 메서드 하지만 간편하다
@Override
    public int hashCode() {
        return Objects.hash(id, name, nick);
    }
```

- 지연 초기화(lazy initialization) 전략을 사용한 hashCode

```java
private int hashCode; // 자동으로 0으로 초기화
@Override
    public int hashCode() {
				int result = hashCode;
				if(result == 0){
			        int result = Integer.hashCode(id);
			        result = 31 * result + name.hashCode();
			        result = 31 * result + nick.hashCode();
			        hashCode = result;
			    }
				return result;
		}
// 스레드 안정성까지 고려해야 한다.
```

- 성능을 높인답시고 해시코드를 계산할 때 핵심 필드를 생략해서는 안 된다.
- hashCode가 반환하는 값의 생성 규칙을 API 사용자에게 자세히 공표하지 말자. 그래야 클라이언트가 이 값에 의지하지 않게 되고, 추후에 계산 방식을 바꿀 수 있다.