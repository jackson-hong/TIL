# 1/18 Spring Boot 테스트

도메인 → 엔티티랑 비슷한 말 (자바 기준)

### 테스트

- 디펜던시 확인 : spring-boot-starter-test
- scope - test
- @SpringBootTest
    - @RunWith(SpringRunner.class)와 함께 써야 함
    - @SpringBootApplication 어노테이션을 찾아서 컴포넌트 스캔을 시작함
    - webEnvironment
        - MOCK : mock servlet environment(default) : 내장 톰캣 구동 안 함
        - RANDOM_PORTm DEFINED_PORT : 내장 톰캣 사용 - TestRestTemplate을 쓴다면 톰캣을 띄워야 합니다
        - NONE : 서블릿 환경 제공 안 함
- MockBean
    - ApplicationContext에 들어있는 빈을 Mock으로 만든 객체로 교체
    - 모든 @Test마다 자동 리셋

** WebTestClient - API가 쓰기 편하므로 컨트롤러 테스트시 많이 써보자

- 슬라이스 테스트 : “필요한 부분만 테스트하고 싶다”
    - @JsonTest
    - @WebMvcTest - controller만 등록됨 - 서비스는 mock bean으로 등록해주자
    - @WebFluxTest
    - @DataJpaTest