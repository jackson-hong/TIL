# 1/16 IT Infra Structure

### 3계층형 아키텍처

- 프레젠테이션 계층, 애플리케이션 계층, 데이터 계층 총 3층의 구조로 분할되어 있다
- 사용자는 브라우저를 통해 접속하며 화면은 프레젠테이션 계층의 **웹서버**에 먼저 전달된다
- 모든 처리 AP 서버나 DB 서버를 이용하지 않아도 된다
- 장점
    - 서버 부하 집중 개선
    - 클라이언트 단말의 정기 업데이트가 불필요
    - ‘처리 반환’에 의한 서버 부하 저감
- 단점
    - 구조가 클라이언트-서버 구성보다 복잡하다

comment : 

안드로이드 - API 서버 구조 → 클라이언트-서버 아키텍처

리액트 프론트 서버 - API 구조 → 3계층

## 수평 분할형 아키텍처

### 단순 수평 분할형 아키텍처

- 용도가 같은 서버를 늘려나가는 방식
- 서버대수가 늘어나면 한 대의 시스템이 주는 영향력이 낮아져 안정성 향상

** 수형 분할형과 수직 분할형은 배타적 관계가 아니며 대부분 시스템이 두 방식을 함께 사용한다

** Sharding(샤딩), Partitioning(파티셔닝) = 수평 분할하는 것을 일컫는다

- 거래상으로 멀리 떨어진 시스템에 자주 이용됨
- 많은 사용자가 있는 SNS 서비스에서 ID 기준으로 Sharding하는 경우가 있다
- 장점
    - 수평으로 서버를 늘리기 때문에 확장성 향상
    - 분할한 시스템이 독립적으로 운영되므로 서로 영향을 주지 않음
- 단점
    - 데이터를 일원화해서 볼 수 없다
    - 애플리케이션 업데이트를 양쪽 동시에 해주어야 한다
    - 처리량이 균등하게 불할돼 있지 않으면 서버별 처리량에 치우침이 생긴다

### 공유형 아키텍처

- 단순 분할형의 아키텍처 구조 중 일부 계층에서 상호 접속이 이루어짐
- ex) 데이터 계층을 동기처리하여 어느 쪽에서든 참조 할 수 있다
- 장점
    - 수평으로 서버를 늘리기 때문에 확장성이 향상된다
    - 분할한 시스템이 서로 다른 시스템의 데이터를 참조할 수 있다
- 단점
    - 분할한 시스템 간 독립성이 낮아진다
    - 공유한 계층의 확장성이 낮아진다

** **엣지 컴퓨팅** **

- 가까운 위치에 있는 서버로 처리를 분산하고 처리 결과만 중앙으로 보내는 아키텍처
- 등장 배경 : 가상화나 데이터 센터 통합, 클라우드로 이전하며 네트워크 대역과 비용이 증가