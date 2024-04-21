select * from employee;
-- 함수 (Function)

--length : 인자로 전달된 데이터의 길이값을 반환하는 함수
select 'Hello' from dual;
select length('Hello') from dual; --5
select length('안녕하세요') from dual; --5

--lengthb : 인자로 전달된 데이터의 바이트수를 반환하는 함수
select 'Hello' from dual;
--한 글자에 1바이트 
select lengthb('Hello') from dual; --5 
--한 글자에 3바이트 
select lengthb('안녕하세요플레') from dual; --21 

-- instr 문자열 안에서 문자열을 검색하여 위치를 반환  
-- 두번째 인자 : 어떤 걸 찾고 싶은지?
-- 세번째 인자 : 찾기 시작하는 위치 값  
-- 세번째 인자 : 두번째로 만나는 H의 위치를 받겠다 
select instr('Hello Oracle Hi','Or',1,1) from dual; --14

-- substr 문자열 내에서 문자열을 추출  
select substr('Hello Oracle Hi',2,2) from dual; --el


-- 숫자 관련 함수
-- abs 절대값 함수 
select -1 from dual; -- -1
select abs(1) from dual; -- 1

-- mod : 나머지를 구하는 함수 
select mod(10,3) from dual; --1

-- round : 반올림 함수 
select round(123.456,3) from dual; --123.456
select round(123.456,2) from dual; --123.46
select round(123.456,1) from dual; --123.5
select round(123.456,0) from dual; --123
select round(123.456,-1) from dual; --120

-- floor : 버림 함수 
select floor(123.45) from dual; --123

-- trunc : 지정 위치에서 버림 함수 
select trunc(123.456,1) from dual; --123.4
select trunc(123.456,2) from dual; --123.45
select trunc(123.456,3) from dual; --123.456

-- ceil 정수의 영역으로 올림 함수 
select ceil(123.556) from dual; --124


-- 날짜 관련 함수 
-- sysdate 현재날짜 + 현재시간을 가지는 값을 반환
-- 단순 출력에는 시간까지는 눈에 보이지 않지만 내부적인 값은 존재함 
select sysdate from dual; --24/04/20
--months_between : 인자로 전달 된 두 날짜 사이의 개월 수를 반환 
select 
    emp_name,
    floor(months_between(sysdate,hire_date))  --근속월수 
from employee; 

--add_months : 첫번째 인자 날짜에 , 두번째 인자로는 숫자 개월 수를 더해서 반환 
select add_months(sysdate,2)  -- 월 + 2
from dual; 

--next_day : 인자로 전달받은 날짜에 , 인자로 전달받은 가장 가까운 다음 요일 반환 
select next_day(sysdate,'토')  -- 24/04/27
from dual; 

--last_day : 인자로 전달받은 날짜가 속해있는 달의 가장 마지막 날짜 반환 
select last_day(sysdate)  -- 24/04/30
from dual; 
--다음 달 마지막
select last_day(add_months(sysdate,1))  -- 24/04/30
from dual; 

-- extract : 날짜 값으로부터 연월일 값을 독립적으로 추출 
select extract(year from sysdate) from dual; -- 년 추출 
select extract(month from sysdate) from dual; -- 월 추출 
select extract(day from sysdate) from dual; -- 일 추출 


-- 형변환 함수 
-- to_char 숫자 또는 날짜를 문자열로 변환 
select to_char(sysdate,'yyyy"년"mm"월"dd"일"') from dual; --2024년04월21일
select to_char(sysdate,'yyyy"년"mm"월"dd"일" hh:mi:ss') from dual; --2024년04월21일 04:39:01



-- Quiz 1
-- 직원들의 사번 및 이름 출력
select emp_id ,substr(emp_name,1,1) from employee;

-- 남자직원의 주민번호 뒷자리를 * 로 출력 
select emp_id, emp_name, substr(emp_no,1,8) || '******'
from employee
where substr(emp_no,8,1) in ('1','3');


--Quiz 2 
select 
    emp_name as 이름, 
    extract(year from hire_date) || '년' || extract(month from hire_date) || '월' || extract(day from hire_date) || '일' as 입사일,
    ceil((sysdate-hire_date)/365) ||'년차' as 년차
from employee
order by hire_date;


select 
    emp_name as 직원명,  
    extract(year from hire_date)||'년 '||
    extract(month from hire_date)||'월' as 입사년월
from employee;


-- 사원명 고용일 출력 
-- 조건 고용일은 1990/02/01(화) 형태로 출력
select emp_name 사원명, to_char(hire_date,'yyyy/mm/dd(day)') 고용일 
from employee;

select to_char(100000,'L999,999') from dual;
select to_char(to_date('20130408','yyyymmdd'),'day') from dual;


-- Quiz 3 
-- 직원명과 이메일 이메일 길이를 출력 
select emp_name 직원명, email 이메일, length(email) 이메일길이
from employee;
-- 직원의 이름과 이메일 주소중 아이디 부분만 출력
select emp_name 직원명, substr(email,1,instr(email,'@', 1, 1)-1) 아이디
from employee;
-- 직원명과 주민번호를 조회 
-- 단 주민번호 9번째 자리부터는 * 로 
select emp_name 직원명, substr(emp_no,1,8)||'******' 주민번호 
from employee;
-- 직원명과 입사년월을 출력하세요 
select emp_name 직원명, to_char(hire_date,'yyyy"년"dd"월"') 입사년월  
from employee;
-- 직원명 입사일 오늘까지의 근무일수 조회
select emp_name 직원명, hire_date 입사일, floor(sysdate-hire_date) 오늘까지근무일수 
from employee;

select emp_name 직원명, substr(email,1, instr(email,'@',1,1)-1) 아이디 from employee;

-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하세요.
select 
    emp_name 이름,
    emp_no 주민번호,
    salary 급여,
    hire_date 입사일
from employee
where (sysdate - hire_date)/365 between 5 and 10;

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드를 검색하세요 (퇴사 여부 : ENT_YN)
select 
    emp_name 이름,
    emp_no 부서코드
from employee
where ent_date is not null;

-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하세요.
-- 단, 급여는 50% 인상된 급여로 출력되도록 하세요.
select 
    emp_name 이름,
    salary*0.5 급여,
    floor((sysdate-hire_date)/365) 근속년수
from employee
where (sysdate-hire_date)/365 >= 10
order by hire_date desc;

-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하세요.
select 
    emp_name 이름,
    emp_no 주민번호,
    email 이메일,
    phone 폰번호,
    salary 급여
from employee
where hire_date between '99/01/01' and '10/01/01' and salary < 2000000;

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하세요.
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력하세요.
select 
    emp_name 이름,
    emp_no 주민번호,
    salary 급여,
    nvl(dept_code,'없음')부서코드,
    emp_no 주민번호
from employee
where salary between 2000000 and 3000000 and substr(emp_no,8,1) = 2 and substr(emp_no,4,1) = 4
order by emp_no desc;

-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하세요.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하세요.
select 
    emp_name 이름,
    floor((sysdate - hire_date)/1000) * (salary * 0.10) 특별보너스
from employee
where substr(emp_no,8,1) = 1 and bonus is null
order by emp_name desc;


-- 1. 직원명과 이메일, 이메일 길이를 출력하세요
select emp_name 직원명, length(email) 이메일 
from employee;

-- 2. 직원의 이름과 이메일 주소 중 아이디 부분만 출력하세요
select emp_name 직원명, substr(email,1, instr(email,'@',1,1)-1) 이메일 
from employee;

-- 3. 60년생의 직원명과 년생, 보너스율을 출력하세요
-- 보너스 값이 NULL인 경우에는 0%라고 출력되게 만드세요
select emp_name 직원명, emp_no 년생, nvl(bonus,0)||'%' 보너스율 
from employee
where substr(emp_no,1,1) = 6;

-- 4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하세요 (뒤에 단위는 명을 붙이세요)
select count(emp_name)
from employee
where phone not like '010%';

-- 5. 직원명과 입사년월을 출력하세요
-- 단, 아래와 같이 출력되도록 만드세요
select emp_name 직원명, to_char(hire_date,'yyyy/mm/dd') 입사년월 
from employee;

-- 6. 직원명과 주민번호를 조회하세요
-- 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서 출력하세요
select emp_name 직원명, substr(emp_no,1,8)||'******' 주민번호
from employee;

-- 7. 직원명, 직급코드, 연봉(원)을 조회하세요
-- 단, 연봉은 ￦로 표시되게 함
select emp_name 직원명, dept_code 직급코드, to_char(salary*12, '99,999,999') || '원' 연봉 
from employee;

-- 8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 수를 조회하세요
select count(hire_date)
from employee
where dept_code in ('D5', 'D9') and to_char(hire_date,'YYYY') = '2004';

-- 9. 직원명, 입사일, 오늘까지의 근무일수를 조회하세요
-- * 주말도 포함, 소수점 아래는 버림
select emp_name 직원명, hire_date 입사일, floor(sysdate-hire_date) 오늘까지근무일수
from employee;

-- 10. 모든 직원의 나이 중 가장 많은 나이와 가장 적은 나이를 출력하세요 (나이만 출력)
-- 한국식 나이: 현재년도 - 출생년도
select 
    min(to_char(sysdate,'yyyy') - ('19'||substr(emp_no,1,2))) as "가장 나이 적은 사람",
    max(to_char(sysdate,'yyyy') - ('19'||substr(emp_no,1,2))) as "가장 나이 많은 사람"
from employee;

