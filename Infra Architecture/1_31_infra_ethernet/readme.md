# 1/31 IT Infra - Ethernet

### Ethernet

**링크 계층**에서 사용되는 대표적 프로토콜

** 무선 랜 프로토콜은 이더넷이 아니다

** **OSI 7계층 모델의 물리 계층**과 밀접한 관계가 있다

- 역할
    - 동일 네트워크 내의 네트워크 장비까지 전달 받은 데이터를 운반한다
    - 케이블 통신에 사용되기 때문에 전기 신호로 전송된다
    - 동일 내트워크 내, 자신이 포함된 링크 내에서만 데이터를 전송할 수 있다
    - 이 때 사용되는 주소가 **MAC 주소**다
- 흐름
    - 커널 공간 내에서 이더넷 헤더를 IP 패킷에 추가한다
    - 이더넷 헤더에는 목적지의 MAC주소가 기입되어 있다
    - 최종적으로 OS가 버스를 통해 이더넷 프레임을 NIC에 전송하고 네트워크로 전송한다

### TCP/IP를 이용한 통신 이후

- 같은 네트워크 내에 L2(2계층 레이어) 스위치가 존재하는데 L2는 이더넷 계층이므로 MAC주소 확인 후 프레임을 전송한다
- 스위치에는 ASIC이라고 하는 특별한 회로를 가지고 있어 빠르게 패킷을 전송한다
- 다른 네트워크로 전송하는 경우 L3스위치나 라우터가 존재하며 IP 헤더를 확인하여 목적지를 결정한다