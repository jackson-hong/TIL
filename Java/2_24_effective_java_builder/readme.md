# 2/24 Effective Java - item. 2

Date: February 24, 2022 5:25 AM

## 생성자에 매개변수가 많다면 빌더를 고려하라

필드가 많은 경우에 생성자 패턴의 대안

- 점증적 생성자 패턴
    
    ```java
    public Jackson(int param1, int param2){
    	this(param1, param2, 0)
    }
    
    public Jackson(int param1, int param2, int param3){
    	this(param1, param2, param3, 0)
    }
    ...
    ```
    
    - 단점 : 매개변수가 많아지면 클라이언트 코드를 작성하거나 읽기 어려움
- 자바 빈즈 패턴
    
    ```java
    Jackson jackson = new Jackson();
    jackson.setFieldOne(200);
    jackson.setFieldTwo(300);
    ...
    ```
    
    - 단점
        1. 메서드 여러개를 호출해야 하고 객체가 완성되기 전까지 일관성이 무너진 상태
        2. 클래스를 불변으로 만들 수 없다
- **빌더 패턴**
    
    ```java
    Jackson jackson = new Jackson.Builder(240, 8).name("jackson").age(29).build();
    ```
    
    - 빌더 패턴은 계층적으로 설계된 클래스와 함께 쓰기에 좋다
    
    ```java
    public abstract class Pizza {
        public enum Topping {HAM, MUSHROOM, ONION, PEPPER, SAUSAGE}
        final Set<Topping> toppings;
        
        abstract static class Builder<T extends Builder<T>> {
            EnumSet<Topping> toppings = EnumSet.noneOf(Topping.class);
            public T addTopping(Topping topping){
                toppings.add(Objects.requireNonNull(topping));
                return self();
            }
            
            abstract Pizza build();
    
            protected abstract T self();
        }
        
        Pizza(Builder<?> builder){
            toppings = builder.toppings.clone();
        }
    }
    
    // 클라이언트 코드
    NyPizza = new NyPizaa.Builder(SMALL)
    						.addTopping(SAUSAGE)
    						.addTopping(ONION)
    						.build();
    ```
    
    - 장점
        1. 가변인수 매개변수를 여러개 사용할 수 있다.
        2. 빌더 하나로 여러 객체를 순회하면 말들 수 있다.
        3. 빌더에 넘기는 매개변수에 따라 다른 객체를 만들 수도 있다.
        4. 특정 필드는 빌더가 알아서 채우도록 할 수도 있다.
    - 단점
        1. 객체를 만들려면, 빌더부터 만들어야 한다.
        2. 매개변수가 4개 이상은 되어야 값어치를 한다.
    - 정리
        
        : 생성자나 적정 팩터리가 처리해야 할 매개변수가 많다면 빌더 패턴을 선택하는 게 더 낫다.