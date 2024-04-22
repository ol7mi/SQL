-- join 한 개 이상의 테이블을 병합해 유의미 한 데이터셋을 만들어내는 문법 
-- cross join : join 의 동작 원리를 이해하기 쉬운 join 종류 (실전 개발에서는 쓰임이 드물다)
-- inner join : 여러 테이블 간에 특정 조건을 기반으로 병합하는 문법 - null 미포함 
-- outer join : 여러 테이블 간에 특정 조건을 기반으로 병합하는 문법 - null 을 포함
-- self join : 한개의 테이블을 join 하는 문법 - 특수한 경우에 간혹 사용 됨

-- cross 동작원리 이해 
SELECT * FROM job;
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPARTMENT cross join job; 

SELECT * FROM EMPLOYEE;
-- inner join
-- 조건 줄 때 on
select 
    e.emp_name, -- EMPLOYEE
    e.dept_code,
    d.dept_title -- DEPARTMENT
from 
    EMPLOYEE e inner join DEPARTMENT d  -- 별명
    on e.dept_code = d.dept_id; 

-- 사원명, 사원번호, 직급명을 출력 
select 
    e.emp_id 사원번호,
    e.emp_name 사원명 ,
    j.job_name 직급명 
from EMPLOYEE e inner join job j on e.job_code = j.job_code;


-- 총무부, 회계관리부인 사람들의 사원명 부서명 부서코드 출력
SELECT 
    e.emp_name 사원명, 
    d.dept_title 부서명, 
    e.dept_code 부서코드
FROM EMPLOYEE e join DEPARTMENT d on e.dept_code = d.dept_id
WHERE dept_title in('총무부','회계관리부');

-- 해외 영업부 (1,2,3) 의 직원들의 사번, 사원명, 부서명, 부서코드, 연봉을 출력
-- 조건 부서명, 사번 순으로 오름차순 
SELECT 
    emp_id 사번, 
    emp_name 사원명, 
    d.dept_title 부서명, 
    dept_code 부서코드, 
    to_char(salary*12,'999,999,999') 연봉
FROM EMPLOYEE e join DEPARTMENT d on e.dept_code = d.dept_id
WHERE d.dept_title in('해외영업1부','해외영업2부','해외영업3부')
order by 3,1 asc;


-- 출력은 됐으면 좋겠으면 
-- left outer : join 에 참여하는 테이블 중에 문법상 왼쪽에 존재하는 테이블의 값을 모두 출력하게 처리하는 문법
-- right outer
-- full outer 양쪽 테이블의 모든값을 출력하게 처리하는 문법 
-- outer 생략 가능 

-- 인턴이라 부서가 정해지지 않은 사람들 
select 
    emp_name, 
    nvl(dept_title,'인턴')
from employee e left join DEPARTMENT d on e.dept_code = d.dept_id;

-- 부서에 해당안되는 요소도 출력 
select 
    emp_name, 
    nvl(dept_title,'인턴')
from employee e right join DEPARTMENT d on e.dept_code = d.dept_id;

-- 전부 다 
select 
    emp_name, 
    nvl(dept_title,'인턴')
from employee e full join DEPARTMENT d on e.dept_code = d.dept_id;

-- "전 부서원"의 사원명, 부서명, 급여, 보너스율 출력
SELECT 
    e.emp_name 사원명, 
    d.dept_title 부서명, 
    e.salary 급여, 
    e.bonus 보너스율
from EMPLOYEE e right join DEPARTMENT d on e.dept_code = d.dept_id;

-- 기술지원부를 제외한 모든 직원의 사원명, 사번, 사원명, 부서명, 연봉  출력
-- 부서명이 없는 직원들은 부서명을 미정 이라고 출력
-- 정렬은 부서명 사번 연봉 오름차순 
SELECT 
    e.emp_id 사번, 
    e.emp_name 직원, 
    nvl(d.dept_title,'미정') 부서명, 
    to_char(e.salary*12,'999,999,999') 연봉 
from EMPLOYEE e left join DEPARTMENT d on e.dept_code = d.dept_id
where dept_title != '기술지원부' or dept_title is null
order by 3,1,4;

-- self join 테이블 하나로 
-- 사원번호 사원명 직속ID 직속상사명
SELECT 
    a.emp_id AS 사원번호,
    a.emp_name AS 사원명,
    a.manager_id AS 상사ID,
    b.emp_name AS 직속상사명 
from EMPLOYEE a join EMPLOYEE b on a.manager_id = b.emp_id;


-- 다중 join : 3개 이상의 여러 테이블의 join
-- 사원번호, 사원명, 부서명, 직급명 
SELECT 
    emp_id 사원번호, 
    emp_name 사원명, 
    dept_title 부서명, 
    job_name 직급명 
from 
    EMPLOYEE e 
    left join DEPARTMENT d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
order by 1;

-- 사번, 사원명, 부서명, national_code 국가명 를 출력 
SELECT 
    emp_id 사번, 
    emp_name 사원명, 
    dept_title 부서명,
    --lo.NATIONAL_CODE,
    na.NATIONAL_NAME 국가명 
from 
    EMPLOYEE e join DEPARTMENT d on e.dept_code = d.dept_id
    join location lo on d.location_id = lo.local_code
    join NATIONAL na on lo.NATIONAL_CODE = na.NATIONAL_CODE;
