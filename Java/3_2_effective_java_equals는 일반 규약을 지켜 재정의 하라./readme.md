# 3/2 Effective Java

Date: March 2, 2022 6:07 AM

## equals는 일반 규약을 지켜 재정의 하라.

- equals 메서드는 재정의하기 쉬워보이지만 자칫하면 끔찍한 결과를 초래할 수 있다
- 그러므로 가장 좋은 방법은 재정의하지 않는 것이다.
- 재정의하지 않아도 되는 케이스
    1. 각 인스턴스가 본질적으로 고유하다
        
        : 주로 동작하는 개체를 표현하는 클래스
        
    2. 논리적 동치성을 검사할 일이 없다
    3. 상위 클래스에서 재정의한 equals가 하위 클래스에도 딱 들어맞는다
    4. 클래스가 private 이거나 package-private이고 equals 메서드를 호출할 일이 없다.
        
        ```java
        //이런 경우에는 호출되는 걸 막기 위해 이렇게 구현한다
        @Override public boolean equals(Object o) {
        	throw new AeertionError();
        }
        ```
        
- 재정의 해야 하는 케이스 : 객체 식별성이 아닌 논리적 동치성을 확인해야 하는ㄴ데, equals가 논리적 동치성을 비교하도록 재정의 되지 않았을 때 - 주로 **값 클래스**
- Object 명세에 적힌 equals 메서드 재정의시 지켜야하는 규약
    - reflexive(반사성): `x.equals(x)` 는 항상 참이어야 한다.
        - 이 요건을 어긴 클래스의 인스턴스를 컬렉션에 넣은 다음 contains 메서드를 호출하면 방금 넣은 인스턴스가 없다고 답할 것이다.
    - symmetric(대칭성): `x.equals(y)` 가 참이라면 `y.equals(x)` 역시 참이어야 한다.
        - 이 규약을 어길 경우 그 객체를 사용하는 다른 객체들이 어떻게 반응할지 알 수 없다.
    
    ```java
    //대칭성이 위배된 코드
    public final class CaseInsensitivesString {
    	private final String s;
    	public CaseInsensitivesString(String s){
    		this.s = Objcts.requireNonNull(s);
    	}
    	
    	@Override public boolean equals(Object o){
    		if(o instanceof CaseInsensitiveString)
    			return s.equalsIgnoreCase(((CaseInsensitiveString)o).s);
    		if(o instance of String) // 한 방향으로만 작동한다
    			return s.equalsIgnoreCase((String) o);
    		return false;
    	}
    }
    
    ...
    CaseInsensitiveString cis = new CaseInsensitiveString("Polish");
    String s = "polish";
    cis.equals(s); // TRUE
    
    List<CaseInsensitiveString> list = new ArrayList<>();
    list.add(cis);
    
    list.contains(s) // TRUE OR FALSE depending on JDK version
    
    //올바른 코드
    @Override public boolean equals(Object o){
    			return o instanceof CaseInsensitiveString 
    				&& ((CaseInsensitiveString)o).s.equalsIgnoreCase(s);
    	}
    ```
    
    - transitive(추이성): `x.equals(y)` 가 참이고 `y.equals(z)` 가 참일 때 `x.equals(z)` 역시 참이어야 한다.
    
    ```java
    public class Point{
    	private final int x;
    	private final int y;
    
    	public Point(int x, int y){
    		this.x = x;
    		this.y = y;
    	}
    
    	@Override public boolean equals(Object o){
    		if(!(o instanceof Point)) return false;
    		Point p = (Point)o;
    		return p.x == x && p.y == y;
    	}
    }
    
    public class ColorPoint extends Point {
    	private final Color color;
    	public ColorPoint(int x, int y, Color color){
    		super(x, y);
    		this.color = color;
    	}
    
    	// 대칭성이 위배된 코드
    	@Override public boolean equals(Object o){
    		if(!(o instanceof Point)) return false;
    		return super.equals(o) && ((ColorPoint) o).color == color;
    	}
    	// Point를 ColorPoint에 비교한 결과와 그 둘을 바꿔 비교한 결과가 다를 수 있다.
    }
    
    ...
    
    Point p = new Point(1,2);
    ColorPoint cp = new ColorPont(1,2, Color.RED);
    
    p.equals(cp); //TRUE
    cp.equals(p); //FALSE
    
    // 추이성이 위배된 코드
    @Override public boolean equals(Object o){
    		if(!(o instanceof Point)) return false;
    		
    		// o가 일반 Point면 색상을 무시하고 비교한다.
    		if(!(o instanceof ColorPoint)) return o.quals(this);
    
    		return super.equals(o) && ((ColorPoint) o).color == color;
    	}
    
    // 대칭성을 지켜주지만 추이성을 깨버린다
    ColorPoint p1 = new ColorPoint(1,2,Color.RED);
    Point p2 = new Point(1,2);
    ColorPoint p3 = new ColorPoint(1,2,Color.BLUE);
    
    p1.eqauls(p2) //TRUE
    p2.eqauls(p3) //TRUE
    p1.eqauls(p3) //FALSE
    ```
    
    **: 구체 클래스를 확장해 새로운 값을 추가하면서 equals 규약을 만족시킬 방법은 존재하지 않는다**
    
    → 우회하는 방법은 존재한다
    
    ```java
    public class ColorPoint {
        private final Point point;
        private final Color color;
    
        public ColorPoint(int x, int y, Color color) {
            point = new Point(x,y);
            this.color = Objects.requireNonNull(color);
        }
        
        public Point asPoint(){
            return point;
        }
        
        @Override public boolean equals(Object o){
            if(!(o instanceof ColorPoint)) return false;
            ColorPoint cp = (ColorPoint) o;
            return cp.point.equals(point) && cp.color.equals(color);
        }
    }
    ```
    
    - consistent(일관성): `x.equals(y)` 가 참일 때 equals 메서드에 사용된 값이 변하지 않는 이상 몇 번을 호출해도 같은 결과가 나와야 한다.
        - 클래스가 불변이든 가변이든 equals의 판단에 신뢰할 수 없는 자원이 끼어들게 해서는 안 된다.
    - x가 null이 아닐 때 `x.equals(null)` 은 항상 거짓이어야 한다.
        - o.equals(null)이 true를 반환하는 경우는 없겠지만 NPE를 던지는 코드는 흔할 것이다.
        
        ```java
        if(o == null) return false // 보다는
        if(!(o instanceof MyType)) return false //이거지
        ```
        
    - 올바르게 구현된 equals 메서드
    
    ```java
    @Override public boolean equals(Object o) { 
    	if (o = this) return true; 
    	if (!(o instanceof PhoneNumber)) 
    	return false; 
    	PhoneNumber pn = (PhoneNumber)o; 
    	return pn.lineNum = lineNum && pn.prefix = prefix 
    		&& pn.areaCode = areaCode;
    }
    ```