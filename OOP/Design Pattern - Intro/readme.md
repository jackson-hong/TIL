# 디자인패턴 - Introduction

Date: July 5, 2022 10:21 PM

> ref : [https://www.aladin.co.kr/shop/wproduct.aspx?ISBN=E962530762&start=pnaverebook](https://www.aladin.co.kr/shop/wproduct.aspx?ISBN=E962530762&start=pnaverebook)
> 

### 오리 시뮬레이션 게임

**예제 코드**

```java
public abstract class Duck{
	public void quack(){...}
	public void swim(){...}
	public abstract void display(){...}
}

public class MallardDuck extends Duck{
	public display(){...}
}

public class RedheadDuck extends Duck{
	public display(){...}
}
```

**신규 요구사항**

- 클라이언트 : 오리를 날게 해주세요.

```java
public abstract class Duck{
	public void quack(){...}
	public void swim(){...}
	public abstract void display(){...}
	// 개발자는 여기에 코드를 추가한다.
	public void fly(){...}
}
```

**결과**

- 클라이언트 : 모든 오리가 날고 있어요.

코드의 일부분만 고쳤지만, 프로그램 전체에 오리(날 필요가 없는)가 날아다니는 오류가 발생

선택적으로 상속을 하기 위해 개발자는 인터페이스를 생각하게 된다.

```java
public interface Flyable{
	void fly();
}

public interface Quackable{
	void quack();
}
...
```

⇒ Flyable을 상속받은 클래스가 여러개일 경우 fly 메소드의 동작의 수정이 필요한 경우 모든 코드를 수정해야 하는 불상사가 생길 수 있다.

> **디자인 원칙
애플리케이션에서 달라지는 부분을 찾아내고, 달리지지 않는 부분과 분리한다.**
> 

“바뀌는 부분은 따로 뽑아서 캡슐화한다. 그러면 나중에 바뀌지 않는 부분에는 영향을 미치지 않고 그 부분만 고치거나 확장할 수 있다.”

### 해결 방안

변화하는 부분과 그대로 있는 부분을 분리하려면 변화하는 부분을 클래스 집합으로 만들어주는게 좋다.

> **디자인 원칙
구현보다는 인터페이스에 맞춰서 프로그래밍한다.**
> 

```java
public interface FlyBehavior {
	void fly();
}

public class FlyWithWings implements FlyBehavior {
	public void fly(){
		...fly logic...
	}
}

public class FlyNoWay implements FlyBehavior {
	public void fly(){} //none
}

public interface QuakcBehavior {
	void quack();
}

public class Quack implements QuackBehavior {
	void qauck(){
		...quack logic...
	}
}

public class Squack implements QuackBehavior {
	void qauck(){
		...different quack logic...
	}
}
```

⇒ 다른 형식의 객체에서도 나는 행동과 꽥꽥거린느 행동을 재사용할 수 있다. 새로운 행동도 추가가 용이하다.

### 실 사용 코드

```java
public abstract class Duck {
	QuackBehavior quackBehavior;

	public void performQuack(){
		quackBehavior.quack();
	}
}

public class MallardDuck extends Duck {
	public MallardDuck(){
		quackBehavior = new Quack();
		flyBehavior = new FlyWithWings();
	}

	public void displayt(){
		...
	}
}
```