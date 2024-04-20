# Database DBMS

[SELECT 데이터 조회](https://www.notion.so/SELECT-86db60d1248747ce92589fc7c67c89a7?pvs=21)

[**single row function**](https://www.notion.so/single-row-function-05cee296744e4eb1b07a0b9bcef61ff8?pvs=21)

[**group function**](https://www.notion.so/group-function-781d46678e9743aaaa8e8eb268c3a553?pvs=21)

---

RAM 이 아니라 HDD 를 사용해야 한다.

- RAM 휘발성 메모리 ? 프로그램 끄면 사라져 버림
    
    데이터를 기록할때 전자를 이용해서 데이터를 보관. 전기가 공급되는 동안에만 데이터 기록
    
- HDD 하드디스크 ? 반영구적(소비적, 일정 시간동안 보관해줌) 보조기억장치
    
    전기를 쓰지 않음. 자력 자성으로 기록함 
    
    마크네틱(자석) 디스크 
    

HDD → RAM 으로 옮기는 건 로딩한다

RAM → HDD 로 옮기는 건 seve 한다 (불러옴) 

- sql developer

Oracle SQL Developer 은 Oracle 데이터베이스에서 SQL 작업을 위한 통합 개발 환경

---

- DBMS Oracle 가 필요한 배경

지금까지 만들었던 프로그램들이 데이터를 저장하는 장비는 RAM 휘발성 메모리이었음

데이터를 반영구적으로 보관하기 위해선 SSD 장비를 이용해서 저장해야함

<aside>
💡 과거

HDD 에 저장하기 위해서 단순 파일에 열거 방식으로 (늘어놓는) 사용

- 문제점[1] `보안성`

해당 파일에 데이터가 보관된다는 것은 누군가 눈치 채면 쉽게 변조 및 탈취가 가능함 

- 문제점[2] `안정성` (프로그램)

프로그램 오동작으로 깨진 데이터 발생 시 해결을 위한 비용 발생 또는 데이터 손실이 발생

- 문제점[3] `성능`

단순 데이터 열거 방식에 의해 데이터 검색 성능이 매우 저조함

</aside>

<aside>
💡 현재

DBMS 사용

과거 저장방식으로 인해 발생하는 모든 문제점을 해결 

</aside>

- DBMS Oracle 특징
1. 최초 설치 이후에 관리자 계정으로 System 계정을 제공받으며 System 계정 최고 관리자로 DBMS 에 대한 모든 권한을 가진다 

1. System 계정은 모든 작업을 수행할 수 있으나, 
    
    보편적으로 데이터 CRUD 는 담당하지 않는다 ❌
    

1. 실제 데이터 CRUD 는 System 계정으로 생성한 서브 계정들에 의해서 관리 됨
2. 생성된 서브 계정들은 자신의 고유 영역을 할당받아 테이블 단위로 데이터를 저장 관리(CRUD) 함 
3. 테이블은 행과 열로 구성되어 있으며, 데이터 저장 시 자료형을 지정해야 함.

DBMS (오라클)

Database 를 관리하는 프로그램 (dto들을 다 보관)

오라클을 편하게 쓰게 해주는 건 → SQL

DBMS(데이터 CRUD 전문 담당 프로그램) → System 

DBMS 를 관리 (입출력 ❌ 그냥 관리만)

DBMS 의 자료형 

숫자 Number

문자열 varchar 

날짜 Date

<aside>
💡 DBMS SQL 을 활용해 시스템을 사용한다

SQL (Structured Query Language) → 줄여서 Query 문 

</aside>

`DDL` Data Definition Language : 객체에 대한 CRUD 를 수행하는 쿼리문 집합 

1. create 객체 생성 
2. alter  객체 수정
3. drop   객체 삭제 

---

`DML` Data Manipulation Language : 데이터에 대한 CRUD 를 수행하는 쿼리문 집합  

- select(DQL)  데이터 조회
- insert  데이터 입력
- update  데이터 수정
- delete  데이터 삭제

---

`DCL` Data Control Language : 계정에 대한 권한 부여 및 회수 쿼리문

- grant 권한 부여
- revoke 권한 회수

---

`TCL` Transaction Control Language 트랜잭션 관리 언어

- commit
- rollback
- savepoint

SQL Structured Query Language 구조화된 요청언어 (DBMS에 요청)

Query (요청) 문 (정식명칭 SQL)

- create user test2 identified by test;
    - 아이디와 패스워드
- geant 권한 부여 connect
- geant connect to
- 계정 지우기
drop user test;

select * from “내가 조회하는”;

계정 생성
create user identified by kh;
권한 부여
grant resource, connect kh;