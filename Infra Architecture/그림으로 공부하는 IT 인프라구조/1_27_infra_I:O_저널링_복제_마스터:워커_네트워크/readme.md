# 1/27 IT Infra - I/O 크기, 저널링, 복제, 마스터-워커, 압축, 네트워크

### I/O 크기

1회의 I/O에 필요한 사이즈를 의미한다

- I/O 크기는 인프라 설계나 성능 튜닝에 있어 중요한 개념
- 예를 들어 3톤의 짐을 1톤 트럭으로 운반하는 경우 3번이나 왕복해야 하기 때문에 효율적이지 못하다
- 그러므로 운반하는 양에 따라 **유동적으로 크기를 선택하는 경우 효율적**으로 운반할 수 있다
- 어디에 사용되나?
    - Oracle DB
        - 오라클 DB가 데이터 파일을 읽기/쓰기하는 최소 단위를 **데이터 블록**이라고 한다
        - OS 데이터 블록 크기와 DB 데이터 블록 크기가 상이할 경우 I/O 크기를 고려해야 한다
        - 예를 들어 DB 블록이 8KB 이지만 OS 데이터 블록이 7KB일 경우 OS는 총 14K를 읽어야한다
    - 네트워크
        - OS 소켓통신시 소켓 버퍼가 차면 TCP 세크먼트로 분할 되고 TCP, IP, MAC 헤더가 붙어 이더넷 프레임에 넣어 전송된다
        - 소켓의 최대 크기를 MTU(Maximum Transfer Unit)이라고 함
        - 송신 중 라우터의 MTU 크기가 전송된 이더넷 프레임의 크기보다 작은 경우 패킷이 분할되기 때문에 성능 저하 이슈가 발생할 수 있다

### 저널링

트랜젝션이나 데이터 변경 이력을 가르킨다

- 데이터 자체가 아닌 **처리 내용을 기록**함
- 데이터 복구 시 롤백 or 롤포워드가 이용된다
- 시스테 장애 시 **복구가 빠르다**
- 데이터 복제보다도 **적은 리소스를 소비하여 데이터를 보호**할 수 있다
- **데이터 갱신이 발생하는 시스템에 적합**하다
- 성능을 요구하는 시스템에는 적합하지 않다

### 복제

데이터 보호나 부하 분산 위해 **인프라를 복사**하는 것

- 데이터가 없어져도(**장애시) 복사본으로 대체**할 수 있다
- 복제한 데이터를 읽게 하여 **부하를 분산**할 수 있게 해준다
- 복제한 데이터를 **캐시처럼 사용**할 수 있다
- 데이터를 최우선을 하는 경우 쓰기 처리시 데이터가 **복제되기까지 기다려야 하는 모드**도 있다
- 적합한 시스템
    - 데이터 손실을 허용하지 않고 장애 시 복구 속도가 빨라야 하는 시스템
    - 데이터 참조와 갱신 부분이 나뉘어져 있으며, 참조가 많은 시스템
        
        : 위치 서버를 여러 대 구축해서 부하를 분산하고 확장성을 향상시킬 수 있다
        
- 부적합한 시스템
    - 데이터 갱신이 많은 시스템
        
        : 복제 대상 데이터가 많아지기 때문에 오버헤드가 높아짐
        

### 마스터 - 워커

한쪽이 관리자가 되어 다른 모든 것을 제어한다

- 마스터-워커 의 반대말을 피어 투 피어이다
- 관리자가 한 명이기 때문에 구현이 쉽다
- 워커 간 처리를 동기화할 필요가 없기 때문에 통신량이 줄어든다
- 마스터가 없어지면 관리를 할 수 없다
- 마스터의 부하가 높아진다

### 압축

**‘중복 패턴 인식’하여 그것을 효율적으로 ‘변경’하는 것**

- Central Processing Unit → CPU 이 또한 압축이라고 볼 수 있다
- **같은 패턴이 많을수록 압축률이 높아진다**
- JPEG 등의 이미지 파일은 이미 압축돼 있어서 중복 패턴이 거의 없는 상태로 압축해도 크기에 변화가 없다
- 압축하기 전에 데이터 전체를 쭈욱 읽어야 하기 때문에 시간이 소요된다
- **가역 압축**과 **비가역 압축**이 존재한다
    - 가역 압축 - 위와 같은 압축 방식
    - 비가역 압축 - 원래 상태로 복구할 수 없는 압축상태 (음성 데이터)

## 네트워크

- 서로 다른 장비간 데이터 교환시 네트워크 경유는 필연적이다
- 3계층형 시스템에서는 대부분 TCP/IP 구조를 사용한다

### 계층구조

- 컴퓨터 세계에서 계층 구조(계층 모델)을 쉽게 발견할 수 있다
- 계층 구조는 담당하는 일만 책임 지고 다른 계층과는 인터페이스만 공유한다
- OSI(Open System Interconnection) 7계층
    - 현재 사용되고 있지 않음
    - 하지만 다양한 분야에서 공통적으로 참조할 수 있는 참조모델
    - OS에서도 시스템 계층 구조를 사용한다 (Application - JVM - Kernel - Hard Ware)

### 프로토콜

컴퓨터가 서로 소통하기 위한 규약

- 떨어진 곳에 있는 두 개의 장비는 사전에 절차를 정해 두지 않으면 서로 통신할 수 없다
- 여러가지 하드웨어가 통신하기 위해서는 프로토콜을 일치시켜야 한다
    
    → 표준화 단체 (IEEE, IETF)