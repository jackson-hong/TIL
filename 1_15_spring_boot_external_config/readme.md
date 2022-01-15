# 1/15 Spring Boot - 외부 설정

**사용할 수 있는 외부 설정**

- properties
- YAML
- 환경 변수
- 커맨드 라인 아규먼트

**프로퍼티 우선 순위**

1. 홈 디렉토리에 있는 spring-boot-dev-tools.properties
2. 테스트에 있는 @TestPropertySource
3. @SpringBootTest 애노테이션의 properties 어트리뷰트
4. 커맨드 라인 아규먼트
5. SPRING_APPLICATION_JSON (환경 변수 또는 시스템 프로퍼티) 에 들어있는 프로퍼티
6. ServletConfig 파라미터
7. ServletContext 파라미터
8. java:comp/env JNDI 어트리뷰트
9. System.getProperties() 저버 시스템 프로퍼티
10. OS 환경 변수
11. RandomValuePropertySource
12. **JAR 밖에 있는 특정 프로파일용 application properties**
13. **JAR 안에 있는 특정 프로파일용 application properties**
14. **JAR 밖에 있는 application properties**
15. **JAR 안에 있는 application properties**
16. @PropertySource
17. 기본 프로퍼티 (SpringApplication.setDefaultProperties)

** 테스트 코드가 패키징 되어 실행될 때 test 디렉토리만 패키징된다

** source 쪽에 존재하는 properties를 테스트코드에서 불러오고 싶을 땐 로케이션을 지정해준다

[**application.properties](http://application.properties) 우선 순위**

1. file:./config
2. file:./
3. classpath:/config
4. classpath:/

**랜덤값 설정하기** 

- ${random.*}

**플레이스 홀더**

- name = jackson
- fullName = ${name} hong

**타입-세이프 프로퍼티 @ConfigurationProperties**

- 여러 프로퍼티를 묶어서 읽어올 수 있다
- 빈으로 등록 가능
    - 컴포넌트 스캔을 시작하는 클래스에서 EnableConfigurationProperties로 지정을 해줘야하지만 `@SpringBootApplication` 여기에 들어있음