# 3/4 Effective Java

Date: March 4, 2022 5:34 AM

## `toString`을 항상 재정의하라

- `toString`의 일반 규약에 따르면 ‘간결하면서 사람이 읽기 쉬운 형태의 유익한 정보'를 반환해야 한다.
- 또한 ‘하위 모든 클래스에서 이 메서드를 재정의하라'고 한다.
- `toString`은 그 객체가 가진 주요 정보 모두를 반환하는 게 좋다.
- 객체의 상태가 거대하거나 문자열로 표한하기 적합하지 않다면 요약정보를 담아서 반환한다.

```java
// toString에 주요 정보가 담기지 않을 경우
// Assert 메소드 실행시..
Assertion failure : exprected {abc, 123}, but was {abcm 123}
```

- 정적 유틸리티 클래스는 toString을 제공할 이유가 없다.
- 또한 대부분의 열거타입도 자바가 이미 완벽한 toString을 제공하니 따로 재정의하지 않아도 된다.