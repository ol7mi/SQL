
-- 1
select
	emp_name 이름, 
    email 이메일 ,
    length(email) 길이 
from employee ;
-- 2 직원의 이름과 이메일 주소 중 아이디 부분만 출력하세요
SELECT
	emp_name AS 이름,
	SUBSTR(email, 1, INSTR(email, '@') - 1) AS 아이디
FROM
	employee;
-- 3. 60년생의 직원명과 년생, 보너스율을 출력하세요
-- 보너스 값이 NULL인 경우에는 0%라고 출력되게 만드세요
SELECT
	emp_name AS 이름,
	emp_no AS 년생,
    nvl(bonus,0) AS 보너스
FROM
	employee
WHERE
    emp_no like '6%';
    
-- 4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하세요 (뒤에 단위는 명을 붙이세요)
SELECT 
    COUNT(*) || '명'
FROM 
    employee
WHERE 
    phone NOT LIKE '010%';

-- 5. 직원명과 입사년월을 출력하세요
-- 단, 아래와 같이 출력되도록 만드세요
--       직원명      입사년월
--   ex) 전형돈      2012년12월
--   ex) 전지연      1997년 3월
select 
    emp_name 직원명 , 
    to_char(hire_date,'yyyy"년"mm"월"')
from employee;
-- 6. 직원명과 주민번호를 조회하세요
-- 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서 출력하세요
select * from employee; 

select 
    emp_name 직원명 , substr(emp_no,1,8)||'******' 주민번호
from employee;
-- 7. 직원명, 직급코드, 연봉(원)을 조회하세요
-- 단, 연봉은 ￦로 표시되게 함
select 
    emp_name 직원명, 
    job_code 직급코드,
    to_char(salary*12, '999,999,999') || '₩'
from employee;
-- 8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 수를 조회하세요
SELECT 
    COUNT(*) AS "2004년"
FROM 
    employee
WHERE 
    (dept_code = 'D5' OR dept_code = 'D9') AND EXTRACT(YEAR FROM hire_date) = 2004;
-- 9. 직원명, 입사일, 오늘까지의 근무일수를 조회하세요
-- * 주말도 포함, 소수점 아래는 버림
select 
    emp_name 직원명, 
    hire_date 입사일,
    floor(sysdate - hire_date) 근무일수
from employee;

-- 10. 모든 직원의 나이 중 가장 많은 나이와 가장 적은 나이를 출력하세요 (나이만 출력)
-- 한국식 나이: 현재년도 - 출생년도
-- 10. 모든 직원의 나이 중 가장 많은 나이와 가장 적은 나이를 출력하세요 (나이만 출력)
-- 한국식 나이: 현재년도 - 출생년도
SELECT
    min(to_char(sysdate, 'yyyy') - ('19'||substr(emp_no, 1, 2))) as "가장 나이 적은 사람",
    max(to_char(sysdate, 'yyyy') - ('19'||substr(emp_no, 1, 2))) as "가장 나이 많은 사람"
FROM
    employee;



select * from employee;