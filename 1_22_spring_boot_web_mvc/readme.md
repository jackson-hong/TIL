# 1/22 Spring Boot : Spring Web MVC

### HttpMessageConverter

: HTTP 요청 본문을 객체로 변경하거나, 객체를 HTTP 응답 본문으로 변경할 때 사용.

- @RequestBody
- @ResponseBody

** @RestController가 아닌 @Controller를 사용할 경우 응답 본문으로 객체를 보내고 싶을 경우

```java
@GetMapping("/hello")
public @ResponseBody String hello(){
	return "hello";
}
```

- WebMvcTest를 테스트하며 알게된 점
    - WebMvcTest는 슬라이싱 테스트 도구이기 때문에 지정된 어노테이션만 스캔한다
    
    ```java
    @Controller, @ControllerAdvice, @JsonComponent, 
    @Converter, @GenericConverter, @Filter, @HandlerInterceptor,
    @WebMvcConfigurer, @HandlerMethodArgumentResolver
    ```
    
    - 그러므로 Controller에 주입되고 있는 Bean이 상위 어노테이션이 달려있지 않을 경우 `UnsatisfiedDependencyException`이 발생한다
    - 해결책
        1. `@WebMvcTest(UserController.class)` 어노테이션에 테스트하고 싶은 컨트롤러를 명시해주어 필요한 Bean의 범위를 줄여준다
        2. 필요한 빈은 `@MockBean` 어노테이션을 사용해서 주입해준다
        
        ```
        @MockBean
        ServiceChannelManager serviceChannelManager;
        ```