# REST API란?

Date: June 8, 2022 11:17 PM

### API

Application Programming Interface

애플리케이션 소프트웨어를 구축하고 통합하는 정의 및 프로토콜 세트

### REST

- Roy Fielding 의 2000년 논문에 소개 되었다.
- 현재 아키텍쳐가 웹의 본래 설계 우수성을 많이 사용하지 못하고 있다고 판단하여 나온 논문
- REpresentational State Trasfer
- 인터넷 상의 시스템 간의 상호 운용성을 제공하는 방법 중 하나
    - 서로 다른 시스템 간의 독립적인 진화를 보장할 것인가
- 애초의 로이 필딩이 추구하고자 한 목적은 웹을 깨뜨리지 않으면서 HTTP가 진화하는 방법이다
- JSON, HTML, XLT 또는 일반 텍스트를 통해 몇 가지 형식으로 전송됩니다.
- JSON은 인간과 머신이 모두 읽기 편하기 때문에 가장 널리 사용됨
- 웹의 기존 기술과 HTTP 프로토콜을 그대로 활용하기 때문에 웹의 장점을 최대한 활용하는 아키텍처 스타일

### REST 아키텍처 스타일

- Client-Server
- Stateless
    - HTTP 특성을 이용하므로 무상태성
- Cache 가능 데이터
    - 클라이언트 또는 서버측에서 캐싱할 수 있어야한다. 서버 응답에는 전달된 리소스에 대한 캐싱이 허용되는지 여부에 대한 정보도 포함되어야 함.
- Layered System
- Code-On-Demand (Optional)
- **Uniform Interface**

### Uniform Interface

- Indentification of resources
- manipulation of resources through representations
- self-descriptive messages
- hypermedis as the engine of application state (HATEOS)