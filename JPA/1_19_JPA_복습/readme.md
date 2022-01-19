# 1/19 JPA

### 플러시 모드 옵션

- [FlushModeType.AUTO](http://FlushModeType.AUTO) : 커밋이나 쿼리를 실행할 때 플러시
- [FlushModeType.](http://FlushModeType.AUTO)COMMIT : 커밋할 때만 플러시

** **플러시는 영속성 컨텍스트의 변경 내용을 데이터 베이스에 동기화하는 것** **

 **준영속** : 영속 상태였다가 더이상 영속성 컨텍스트가 관리하지 않는 상태

### 기본 키 매핑

- 기본 키를 직접 할당하려면 @Id만 사용하면 되고, 자동 생성 전략을 사용하려면 @Id + @GeneratedValue 추가
- 직접 할당 : 기본 키를 애플리케이션에 직접 할당한다
- 자동 생성 : 대리키 사용방식
    - IDENTITY : 기본 키 생성을 데이터베이스에 위임
    - SEQUENCE : 데이터베이스 시퀀스를 사용해 기본 키 할당
    - TABLE : 키 생성 테이블 사용

** @Transient : 이 필드는 매핑하지 않는다

** @Lob : DB BLOB, CLOB과 매핑