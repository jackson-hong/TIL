# 3/7 Effective Java

Date: March 7, 2022 5:40 AM

## public 클래스에서는 public 필드가 아닌 접근자 메서드를 사용하라

```java
class Point {
	public double x;
	public double y;
}
```

- 이런 클래스는 캡슐화의 이점을 제공하지 못한다. API를 수정하지 않고는 내부 표현을 바꿀 수 없고, 불변식을 보장할 수 없으며, 외부에서 필드에 접근할 때 부수 잡업을 수행할 수도 없다.

```java
// data 캡슐화!
public class Point {
    private double x;
    private double y;

    public Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }
}
```

- 그러나 package-private 클래스 혹은 private 중첩 클래스라면 데이터 필드를 노출한다 해도 하등의 문제가 없다.
- 되려 클라이언트 코드에서 훨씬 깔끔하다.

```java
// 말도 안 되는 객체이지만 이런식으로 가능하다.
public class Point {
    private double x;
    private double y;
    private ZPoint zPoint;

    private static class ZPoint{
        public double z;

        public ZPoint(double z) {
            this.z = z;
        }
    }

    public Point(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.zPoint = new ZPoint(z);
    }

		// 바로 접근 가능
    public double getZ(){
        return zPoint.z;
    }

    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }
}
```

- 출근 후 중첩 클래스들 확인해볼것
- 정리
    
    : public 클래스는 절대 가변 필드를 직접 노출해서는 안 된다. 불변 필드라면 노출해도 덜 위험하지만 완전히 안심할 수는 없다. 하지만 package-private 클래스나 private 중첩 클래스에서는 종종 (불변이든 가변이든) 필드를 노출하는 편이 나을 때도 있다.