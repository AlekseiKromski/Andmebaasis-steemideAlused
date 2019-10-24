
USE smpl_AlekseiKromski
--6.11

SELECT location,COUNT(location) AS count FROM department GROUP BY location

--6.12

--DISTINCT - получить уникальные строки (отличающиес€ друг от друга любым отображаемым полем). –аботает чуть быстрее.
--GROUP BY - сгруппировать по какому-либо признаку, при этом можно использовать агрегатные функции SUM, AVG, MAX и т.д.

--6.13

--GROUP BY все значени€ NULL трактуютс€ как равные, то есть при группировке по полю, содержащему NULL-значени€, все такие строки попадут в одну группу.

--6.14

--COUNT(*) - подсчитывает количество записаных строк
--COUNT(column) - подсчитывает количество строк в опредленном столбце

--6.15

SELECT MAX(emp_no) AS maks_emp FROM employee

--6.16

SELECT COUNT(*) AS count_emp FROM works_on GROUP BY job
SELECT COUNT(*) AS count_emp_project FROM works_on GROUP BY project_no 
SELECT emp_no, COUNT(*) AS count_job FROM works_on GROUP by emp_no


--6.17

SELECT job FROM works_on GROUP by job HAVING COUNT(*) >= 2

