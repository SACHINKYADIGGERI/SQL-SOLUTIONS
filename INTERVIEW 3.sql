CREATE TABLE Application(candidate_id int,
						skills varchar);
						
INSERT INTO Application(candidate_id,skills)
VALUES
(101,'POWER BI'),(101,'PYTHON'),(101,'SQL'),(102,'TABLEAU'),(102,'SQL'),
(108,'PYTHON'),(108,'SQL'),(108,'POWER BI'),(104,'PYTHON'),(104,'EXCEL')

SELECT * FROM Application

select candidate_id,count(skills) AS SKILL_COUNT
from application
where skills IN ('PYTHON','SQL','POWER BI')
group by candidate_id
having count(skills)=3
order by candidate_id ASC