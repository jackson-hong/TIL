# 1/11 Spring Boot - 원리

** @SpringBootConfiguration = @Configuration

** @`SpringBootApplication` ← 주로 사용되는 이 어노테이션 안에 

```java
@EnableAutoConfiguration // 이렇게 중요한 두가지 어노테이션이 존재한다
@ComponentScan(
    excludeFilters = {@Filter(
    type = FilterType.CUSTOM,
    classes = {TypeExcludeFilter.class}
)
```

- Bean scan은 두 단계로 나뉜다
    1. @ComponentScan
        1. 컴포넌트 스캔은 이 어노테이션이 있는 클래스를 시작으로 하위 패키지로 읽어들어간다
    2. @EnableAutoConfiguration
        1. maven 으로 받아온 springframework.boot.autoconfigure 디펜던시의 spring.factories를 확인해보면 이 어노테이션으로 받아오는 모든 빈들을 확인할 수 있다
        2. 모든 bean들이 생성되는게 아닌 conditional하게 생성된다

### Starter와 AutoConfigure 구현해보기

1. 의존성을 추가

```xml
<dependencies>
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-autoconfigure</artifactId>
   </dependency>
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-autoconfigure-processor</artifactId>
       <optional>true</optional>
   </dependency>
</dependencies>

<dependencyManagement>
   <dependencies>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-dependencies</artifactId>
           <version>2.0.3.RELEASE</version>
           <type>pom</type>
           <scope>import</scope>
       </dependency>
   </dependencies>
</dependencyManagement>
```

1. @Configuration 파일 작성

```java
@Configuration
public class JacksonConfiguration {
	@Bean
	public Jackson jackson(){
		Jackson jackson = new Jackson();
		return jackson;
	}
}
```

1. src/main/resource/META-INF 에 spring.factories 파일 생성
2. spring.factories 안에 자동 설정 파일 추가

```java
org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
me.jackson.JacksoConfiguration
```

1. mvn install
2. 이후 다른 프로젝트에서 디펜던시에서 가져 오면 jackson 을 autowired하여 사용할 수 있다

** Application 클래스에서 bean을 등록할 경우 Application에서 Component 스캔을 통해 최초로 빈스캔이 일어나므로 이 후에 다른 클래스나 EnableAutoConfiguration 시점에서 같은 빈이 생성될 경우 덮어쓰기 된다