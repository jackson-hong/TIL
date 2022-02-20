# 1/28 Spring Boot - Rest Client

- RestClient - Spring 에서 제공, Spring Boot는 Bean으로 등록해줌
- Spring Boot는 RestTemplateBuilder, WebClientBuilder를 빈으로 등록해줌
- WebClient 사용법

```java
Mono<String> helloMono = webClient.get().url("http://localhost:8888/hello)
									.retrieve()
									.bodyToMono(String.class)
hellowMono.subscribe(s -> {
	...
})
```

- 문서 :

[Web on Reactive Stack](https://docs.spring.io/spring/docs/current/spring-framework-reference/web-reactive.html#webflux-client)

- 웹클라이언트를 사용시에 Bean으로 가져와서 쓰는게 좋다

```java
@Component
public class Jackson {
...
private WebClient webclient;

public Jackson(WebClientBuilder builder){
	this.webclient = builder.build();
}
...
}
```

** pom에서 왼쪽에 화살표가 있으면 버젼이 명시되어있다는 말

회사에서 Spring Boot Admin 설치해볼 것