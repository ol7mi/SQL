/*
    group by 란? 그룹화 데이터를 생성하여 정보를 조회할 때 사용한다
    group by 는 COUNT(), MAX(), MIN(), SUM(), AVG() 등 집계 함수와 함께 사용된다
    
    그룹화된 정보만 확인 가능하다
    중복 제거, 자동 정렬
*/

-- group by dept_code : 부서별로 헤쳐 모여라
SELECT dept_code 
from EMPLOYEE
group by dept_code;

-- Quiz
-- 직급별 급여 평균 
SELECT job_code 직급, to_char(floor(avg(salary)),'L999,999,999') 평균 
from EMPLOYEE
group by job_code
order by 1;

-- 남여 
SELECT decode(substr(emp_no,8,1),'1','남','여') 성별 , count(*) 인원수 
from EMPLOYEE
group by decode(substr(emp_no,8,1),'1','남','여');

-- 입사년도별 인원수 
SELECT to_char(hire_date,'yyyy') 입사년도, count(*) 인원수 
from EMPLOYEE
group by to_char(hire_date,'yyyy')
order by 1;

-- 나이대별 급여 평균 
SELECT 
    case 
        when substr(emp_no,1,2) between 60 and 69 then '60년대생'
        when substr(emp_no,1,2) between 70 and 79 then '70년대생' 
        when substr(emp_no,1,2) between 80 and 89 then '80년대생' 
    end AS 입사년도, 
    count(*)|| '명' AS 인원수,
    '₩'|| to_char(floor(avg(salary)),'999,999,999') AS 급여평균 
from EMPLOYEE
group by
    case 
        when substr(emp_no,1,2) between 60 and 69 then '60년대생'
        when substr(emp_no,1,2) between 70 and 79 then '70년대생' 
        when substr(emp_no,1,2) between 80 and 89 then '80년대생' 
    end
order by 1;

-- 부서내 직급별 인원수 
SELECT nvl(dept_code,'인턴'),job_code, count(*)
from EMPLOYEE
group by dept_code, job_code
order by 1;

--직급 내 성별별 인원 수 
SELECT job_code 직급 , decode(substr(emp_no,8,1),'1','남','여') 성별 , count(*) 인원수 
from EMPLOYEE
group by job_code, decode(substr(emp_no,8,1),'1','남','여')
order by 1;

-- 직급내 년차별 인원수 
SELECT job_code 직급, ceil((sysdate-hire_date)/365) 년차 , count(*) 인원수 
from EMPLOYEE
group by job_code , ceil((sysdate-hire_date)/365)
order by 1,2;
