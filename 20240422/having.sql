-- having 절과 where절의 차이
-- having은 전체 결과, where은 개별 행

-- having 절과 where절의 유사점 
-- 둘 다 데이터 세트검색을 필터링할때 사용할 수 있다는 점

-- having
-- group by 와 함께 쓴다

-- 이유 1. where 절에서는 그룹 함수를 사용할 수 없다 2. 실행 순서
-- 실행 순서 from 어디서 -> where 조건에 대하여 -> group by -> having -> select -> order by 



-- 부서별 급여 평균을 구했을 때 급여 평균이 300 만원 이상인 부서의 정보만 출력 
SELECT DEPT_CODE, to_char(ceil(AVG(SALARY)),'999,999,999')
from EMPLOYEE
group by DEPT_CODE
having AVG(SALARY) >= 3000000
order by 1;

-- 직급별 인원수가 3명 미만인 직급정보만 출력 
SELECT job_code 직급, count(*)
from EMPLOYEE
group by job_code
having count(*) < 3
order by 1;
