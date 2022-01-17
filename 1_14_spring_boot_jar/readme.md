# 1/14 Spring Boot - JAR

### 독립적으로 실행 가능한 JAR

- mvn package → JAR 파일 생성
- 수많은 의존성이 JAR 파일 하나에 다 들어있다
- 스프링 부트의 전략
    - 내장 JAR : 기본적으로 자바에는 내장 JAR를 로딩하는 표준적인 방법이 없다
    - 어플리케이션 클래스와 라이브러리 위치 구분
    - org.springframework.boot.loader.jar.JarFile을 사용해서 내장 JAR를 읽는다
    - org.springframework.boot.loader.Louncher를 사용해서 실행한다
- 모든 JAR파일의 시작점은 MANIFEST.MF 파일 ← 로딩에 대한 정보가 담겨있다

** pom.xml → parent → spring-boot-dependency : spring boot에서 필요한 모든 디펜던시의 버젼 관리

** spring boot dependency에 명시된 디펜던시를 사용하게 되면 버젼을 따로 명시하지 않아도 됨

### SpringApplication

- 기본 로그 레벨이 INFO이므로 DEBUG로 보고 싶다면 VM options : -Ddebug
- 배너
    - resources/banner.txt | gif | jpa | png
    - classpath 또는 spring.banner.location
    - ${spring-boot.version}등의 변수를 사용할 수 있다
    - Banner 클래스 구현하고 SpringApplication.setBanner()로 설정 가능.
- SpringApplicationBuilder로 빌더 패턴 사용 가능

```xml
public static void main(String[] args) {
	new SpringApplicationBuilder()
			.sources(SrpingApplication.class)
			.run(args);
}
```

- ApplicationEvent 등록
    - ApplicationContext가 만들어지기 전에 사용하는 리스너는 @Bean으로 사용될 수 없다
    - 리스너로 등록 → SpringApplication.addListener
        
        ```xml
        SpringApplication app = new SpringApplication(SpringinitApplication.class);
        app.addListeners(new SampleListener());
        app.run(args);
        ```
        

** ApplicationListener <ApplicationStartingEvent> 상속 객체 - Not Bean

** ApplicationListener <ApplicationStartedEvent> 상속 객체 - Is Bean

- WebApplicationType 설정
    
    : SERVLET이 최우선적으로 설정됨 그 다음이 REACTIVE...ㅠㅡㅜ 같이 쓰고 싶었는데!!!
    
    ```xml
    SpringApplication app = new SpringApplication(SpringinitApplication.class);
    app.setWebApplicationType(WebApplicationType.SERVLET);
    app.run(args);
    ```
    

comment : 현재 프로젝트에서 SERVLET과 REACTIVE를 혼합해서 쓰고 싶었는데 불가능하다는 걸 알게됐다
