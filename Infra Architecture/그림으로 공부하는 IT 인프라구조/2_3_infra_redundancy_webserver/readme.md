# 2/3 IT Infra - 웹 서버 이중화

### 웹 서버 이중화

- 서버 이중화
    - DNS 라운드 로빈 - 호스트 명에 복수의 IP 주소를 등록
        
        → 질의에 대해 순서대로 IP주소를 반환한다
        
        → 서버 상태를 감시하지 않으므로 서버가 정지된 경우에도 그 서버의 주소를 반환
        
        → 세션 상태를 파악하지 않으므로 동일 서버에 접속해야 하는 경우 부적합
        
    - 로드 밸런서를 통한 부하 분산
        
        → 요청 데이터를 읽어서 같은 서버에 요청하는 기능 (퍼시스턴스 persistence)
        
        → 주요 퍼시스턴스 - 소스 IP 주소, 쿠키, URL
        
        - 소스 IP : 클라이언트 IP 주소를 기반으로 할당할 웹 서버 결정
        - HTTP 헤더 내에 접속한 웹 서버 정보를 저장한다
        - URL 구조 내에 접속한 웹 서버 정보를 저장
        
        → 로드 밸런서의 할당 알고리즘
        
        - 라운드 로빈 : 서버 IP 주소에 순서대로 요청을 할당
        - 최소 연결 : 현재 활성 세션 수보다 세션 수가 가장 적은 서버의 IP 주소에 요청 할당
        - 응답 시간 : 서버의 CPU 사용률이나 응답 시간 등을 고려해서 가장 부하가 적은 서버의 IP 주소에 요청을 할당

### AP 서버 이중화

- 서버 이중화
    - **세션 정보 이중화**
        
        → Oracle WebLogic Server의 경우 AP 서버1 에서 세션이 생성되면 AP 서버2에 세션을 복제한다
        
        → 장애 발생 시 복제된 세션이 할당된 AP서버를 활용한다