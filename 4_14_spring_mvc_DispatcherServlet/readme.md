# 4/14 Spring MVC - DispatcherServlet

Date: April 14, 2022 6:41 AM

### DispatcherServlet

서블릿 애플리케이션에 스프링 연동하기

- 서블릿에서 스프링이 제공하는 IoC 컨테이너 활용하기
- 스프링이 제공하는 서블릿 구현체 DispatcherServlet 사용하기

근데 리스너란 뭘까?

- 리스너
    - 특정 이벤트가 발생하기를 기다리다 실행되는 컨포넌트(메서드나 함수)
    - 이벤트가 살생홤과 동시에 특정 행동을 하는데 이것을 이벤트 핸들링이라고 함.
    - 클라이언트로부터 요청(이벤트)가 발생했을 때 실행되는 Servlet도 일종의 리스너
    - ServletContextListener
        - 웹 어플리케이션의 시작, 종료 이벤트에 대한 이벤트 리스너
        - ServletContext에 대한 참조를 얻을 수 있다
        - 스프링의 컨텍스트인 ContextLoaderListener 또한 ServletContextListener의 구현체다

서블릿으로 생각해보는 스프링 부트와 스프링의 차이

- 스프링 부트는 내장톰캣을 사용한다 - Spring이 먼저 실행되고 그 이후에 코드로 구현되어있는 톰캣이 Servlet과 함께 실행된다. (스프링 안에 톰캣과 Servlet이 존재하는 개념)
- 스프링 MVC는 Servlet에 Spring을 넣어주는 개념