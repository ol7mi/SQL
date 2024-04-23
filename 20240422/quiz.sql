
-- 1. 2020년 12월 25일이 무슨 요일인지 조회하세요.
select to_char(to_date('20201225','yyyymmdd'),'day') from dual;
-- 2. 주민번호가 1970년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하세요.
SELECT 
    emp_name 사원명, 
    emp_no 주민번호, 
    dept_title 부서명, 
    job_name 직급명
from 
    EMPLOYEE e 
    join JOB j on e.job_code = j.job_code
    join DEPARTMENT d on d.dept_id = e.dept_code
where 
    substr(emp_no,8,1) = 2 and 
    (substr(emp_no,1,2) BETWEEN 70 and 79) and 
    emp_name like '전%';


-- 3. 이름에 "형"자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하세요.
SELECT 
    emp_id 사번, 
    emp_name 사원명,
    dept_title 부서명
from EMPLOYEE e join DEPARTMENT d on d.dept_id = e.dept_code
where emp_name like '%형%';


-- 4. 부서별 급여 평균이 300만원 이하인 부서의 부서명과 급여 평균을 출력하세요
-- > 급여 평균은 10000의 자리 아래로 버리고 출력해주세요. 
-- > 또한 한국 로컬 통화 표기법으로 출력해주세요. (￦3,520,000)
SELECT 
    d.dept_title 부서명,
    to_char(floor(avg(e.salary)),'L999,999,999') 급여평균
from EMPLOYEE e join DEPARTMENT d on d.dept_id = e.dept_code
group by dept_title 
having avg(salary) <= 3000000;


-- 5. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하세요.
SELECT 
    emp_name 사원명, 
    job_name 직급명, 
    dept_code 부서코드, 
    dept_title 부서명
from 
    EMPLOYEE e join DEPARTMENT d on d.dept_id = e.dept_code join job j on j.job_code = e.job_code
where dept_title like '해외%';

-- 6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하세요.
SELECT 
    emp_name 사원명, 
    bonus 보너스포인트, 
    dept_title 부서명, 
    na.national_name 근무지역명
from 
    EMPLOYEE e join DEPARTMENT d on d.dept_id = e.dept_code 
    join location lo on d.location_id = lo.local_code
    join NATIONAL na on lo.NATIONAL_CODE = na.NATIONAL_CODE
where bonus is not null;

-- 7. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하세요.
SELECT 
    emp_name 사원명, 
    job_name 직급명, 
    dept_title 부서명, 
    na.national_name 근무지역명
from     
    EMPLOYEE e join DEPARTMENT d on d.dept_id = e.dept_code join 
    location lo on d.location_id = lo.local_code join 
    NATIONAL na on lo.NATIONAL_CODE = na.NATIONAL_CODE join
    job j on j.job_code = e.job_code
where dept_code = 'D2';

-- 8. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 근무지역명, 국가명을 조회하세요.
SELECT 
    emp_name 사원명, 
    dept_title 부서명, 
    na.national_name 근무지역명, 
    na.national_code 국가명
from     
    EMPLOYEE e join DEPARTMENT d on d.dept_id = e.dept_code join 
    location lo on d.location_id = lo.local_code join 
    NATIONAL na on lo.NATIONAL_CODE = na.NATIONAL_CODE join
    job j on j.job_code = e.job_code
where na.national_code in('KO','JP');

-- 9. 모든 사원 중 선동일을 매니저로 두고 있는 직원의 이름, 직원의 부서명, 매니저의 이름을 출력하세요.
SELECT 
    a.emp_name 직원명, 
    dept_title 직원부서명, 
    b.emp_name 매니저
from 
    EMPLOYEE a join EMPLOYEE b on a.manager_id = b.emp_id join 
    DEPARTMENT c on c.dept_id = a.dept_code
where  b.emp_name = '선동일';
-- 10. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하세요 (join과 in 사용)
SELECT 
    emp_name 사원명, 
    job_name 직급명, 
    to_char(salary,'L999,999,999') 급여
from EMPLOYEE e join job j on j.job_code = e.job_code
where 
    (bonus is null) and job_name in('차장','사원');

-- 11. 재직중인 직원과 퇴사한 직원의 수를 조회하세요.
SELECT 
    case 
        when ent_date is null then '재직'
        when ent_date is not null then '퇴사'
    end,
    count(*)
from EMPLOYEE
group by ent_date;
--having ent_date

--12 부서명내 직급별 인원수
SELECT 
    nvl(dept_title,'인턴') 직원부서명,
    job_name 직급별,
    COUNT(*)|| '명' 인원수
from 
    EMPLOYEE e left join DEPARTMENT d on e.dept_code = d.dept_id 
    join job j on j.job_code = e.job_code
group by dept_title,job_name
order by 1,2;