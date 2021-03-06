# 2/1 IT Infra - 이중화

### 안정성이란

안정성, 고가용성이란 시스템 서비스가 가능한한 멈추지 않도록 하는 것을 말한다

### 목표

- 고장, 장애에 의한 정지가 발생하지 않을 것
- 고장, 장애가 발생해도 복구할 수 있을 것
- 고장, 장애가 발생한 것을 검출할 수 있을 것
- 고장, 장애가 발생해도 데이터가 보호될 것

→ 이중화, 감시, 백업 이 세가지 수단을 이용하여 위의 4가지 목표를 실현하고 있다

### 이중화란

하나의 기능을 병렬로 여러 개 나열하여 하나에 장에가 발생해도 다른 것을 이용해서 서비스를 계속할 수 있는 것

- 이중화에 필요한 구조
    - 부하분산
    - 내부적 생존 감시
    - 마스터 결정
    - 페일 오버

### 서버 내 이중화

일반적인 서버 내부 컴포넌트에서는 전원, 팬 등이 이중화 되어 하나가 망가져도 서버가 정상 가동하도록 되어있음

- 분전반이나 UPS(정전 시 이용하는 대규모 충전지)에 접속돼있어 전원 장애에 대비한다