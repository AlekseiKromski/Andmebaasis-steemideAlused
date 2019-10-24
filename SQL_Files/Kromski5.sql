
USE smpl_AlekseiKromski
--6.11

SELECT location,COUNT(location) AS count FROM department GROUP BY location

--6.12

--DISTINCT - �������� ���������� ������ (������������ ���� �� ����� ����� ������������ �����). �������� ���� �������.
--GROUP BY - ������������� �� ������-���� ��������, ��� ���� ����� ������������ ���������� ������� SUM, AVG, MAX � �.�.

--6.13

--GROUP BY ��� �������� NULL ���������� ��� ������, �� ���� ��� ����������� �� ����, ����������� NULL-��������, ��� ����� ������ ������� � ���� ������.

--6.14

--COUNT(*) - ������������ ���������� ��������� �����
--COUNT(column) - ������������ ���������� ����� � ����������� �������

--6.15

SELECT MAX(emp_no) AS maks_emp FROM employee

--6.16

SELECT COUNT(*) AS count_emp FROM works_on GROUP BY job
SELECT COUNT(*) AS count_emp_project FROM works_on GROUP BY project_no 
SELECT emp_no, COUNT(*) AS count_job FROM works_on GROUP by emp_no


--6.17

SELECT job FROM works_on GROUP by job HAVING COUNT(*) >= 2

