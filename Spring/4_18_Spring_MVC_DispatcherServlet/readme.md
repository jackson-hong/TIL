# 4/18 Spring MVC - DispatcherServlet

Date: April 18, 2022 12:17 PM

### DispatcherServlet 동작원리

DispatcherServlet 초기화

- HandlerMapping : Handler를 찾아주는 인터페이스
- HandlerAdaptor : Handler를 실행하는 인터페이스
- HandlerExceptionResolver

DispatcherServlet 동작 순서

1. 요청을 분석한다. (로케일, 테마, 멀티파트 등)
2. (핸들러 매핑에게 위임하여) 요청을 처리할 핸들러를 찾는다.
3. (등록되어 있는 핸들러 어댑터 중에) 해당 핸들러를 실행할 수 있는 “핸들러 어댑터"를 찾는다.
4. 찾아낸 “핸들러 어댑터"를 사용해서 핸들러의 응답을 처리한다.
5. (부가적으로) 예외가 발생했다면, 예외 처리 핸들러에 요청 처리를 위임한다.
6. 핸들러의 리턴값을 보고 어떻게 처리할지 판단한다.
    - 뷰 이름에 해당하는 뷰를 찾아서 모델 데이터를 렌더링한다.
    - @ResponseEntity가 있다면 Converter를 사용해서 응답 본문을 만들고
7. 최종적으로 응답을 보낸다.