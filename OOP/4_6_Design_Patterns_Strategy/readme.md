# 4/6 Design Patterns - Strategy Pattern

Date: April 6, 2022 9:22 PM

## 전략패턴

![스크린샷 2022-04-06 오후 9.33.13.png](1.png)

- 여러 알고리즘을 캡슐화하고 상호교환 가능하게 만드는 패턴.
- 컨텍스트에서 사용할 알고리즘을 클라이언트 선택한다.
- 어떤 일을 수행하는 방법이 여러가지 일때 공통된 인터페이스로 추상화한 뒤 로직을 사용하는 부분에서는 인터페이스만 사용한다.

```java
// e.g before
public class BlueLightRedLight {

    private int speed;

    public BlueLightRedLight(int speed) {
        this.speed = speed;
    }

    public void blueLight(){
        if(speed == 1){
            System.out.println("무   궁   화 꽃  이");
        }else if(speed == 2) {
            System.out.println("무궁화꽃이");
        }else {
            System.out.println("무광꽃이");
       }
    }

    public void redLight(){
        if(speed == 1){
            System.out.println("피   었   습 니 ");
        }else if(speed == 2) {
            System.out.println("피었습니다");
        }else {
            System.out.println("피어씀다");
        }
    }

    public static void main(String[] args) {
        BlueLightRedLight blueLightRedLight = new BlueLightRedLight(3);
        blueLightRedLight.blueLight();
        blueLightRedLight.redLight();
    }
}
```

```java
// Context
// e.g after 방법 1
public class BlueLightRedLight {

    private Speed speed;

    public BlueLightRedLight(Speed speed) {
        this.speed = speed;
    }

    public void blueLight(){
        speed.blueLight();
    }

    public void redLight(){
        speed.redLight();
    }

		public static void main(String[] args) {
        BlueLightRedLight blueLightRedLight = new BlueLightRedLight(new Faster());
        blueLightRedLight.blueLight();
        blueLightRedLight.redLight();
    }
}

// e.g after 방법 2
public class BlueLightRedLight {

    public void blueLight(Speed speed){
        speed.blueLight();
    }

    public void redLight(Speed speed){
        speed.redLight();
    }

		public static void main(String[] args) {
        BlueLightRedLight blueLightRedLight = new BlueLightRedLight();
        blueLightRedLight.blueLight(new Normal());
        blueLightRedLight.redLight(new Faster());
    }
}

public interface Speed {
    void blueLight();
    void redLight();
}

public class Normal implements Speed{
    @Override
    public void blueLight() {
        System.out.println("무   궁   화 꽃  이");
    }

    @Override
    public void redLight() {
        System.out.println("피   었   습 니 다");
    }
}

public class Faster implements Speed{

    @Override
    public void blueLight() {
        System.out.println("무궁화꽃이");
    }

    @Override
    public void redLight() {
        System.out.println("피었습니다");
    }
}
```