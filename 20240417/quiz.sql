-- Quiz
select * from job;
select * from department;
select * from employee;

-- Job 테이블에서 job_name 의 정보만 출력
select job_name from job;

-- department 테이블에서 모든 컬럼 출력
select * from department;

-- employee 테이블에서 이름,이메일,전화번호,고용일만 출력
select 
    emp_name as 이름,
    email as 이메일,
    phone as 전화번호,
    hire_date as 고용일 
from employee;

-- employee 테이블에서 월급이 250만원 이상인 사람의 이름과 급여등급만 출력
select emp_name as 이름 ,sal_level as 등급 
from employee 
where salary >= 2500000;

-- employee 테이블에서 급여가 350만원 이상이면서 job_code가 J3 인 사람의 이름과 전화번호만 출력
select
    emp_name as 이름,
    phone as 전화번호 ,'원'
from employee 
where salary >= 3500000 and job_code = 'J3';

-- employee 테이블에서 급여가 400만원 이상 600만원 이하의 사람의 사번, 이름, 부서코드, 급여 출력
select
    emp_id as 사번,
    emp_name as 이름,
    job_code as 부서코드,
    salary as 급여
from employee 
where salary >= 4000000 or salary <= 600000;

-- employee 테이블 내에서 20년 이상 근속한 직원의 이름 급여 보너스율을 출력 
select emp_name as 이름 ,salary as 급여, nvl(bonus,0) as 보너스
from employee
where (sysdate - hire_date)/365 >= 20;


-- 근속년수가 10년 이상 된 직원 중 급여가 200 만원 이하인 직원의 이름과 급여 직급코드를 출력 
select emp_name 이름 , salary || '원' 급여 , job_code 직급코드
from employee
where (sysdate-hire_date)/365 >= 10 and salary <= 2000000;

-- 보너스가 null 인 사람 출력 
select *
from employee
where bonus is null;

-- 보너스가 null 이 아닌 사람 출력 
select *
from employee
where bonus is not null;

-- 이름이 연으로 끝나는 사원의 이름 출력
select *
from employee
where emp_name like '%연';

-- 전화번호 첫 자리가 010 이 아닌 사원의 이름과 전화번호 출력
select emp_name, phone
from employee
where phone not like '010%';

-- 생일이 9월자인 사원의 이름과 주민번호만 출력
select emp_name, emp_no
from employee
where substr(emp_no,4,1) = '9';

-- 전화번호 첫 자리가 010 이 아닌 사원의 이름과 전화번호 출력
select emp_name, phone
from employee
where phone not like '010%';

-- 메일 주소에 s 가 들어가면서 dept_code 가 D9 또는 D6 인 직원들 중에서
-- 고용일이 90년 1월 1일 부터 2015년 12월 1일 사이에 입사했고 급여가 270만원 이상인 사원의 전체 정보 출력 
select *
from employee
where 
email like '%s%' and 
dept_code in ('D9','D6') and
hire_date between '90/01/01' and '15/12/01' and 
salary >= 2700000;

