# 3/8 Effective JavaQNFQUS RORCPFMF RM WKCPFH TLFVO DNJSWWKTJDDMF WPRHDGKSEK.ER

Date: March 8, 2022 5:18 AM

### 변경 가능성을 최소화하라

: [https://cs108.epfl.ch/archive/19/c/i/EffectiveJava_Item17.pdf](https://cs108.epfl.ch/archive/19/c/i/EffectiveJava_Item17.pdf)

- 불변 인스턴스에 간직된 정보는 고정되어 객체가 파괴되는 순간까지 절대 달라지지 않는다.
- 불변 클래스는 가변 클래스보다 설계하고 구현하고 사용하기 쉬우며, 오류가 생길 여지도 적고 훨씬 안전하다.
- 클래스를 불변으로 만드는 다섯 가지 규칙
    - 객체의 상태를 변경하는 메서드(변경자-setter)를 제공하지 않는다.
    - 클래스를 확장할 수 없도록 한다.
    - 모든 필드를 final로 선언한다.
    - 모든 필드를 private로 선언한다.
    - 자신 외에는 내부의 가변 컴포넌트에 접근할 수 없도록 한다.

```java
public final class Complex {
    private final double re;
    private final double im;

    public Complex(double re, double im) {
        this.re = re;
        this.im = im;
    }
    
    public double realPart() {return re;}
    public double imaginaryPart() {return im;}
    
    public Complex plus(Complex c){
        return new Complex(re + c.re, im + c.im);
    }
    
    public Complex minus(Complex c){
        return new Complex(re - c.re, im - c.im);
    }
    
    public Complex times(Complex c){
        return new Complex(re * c.re - im * c.im,
                                re * c.im + im * c.re);
    }
    
    public Complex dividedBy(Complex c){
        double tmp = c.re * c.re + c.im * c.im;
        return new Complex((re * c.re + im * c.im) / tmp,  (re * c.re - im * c.im) / tmp)
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Complex complex = (Complex) o;
        return Double.compare(complex.re, re) == 0 && Double.compare(complex.im, im) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(re, im);
    }

    @Override
    public String toString() {
        return "Complex{" +
                "re=" + re +
                ", im=" + im +
                '}';
    }
}
```

- 위의 클래스에서 사칙연산 메서드의 경우 자신은 수정하지 않고 새로운 Complex 인스턴스를 만들어 반환하는 모습에 주목하자. (함수형 프로그래밍)
- 불변 객체는 단순하고, 생성된 시점의 상태를 파괴될 때까지 그대로 간직한다.
- 불변 객체는 근본적으로 스레드 안전하여 따로 동기화할 필요 없다.
    - 불변 클래스라면 한번 만든 인스턴스를 최대한 재활용하기를 권한다.
    - e.g) public static final
    
    ```java
    public static final Complex ZERO = new Complex(0,0);
    public static final Complex ONE = new Complex(1,0);
    public static final Complex I = new Complex(0,1);
    ```
    
- 불변 객체는 자유롭게 공유할 수 있음은 물론, 불변 객체끼리는 내부 데이터를 공유할 수 있다.
- 불변 객체는 그 자체로 실패 원자성(예외 발생 후에도 그 객체는 여전히 유효한 상태여야한다)을 제공한다.
- 불변 클래스는 단점은 값이 다르면 반드시 독립된 객체로 만들어야 하므로 큰 비용을 치뤄야한다.
- 책에서 가변 동반 클래스라는 전혀 와닿지 않는 말이 나와서 원문을 찾아봤다
- 가변 동반 클래스 = mutable companion class
- Example of mutable companion class

```java
public final class Money {
  private BigDecimal amount;

	public Money(BigDecimal bigDecimal) {
		this.amount = bigDecimal;
	}

	public BigDecimal getAmount() {
		return this.amount;
	}

	// Notice the exclusively accessibility
	public Money add(BigDecimal money) {
		return new Money(this.amount.add(money));
	}

	private MoneyMutable getMutableVersion() {
		return new MoneyMutable(this.amount);
	}

	public Money complexOperation(BigDecimal money) {
		MoneyMutable mutableMoney = this.getMutableVersion();
		mutableMoney.add(money);
		mutableMoney.divide(money);
		/*
		 * suppose it is a complex operation which modifies the mutable money
		 * class a 100 times.
		 */
		return new Money(mutableMoney.getAmount());
	}
}

class MoneyMutable { // mutable companion class
  private BigDecimal amount;

	public MoneyMutable(BigDecimal money) {
		this.amount = money;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public MoneyMutable add(BigDecimal money) {
		this.amount.add(money);
		return this;
	}
	
	public MoneyMutable divide(BigDecimal money) {
		this.amount.divide(money);
		return this;
	}
}
```

- 정리
    
    : getter가 있다고 해서 무조건 setter를 만들지는 말자. **클래스는 꼭 필요한 경우가 아니라면 불변이어야 한다. 불변으로 만들 수 없는 클래스라도 변경할 수 있는 부분을 최소한으로 줄이자. 다른 합당한 이유가 없다면 모든 필드는 private final이어야 한다. 생성자는 불변식 설정이 모두 완료된, 초기화가 완벽히 끝난 상태의 객체를 생성해야 한다.**