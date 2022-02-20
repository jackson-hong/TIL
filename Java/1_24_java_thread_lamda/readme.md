# 1/24 JAVA - Thread, 람다

### 쓰레드의 우선순위

- 작업의 중요도에 따라 쓰레드의 우선순위를 다르게 하여 특정 쓰레드가 더 많은 작업시간을 갖게 할 수 있다.
- JVM에서는 1 ~ 10의 값으로 지정해 줄 수 있다
- OS의 스케쥴러에 값을 알려주지만 OS의 스케쥴러 나름의 스케쥴링 때문에 우선순위는 희망사항일뿐
- 지정 방법

```java
Thread th1 = new Thread();
th1.setPriority(7);
```

### 쓰레드 그룹

- 모든 쓰레드는 반드시 하나의 쓰레드 그룹에 포함되어 있다
- 쓰레드 그룹을 지정해주지 않으면 main 쓰레드 그룹에 속한다
- 자신을 생선한 쓰레드의 그룹과 우선순위를 상속 받는다

### 람다식

- **함수를 간단한 식(expression)으로 표현하는 방법**
- **익명 함수** - 이름이 없는 함수
- 메서드의 이름과 반환타입을 제거하고 ‘→’ 를 블록 {} 앞에 추가한다
- 반환값이 있는 경우, 식이나 값만 적고 return문 생략 가능
- 매개변수의 타입 추론 가능하면 생략 가능 (대부분의 경우 생략 가능)
- 매개 변수가 하나인 경우, 괄호() 생략 가능
- 블록 안의 문장이 하나뿐 일 때, 괄호{} 생략 가능
- 람다식은 익명 함수가 아니라 익명 객체다

```java
(a, b) -> a > b ? a : b
// 동일한 것
new Object(){
	int max(int a, int b){
		return a > b ? a : b;
	}
}
```

### 함수형 인터페이스

- 함수형 인터페이스 - 단 하나의 추상 메서드만 선언된 인터페이스
- @FunctionalInterface를 붙이면 컴파일러가 함수형으로 잘 작성되었는지 체크해줌

```java
MyFunction f = (a, b) -> a > b ? a : b;

@FunctionalInterfce
interface MyFunction{
	int max(int a, int b)
}

```