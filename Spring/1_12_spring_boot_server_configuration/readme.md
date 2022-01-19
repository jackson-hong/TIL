# 1/12 Spring Boot - 원리

### 자동 설정 만들기 : @ConfigurationProperties

** 컴포넌트 스캔 순서에 의해 빈이 덮어쓰기 되는 경우 이를 방지하기 위해서는

→ 덮어쓰기가 되면 안 되는 bean에 @ConditionalOnMissingBean을 달아준다

- Properties 사용하기
    1. properties 파일에 원하는 값들을 입력
    2. properties 값들을 가져올 클래스 생성
    
    ```java
    @ConfigurationProperties("jackson")
    @Getter
    public class JacksonProperties{
    	private String name;
    	private int howLong;
    }
    ```
    
    1. configuration 클래스에서 사용할 프로퍼티 클래스를 주입해준다
    
    ```java
    @Configuration
    @EnableConfigurationProperties(HolomanProperties.class)
    public class JacksonConfiguration{
    	@Bean
    	@ConditionalOnMissingBean
    	public Jackson jackson(JacksonProperties properties){
    		String name = properties.getName();
    	}
    }
    ```
    

### 내장 웹 서버 이해

!! Spring Boot는 서버가 아니다

**서버구현하기**

```java
public static void main(String[] args) throws LifecycleException {
//        SpringApplication.run(JacksonApplication.class, args);

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);

        Context context = tomcat.addContext("/", "/");

        HttpServlet servlet = new HttpServlet() {
            @Override
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                PrintWriter writer = resp.getWriter();
                writer.println("jackson");
            }
        };

        String servletName = "hellowServlet";
        tomcat.addServlet("/", servletName, servlet);
        context.addServletMappingDecoded("/hello", servletName);

        tomcat.start();
        tomcat.getServer().await();
    }
```

이런 일련의 과정을 좀더 상세히 설정하고 실행해주는게 스프링부트 자동 설정

- ServletWebServerFactoryAutoConfiguration(서블릿 웹 서버 생성)
    - TomcatServletWebServerFactoryCustomizer (서버 커스터마이징)
- DispatcherServletAutoConfiguration
    - 서블릿 만들고 등록

### 컨테이너와 포트

- 다른 서블릿 컨테이너로 변경해보기

```xml
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-web</artifactId>
	<exclusions>
		<!-- Exclude the Tomcat dependency -->
		<exclusion>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-tomcat</artifactId>
		</exclusion>
	</exclusions>
</dependency>
<!-- Use Jetty instead -->
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-jetty</artifactId>
</dependency>
```

- 웹 서버 사용 안 하기 - spring.main.web-application-type=none ← properties 파일
- server.port=0 ← 랜덤 포트