# 3/12 Effective Java

Date: March 12, 2022 11:47 PM

## 상속보다는 컴포지션을 사용하라

- 상속을 코드를 재사용하는 강력한 수단이지만, **항상 최선은 아니다.**
- **메서드 호출과 달리 상속은 캡술화를 깨뜨린다.**
    - 상위 클래스의 구현에 따라 하위 클래스 동작에 이상이 생길 수 있고 상위 클래스 릴리즈에 의존성에 의해 하위 클래스가 오작동할 수 있다
- 상위 메서드를 재정의하는 방법이 있으나 이 방식은 어렵고 시간도 더 들고 자칫 오류를 내거나 성능을 떨어뜨릴 수도 있다.
- 상위 클래스에서 private로 구현이 되어있다면 답이 없다..
- 이 문제를 모두 피해가는 묘안이 바로 새로운 클래스르 만들고 private 필드로 기존 클래스의 인스턴스를 참조하는 것이다 → **컴포지션(Composition)**
- 기존 클래스를 private 필드로 참조하는 Wrapper 클래스를 만든 뒤 그 클래스를 상속하면 좀 더 유연성 있는 객체를 생성할 수 있다
- 상속하기 전에 꼭 클래스 B가 클래스 A와 is-a 관계인지 확인하고 A를 상속하도록 하자
- 정리

> 상속은 강력하지만 캡슐화를 해친다는 문제가 있다. 상속은 상위 클래스와 하위 클래스가 순수한 is-a 관계일 때만 써야 한다. is-a 관계일 때도 안심할 수만은 없는 게, 하위 클래스의 패키지가 상위 클래스와 다르고, 상위 클래스가 확장을 고려해 설계되지 않았다면 여전히 문제가 될 수 있다. 상속의 취약점을 피하려면 상속 대신 컴포지션과 전달을 사용하자. 특히 래퍼 클래스로 구현할 적당한 인터페이스가 있다면 더욱 그렇다. 래퍼 클래스는 하위 클래스보다 견고하고 강력하다.
>