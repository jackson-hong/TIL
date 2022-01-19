# 1/3 Spring - SpEL, AOP

### SpEL(Spring Expression Language)

**Spring EL?**

- 객체 그래프를 조회하고 조작하는 기능을 제공한다
- Unified EL과 비슷하지만, 메소드 호출을 지원하며, 문자열 템플릿 기능도 제공한다.
- 스프링 3.0 부터 지원

**SpEL 구성**

- ExpressionParser parser = new SpelExpressionParser()
- StandardEvaluationContext context = new StandardEvaluationContext(bean)
- Expression = expression = parser.parseExpression(”SpEL 표현식”)
- String value = expression.getvalue(context, String.class)

**문법**

- #{”표현식”}
- ${”프로퍼티”}
- 표현식은 프로퍼티를 가질 수 있지만, 반대는 안 됨
    - #{${mt.data} + 1}

**사용되는 곳**

- @Value
- @ConditionalOnExpression
- 스프링 시큐리티
    - 메소드 시큐리티, @PreAuthorize, @PostAuthorize, @PreFilter, @PostFilter
    - XML 인터셉터 URL 설정
    - ...
- 스프링 데이터
    - @Query
- Thymeleaf

### AOP

** OOP와 보완관계에 있다

**AOP 주요 개념**

- Aspect : 관심사(concern)을 묶은 모듈
- Advice : 수행할 기능
- PointCut : 어디에 적용해야 하는지
- Target : 적용할 클래스
- JoinPoint : 합류 지점 - 스펙으로 보면 됨

** A 클래스에 B 메소드 실행시 실행 - PointCut

** 메소드 실행 직전에 실행 - JoinPoint

**AOP 구현체**

- AspectJ - 다양한 JoinPoint가 사용 가능
- Spring AOP

**AOP 적용 방법**

- 컴파일 - 주로 AspectJ
- 로딩타임 - 주로 AspectJ
- 런타임 - 주로 Spring AOP