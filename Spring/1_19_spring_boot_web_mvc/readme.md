# 1/19 Spring Boot - 테스트 유틸, Web MVC

**@OutputCature**

콘솔의 찍히는 메세지를 assertion할 수 있다

```xml
@Rule
public OutputCapture outputCapture = new OutputCapture();

...

assertThat(outputCapture.toString())
	.contains("jackson");
```

### Spring Web MVC

Spring MVC 와 Spring Boot 가 연동되는 기능

- WebMvcAutoConfiguration 클래스 파일에서 자동 설정으로 여러 기본 기능을 제공해줌
- Spring MVC 확장을 하고 싶다면
    
    ```xml
    @Configuration
    // @EnableWebMvc <- Spring MVC 재정의 하는 어노테이션
    public class WebConfig implements WebMvcConfigurer {
    	...
    }
    ```