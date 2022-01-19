# 1/1 Resource/Validation

### Resource 추상화

특징

- java.net.URL을 추상화 한 것
- 스프링 내부에서 많이 사용하는 인터페이스

추상화 한 이유

- 클래스 패스 기준으로 리소스 읽어오는 기능 부재
- ServletContext를 기준으로 상대 경로로 읽어오는 기능 부재
- 새로운 핸들러를 등록하여 특별한 URL 접미사를 만들어 사용할 수는 있지만 구현이 복잡하고 편의성 메소드가 부족하다.

인터페이스 둘러보기

- 상속 받은 인터페이스
- 주요 메소드
    - getInputStream()
    - exist()
    - isOpen()
    - getDescription() : 전체 경로 포함한 파일 이름 또는 실제 URL

구현체

- UrlResource : 기본으로 지원하는 프로토콜 http, https, ftp, file, jar
- ClassPathResource : 지원하는 접두어 classpath:
- FileSystemResource
- ServletContextResource : 웹 어플리케이션 루트에서 상대 경로로 리소스 찾는다

리소스 읽어오기

- Resource 타입은 location 문자열과 ApplicationContext의 타입에 따라 결정된다
    - ClassPathXmlApplicationContext → ClassPathResource
    - FileSystemXmlApplicationContext → FileSystemResource
    - WebApplicationContext → ServletContextResource
- ApplicationContext 타입에 상관없이 리소스 타입을 강제하려면 java.net.URL 접두어 중 하나를 사용할 수 있다.
    - **classpath**:jackson/me/config.xml → ClassPathResource
    - **file**:///some/resource/path/config.xml → FileSystemResource

### Validation 추상화

어플리케이션에서 사용하는 객체 검증용 인터페이스 (데이터 바인딩에서 많이 봄)

특징

- 어떠한 계층과도 관계가 없다 → 모든 계층 (웹, 서비스, 데이터)에서 사용해도 좋다
- 구현체 중 하나로 JSR-303, JSR-349를 지원한다
- DataBinder에 들어가 바인딩 할 때 같이 사용되기도 한다

인터페이스

- boolean supports(Class clazz) : 어떤 타입의 객체를 검증할 때 사용할 것인지 결정함
- void validate(Object obj, Errors e) : 실제 검증 로직을 이안에서 구현

스프링 부트 2.0.5 이상 버젼을 사용하면..

- LocalValidatorFactoryBean 빈으로 자동 등록
- Validator를 빈으로 불러와서 해당 객체에 어노테이션(@Size, @Min, @Email, ...)를 필드에 붙여서 편리하게 사용 가능하다