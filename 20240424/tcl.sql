-- TCL : Commit . Rollback 
-- Transaction : 작업의 단위 (쿼리가 실제 반영되기 전에 보관되는 임시 저장소)

-- Transaction 필요한 이유?
-- 실수 방지 : 쿼리를 잘 못 전송했을 경우 rollback 으로 되돌릴 수 있음  
-- 작업의 원자성 : 하나의 작업처럼 동작해야 하는 여러개의 쿼리를 묶어서 실패하면 모두 실패 성공하면 모두 성공하는 동작으로 구현할 수 있음. ( 부분 성공을 방지 부분 실패를 방지 )
-- 주의 사항1 Transaction 에 과도하게 많은 쿼리를 누적 시킬 경우 자동으로 commit 될 수 있음. 
-- 주의 사랑2 DML 을 사용해서 Transaction 쿼리를 누적하다가, 중간에 DDL 이 한번이라도 실행 될 경우 자동 commit 됨. 