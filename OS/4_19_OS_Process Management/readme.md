# 4/19 OS - Process Management

Date: April 19, 2022 5:33 AM

### 프로세스 간 협력

- 독립적 프로세스 (Indpendent process)
    - 프로세스는 각자의 주소 공간을 가지고 수행되므로 원칙적으로 하나의 프로세스는 다른 프로세스의 수행에 영향을 미치지 못함
- 협력 프로세스 (Cooperating process)
    - 프로세스 협력 메커니즘을 통해 하나의 프로세스가 다른 프로세스의 수행에 영향을 미칠 수 있음
- 프로세스 간 협력 메커니즘 (IPC : Interprocess Communication)
    - 메시지를 전달하는 방법
        - message passing : 커널을 통해 메시지 전달
    - 주소 공간을 공유하는 방법
        - shared memory : 서로 다른 프로세스 간에도 일부 주소 공간을 공유하게 하는 shared memory 메커니즘이 있음
        
        ** thread : thread는 사실상 하나의 프로세스이므로 프로세스 간 협력으로 보기는 어렵지만 동일한 process를 구성하는 thread들 간에는 주소공간을 공유하므로 협력이 가능
        

### Message Passing

- Message system
    - 프로세스 사이에 공유 변수(shared variable)를 일체 사용하지 않고 통신하는 시스템
    - 커널을 통해 메시지를 전달한다
- Direct Communication
    - 통신하려는 프로세스의 이름을 명시적으로 표시
        
        ![스크린샷 2022-04-19 오전 5.48.25.png](1.png)
        
- Indirect Communication
    - mailbox (또는 port)를 통해 메시지를 간접 전달
        
        ![스크린샷 2022-04-19 오전 5.49.24.png](2.png)
        

### IPC 두가지 방법 구조

- shared memory 방식을 쓰려면 두 프로세스가 신뢰할 수 있는 관계여야 한다.

![3.png)