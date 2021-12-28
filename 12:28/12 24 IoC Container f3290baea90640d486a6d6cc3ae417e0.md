# 12/24 IoC Container

### IoC 컨테이너 : 스프링 IoC 컨테이너와 빈

Inversion of Control: 의존 관계 주입(Dependency Injection)이라고도 하며, 어떤 객체가
사용하는 의존 객체를 직접 만들어 사용하는게 아니라, 주입 받아 사용하는 방법을 말 함.

스프링 IoC 컨테이너

- BeanFactory
- 애플리케이션 컴포넌트의 중앙 저장소.
- 빈 설정 소스로 부터 빈 정의를 읽어들이고, 빈을 구성하고 제공한다.

빈

- 스프링 IoC 컨테이너가 관리하는 객체
- 장점
    - 의존성 관리
    - 스코프
        - 싱글톤
        - 프로토타입
    - 라이프 사이클 인터페이스 (e.g @PostConstruct)

Application Context

- Bean Factory
- 메시지 소스 처리 기능
- 이벤트 발행 기능
- 리소스 로딩 기능

### IoC 컨테이너 : ApplicationContext와 다양한 빈 설정 방법

![스크린샷 2021-12-24 오전 6.44.28.png](12%2024%20IoC%20Container%20f3290baea90640d486a6d6cc3ae417e0/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2021-12-24_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_6.44.28.png)

스프링 IoC 컨테이너의 역할

- 빈 인스턴스 생성
- 의존관계 설정
- 빈 제공

ApplicationContext

- ClassPathXmlApplicationContext (XML로 설정)
- AnnotationConfigApplicationContext (Java)

** @ComponentScan(basePackageClasses = JacksonApplication.class) 

= JacksonApplication.class 가 위치하는 부분부터 스캐닝을 시작해라

** @SpringBootApplication이 붙은 클래스 자체가 설정파일w