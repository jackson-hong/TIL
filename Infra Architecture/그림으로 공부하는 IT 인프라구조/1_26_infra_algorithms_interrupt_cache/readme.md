# 1/26 IT Infra - 알고리즘, 캐시, 끼어들기

Created: January 26, 2022 5:53 AM

### 탐색 알고리즘(해시/트리)

- 해시나 트리는 탐색 알고리즘이 아닌 데이터 구조이지만, 효율적 탐색을 위해 사용된다.
- 데이터 정리 방법 - 데이터 구조, 찾는 방법 - 탐색 알고리즘
- 어디에 사용되나?
    - DBMS 인덱스 스캔 (B 트리 인덱스)
        - 인덱스가 없이 스캔하는 경우(풀 스캔) 모든 데이터를 공유 메모리에 올려서 확인한다
        - 인덱스가 있는 경우 필요한 데이터가 있는 곳을 메모리에 올려 확인한다
        - 익덱스는 트리 구조로 관리되기 때문에 모든 데이터를 취득해야 하는 경우 엑세스 해야 할 블록이 되려 더 늘어나므로 풀 스캔에 비해 I/O 횟수가 많아져 속도가 느려진다
        - ** 인메모리의 경우 모든 데이터를 메모리 DB에 옮겨 쓰는 것!

### 캐시

- 캐시는 임시 저장소를 의미한다. “바로 사용할 테니 일단 여기 두자!”
- 어디에 사용되나?
    - 웹 브라우저
    - CDN(Content Delivery Network) ← 캐시 서버군에 웹 콘텐츠 캐시를 배치
- 데이터를 고속으로 엑세스 할 수 있다
- 실제 데이터에 대한 엑세스 부하를 줄일 수 있다
- 적합한 시스템
    - 참조 빈도가 높은 데이터
    - 데이터가 손실 돼도 문제가 없는 시스템
- 부적합한 시스템
    - 데이터 갱신 빈도가 높은 시스템
    - 대량의 데이터에 엑세스하는 시스템

### 끼어들기

- 현재 하고 있는 일을 중단하고 급히 다른 일을 하는 것
- 예를 들어 컴퓨터가 프로세스를 구동 중일 때 키보드를 누르면 입력되는 것
- 이벤트 드리븐 형식으로 이뤄진다
- 어디에 사용되나?
    - 네트워크 통신시 NIC에 데이터가 도착한 경우 NIC는 CPU에 끼어들기를 발생시켜 데이터를 수신한다

### 폴링

- 정기적으로 질의(poll)하는 것
- 질의는 단방향으로 이뤄지며 정기적으로 발생한다
- 프로그래밍이 쉽고 상대가 응답하는지 확인이 가능하며 일괄적으로 처리할 수 있다