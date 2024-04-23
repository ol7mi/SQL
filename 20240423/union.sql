-- set Operator (Union)
-- 한 개 이상의 테이블을 병합하여 데이터셋을 만드는 문법 
-- 기존 join 문법과는 병합 방식이 다르다 
-- 단순하게 A 테이블을 B 테이블 아래로 붙인다 
-- set Operator (Union) 동작 조건? 
-- 1. 병합에 참여하는 두 테이블간 컬럼수가 같아야 한다.
-- 2. 병합되는 컬럼에 데이터 타입이 일치해야 한다
-- 비슷한 종류의 테이블들을 하나로 병합하여 보고자 할 때 사용한다.

-- table 객체를, 만들겠다 create ()
create table testA (
    data varchar(10)
);
create table testB(
    data varchar(10)
)
insert into testA values('B');
insert into testA values('C');
insert into testA values('D');

insert into testB values('A');
insert into testB values('B');
insert into testB values('C');

select * from testA;
select * from testB;


-- nuion : 합집합 - 중복을 허용하지 않음
-- 중복 데이터는 제거됨 
SELECT * from TESTB
union 
select * from TESTC;

-- nuion all : 합집합 - 중복을 허용
SELECT * from TESTB
union all
select * from TESTC;

-- intersect : 교집합 - 두 테이블에 겹치는 데이터만 출력
SELECT * from TESTB
intersect
select * from TESTC;

-- minus : 차집합 (첫번째 항에서 두번째 항을 뺄셈하고 남은 첫번째 항의 결과만을 출력)
SELECT * from TESTB
minus 
select * from TESTC;


-- Sub Query (대량 데이터에는 X)
-- 꼭 () 소괄호 안에다가 작성한다
-- 하나의 SQL 문 안에 포함된 다른 SQL 문
-- Main Query 가 sub Query 를 포함하고 있는 관계다
-- 소량의 데이터 내에서 성능 이슈없이 자유로운 데이터 운용을 가능하게 한다. 대량 데이터에서는 성능 이슈가 많이 발생하는 편이다
SELECT manager_id 
from EMPLOYEE where emp_name = '전지연';
SELECT emp_name from EMPLOYEE where emp_id=214;

-- 서브쿼리 사용법
SELECT emp_name 
from EMPLOYEE
where emp_id=(select manager_id from employee where emp_name='전지연');
-- 서브쿼리의 종류 (서브쿼리가 반환하는 값의 형태에 따라 분류된다)
-- 단일행 단일열 서브 쿼리 : 반환하는 값이 단 1개의 데이터일 때 
-- 다중행 단일열 서브 쿼리 : 반환하는 값이 여러 행의 데이터일 때
-- 단일행 단중열 서브 쿼리 : 반환하는 값이 단일행이지만 여러 열로 구성되어 있을 때
-- 다중행 단중열 서브 쿼리 : 반환하는 값이 테이블 구조일 때 

-- 전직원의 평균 급여를 구하는 쿼리 
-- 반환된 값을 바탕으로 직원중 1번에서 구한 평균 급여값보다 급여가 높은 사람 조회
SELECT avg(salar)
from EMPLOYEE;

SELECT *
from EMPLOYEE
where salary >= (SELECT avg(salary) from EMPLOYEE);

-- 윤은혜 직원과 급여가 같은 사원들의 사번, 사원명, 급여를 출력하되 윤은혜는 출력하지 마세요

SELECT salary from EMPLOYEE where emp_name = '윤은해';

SELECT emp_id 사번, emp_name 사원명, salary 급여
from EMPLOYEE
where salary = (SELECT salary from EMPLOYEE where emp_name = '윤은해') 
and emp_name != '윤은해';



-- 직원 중에 급여를 가장 많이 받는 직원 및 급여를 가장 적게 받는 직원의 사번 사원명 급여 출력 
select max(salary) from EMPLOYEE;
select min(salary) from EMPLOYEE;

select emp_id 사번 , emp_name 사원명 , salary 급여
from EMPLOYEE 
where 
    salary = (select max(salary) from EMPLOYEE) or 
    salary = (select min(salary) from EMPLOYEE);


-- D1, D2 부서에서 근무하는 사원중에 기본 급여가 D5 부서의 급여 평균보다 높은 사람들의 
-- 사원명 부서코드 부서명 급여 
select emp_name, nvl(dept_code,'미정'), nvl((select dept_title from department d where e.dept_code = d.dept_id),'미정')
from EMPLOYEE e
where dept_code in ('D1','D2') and salary > (select avg(salary) from EMPLOYEE where dept_code in ('D5'));

select salary
from EMPLOYEE
where dept_code in ('D5');

SELECT * from job ;
-- 다중행 서브쿼리 : 서브쿼리가 반환하는 값이 다중행인 경우 
-- 송종기 또는 박나라 직원의 부서코드를 출력하세요 
SELECT dept_code from EMPLOYEE where emp_name in('박나라','송종기');
SELECT * from EMPLOYEE where dept_code in (SELECT dept_code from EMPLOYEE where emp_name in('박나라','송종기'));
-- = 을 못쓴다 in,을 씀 
-- 차태연 전지연 직원의 급여등급과 같은 등급을 가진 사원의 사원명 직급명 급여등급 출력
SELECT 
    emp_name 사원명 ,
    job_name 직급명 ,
    sal_level 급여등급
from EMPLOYEE e join job j on e.job_code = j.job_code
where sal_level in (SELECT sal_level from EMPLOYEE where emp_name in ('차태연','전지연'));


SELECT 
    sal_level
from EMPLOYEE 
where emp_name in ('차태연','전지연');



-- 직급이 대표, 부사장, 부장이 아닌 모든 직원의 사번 사원명 직급명 부서명 출력 
SELECT 
    emp_id 사번,
    emp_name 사원명,
    job_name 직급명,
    dept_title 부서명
from 
    EMPLOYEE e join job j on e.job_code = j.job_code 
    left join DEPARTMENT d on d.dept_id = e.dept_code
where 
    e.job_code in (SELECT job_code from job where job_name not in('대표', '부사장', '부장'));


-- 다중 열 서브쿼리 
select dept_code, job_code from employee where emp_name = '선동일';
-- 퇴사한 직원과 같은 부서이면서 같은 직급에 해당하는 사원명 직급코드, 부서코드, 입사일 출력 
SELECT dept_code, job_code , hire_date
from EMPLOYEE 
where ent_yn='Y';

SELECT emp_name, job_code, hire_date 
from EMPLOYEE
where (dept_code, job_code) in (SELECT dept_code, job_code from EMPLOYEE where ent_yn='Y') 
and emp_name != '이태림';


-- 다중행 다중열 서브쿼리 
-- 생일이 8월 8일인 사원들과 같은 부서코드,직급코드를 가진 사원들의 사원명,생일,부서코드,부서명 
select 
    emp_name 사원명, 
    substr(emp_no,3,4) 생일, 
    dept_code 부서코드, job_code,
    (select dept_title from department d where e.dept_code = d.dept_id) 부서명
from employee e
where (dept_code, job_code) in (select dept_code, job_code from employee where substr(emp_no,3,4) = 0808);

--생일이 8월 8일인 사원들과 같은 부서코드,직급코드
-- SELECT dept_code, job_code
-- from EMPLOYEE 
-- where substr(emp_no,3,4) = 0808 ;



-- 부서별 급여를 제일 많이 받는 직원 
-- 부서코드, 부서명, 직원의 사원명, 급여
select 
    nvl(dept_code,'미정') 부서코드, 
    nvl((select dept_title from department d where d.dept_id = e.dept_code),'미정') 부서명, 
    emp_name 사원명, 
    salary 급여
from employee e
where (nvl(dept_code,'미정'),salary) in (select nvl(dept_code,'미정') ,max(salary) from employee group by dept_code);


-- 각 직급마다 급여등급이 가장 높은 직원의 이름, 직급코드, 직급명, 급여, 급여등급 출력 
SELECT
    e.emp_name 이름, 
    e.job_code 직급코드, 
    j.job_name 직급명, 
    e.salary 급여, 
    e.sal_level 급여등급
from 
    EMPLOYEE e 
    join job j on e.job_code = j.job_code
where 
    (sal_level ,e.job_code) in (SELECT min(sal_level),job_code 
                                from EMPLOYEE 
                                group by  job_code)
order by 2;


SELECT min(sal_level),job_code
from EMPLOYEE 
group by job_code;

-- Inline View (from 절에서 subquery 를 사용) -- from 절에서 서브쿼리를 사용하여 나온 결과에 대해 select 쿼리를 적용하는 문법 
-- SELECT * from (subquery) when ;
select emp_name, emp_no 
from (SELECT * from EMPLOYEE) ;

-- 상(호 연)관 서브쿼리
SELECT 
    emp_name, 
    (select dept_title from DEPARTMENT where e.dept_code = dept_id)
from EMPLOYEE e;
-- 사원명 직급명 
SELECT 
    emp_name,
    (select job_name from job where e.job_code = job_code)
from EMPLOYEE e;
-- 사원명 매니저명 
SELECT 
    e.emp_name 사원,
    (select emp_name b from EMPLOYEE where e.manager_id = emp_id) 매니저 
from EMPLOYEE e;
--Sub Query 끝--





-- 랭킹 함수 (순위를 정해준다)
-- rank() over(어떤 기준?) 공동이면 다음 순위를 뺀다....
select emp_name, salary, rank() over(order by salary desc) from employee;
-- dense 밀집시켜라, dense_rank() over() 공동순위
select emp_name, salary, dense_rank() over(order by salary desc) from employee;
-- 공동순위가 싫으면? row_number() over()
select emp_name, salary, row_number() over(order by salary desc) from employee;


select *
from (select emp_name, salary, row_number() over(order by salary desc) r from employee)
where r between 5 and 10;
