select *from employee;

-- Quiz 
-- 근속년수가 5년 이상 10년 이하인 직원의 이름, 주민번호, 급여, 입사일 출력 
select emp_name 이름 , emp_no 주민번호 , salary 급여 , hire_date 입사일 
from employee
where (sysdate-hire_date)/365 between 5 and 10;

-- 재직 중이 아닌 직원의 이름, 근무기간, 부서코드를 출력 
select emp_name 이름 , floor((ent_date-hire_date))||'일' 근무기간 ,dept_code 부서코드
from employee
where ent_yn = 'Y';

-- 근속년수가 10년 이상인 직원들의 이름 급여 근속년수(소수점X) 를 근속년수 오름차순으로 정렬하여 출력 
select emp_name 이름 , salary*1.5 || '원' 급여, floor((sysdate-hire_date)/365)||'년' 근속년수 
from employee
where (sysdate-hire_date)/365 >= 10
order by hire_date;

-- 입사일이 99/01/01 ~10/01/01 인 직원 중에서 급여가 2백만원 이하인 사람의 이름 주민번호 이메일 폰번호 급여를 출력 
select emp_name 이름 , emp_no 주민번호 ,email 이메일 ,phone  폰번호 , salary 급여
from employee
where hire_date between '99/01/01' and '10/01/01' and salary <= 2000000;

-- 급여가 200~300만원 사이인 여직원 중에서 4월 생일자의 이름 주민번호 급여 부서코드를 출력
select emp_name 이름 , emp_no 주민번호 ,salary 급여, dept_code 부서코드
from employee
where salary between '2000000' and '3000000' and substr(emp_no,4,1) = '9';

-- 남자 직원 중 보너스가 없는 직원의 오늘까지 근무일을 측정하여 각 1000일마다 급여의 10% 를 보너스로 계산하여 
-- 이름 , 계산된 금액 (특별 보너스로 별칭 설정) 을 출력 이름은 오름차순으로 
select 
    emp_name 이름 , 
    floor((sysdate-hire_date)/1000) * (salary*0.1) 특별보너스 
from employee
where substr(emp_no,8,1) = '1'
order by emp_name;




