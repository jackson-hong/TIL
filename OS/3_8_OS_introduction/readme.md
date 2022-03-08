# 3/8 OS - Introduction

Date: March 8, 2022 6:39 AM

### 몇 가지 용어

- Multitasking
    - 하나의 프로그램이 끝나기 전에 다른 프로그램이 진행되는 것
- Multiprogramming
    - Multitasking과 원론적으로 같은 말이나 메모리 측면을 강조할 때 쓰는 말
    - 메모리에 여러 프로그램이 동시에 올라가서 process하는 것
- Time sharing
    - Multitasking과 원론적으로 같은 말이나 CPU 측면을 강조하는 말
    - 시간을 시분할하여 쓰는 것
- Multiprocess
- Multiprocessor : 하나의 컴퓨터에 CPU가 여러개 붙어 있음을 의미

### 운영체제의 예

- UNIX
    - 멀티태스킹과 여러 사용자를 지원하기 위해 만들어짐
    - 코드 대부분을 C언어로 작성
        - C언어는 유닉스를 만들기 위해 만들어진 언어이다
        - OS를 만듬에 있어 어셈블리가 필요했지만 어셈블리가 어려워서 좀 더 쉽게 만들고자 C언어를 개발함
        - 기계언어와 가깝고 사람언어와도 가깝다
    - 높은 이식성
        - 하나의 컴퓨터에서 돌아가는 유닉스를 기계어 집합이 다른 컴퓨터에도 이식이 가능하다
    - 최소한의 커널 구조
    - 복잡한 시스템에 맞게 확장 용이
    - 소스 코드 공개
    - 프로그램 개발에 용이
    - 다양한 버전
        - System V, FreeBSD, SunOS, Solaris
        - Linux
- DOS
    - 단일 사용자, 단일 작업을 지원하기 위해 만들어짐