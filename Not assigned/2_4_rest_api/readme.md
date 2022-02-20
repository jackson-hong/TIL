# 2/4 REST API

**API**

- Application Programming Interface

**REST**

- REpresentational State Transfer
- 인터넷 상의 시스템 간의 상호 운용성(interoperability)을 제공하는 방법 중 하나
- 시스템 제각각의 **독립적인 진화**를 보장하기 위한 방법
- REST API : REST 아키텍처 스타일을 따르는 API

**REST 아키텍처 스타일**

- Client - Server
- Stateless
- Cache
- Uniform Interface
- Layered System
- Code-On-Demand (optional)

**Uniform Interface** 

- Identification of resources
- manipulation of resources through representations
- **self-decriptive messages**
- **hypermedia as the engine of application state (HATEOAS)**

두 문제를 좀 더 알아보자

- Self-decriptive message
    - 메시지 스스로 메시지에 대한 설명이 가능해야 한다
    - 서버가 변해서 메시지가 변해도 클라이언트는 그 메시지를 보고 해석이 가능하다
    - **확장 가능한 커뮤니케이션**
- HATEOAS
    - 하이퍼미디어(링크)를 통해 애플리케이션 상태 변화가 가능해야 한다.
    - **링크 정보를 동적으로 바꿀 수 있다. (Versioning 할 필요 없이)**