USE STUDENT

SELECT *,SUBSTRING(ID_Isikukood,2,2) as y, SUBSTRING(ID_Isikukood,4,2) as m, SUBSTRING(ID_Isikukood,6,2) as d,

CASE
	WHEN LEFT(ID_Isikukood,1) = 3 THEN 'Male'
	WHEN LEFT(ID_Isikukood,1) = 5 THEN 'Male'
	WHEN LEFT(ID_Isikukood,1) = 6 THEN 'Famel'
	WHEN LEFT(ID_Isikukood,1) = 4 THEN 'Famel'
	ELSE 'error'
END gender,

CASE
	WHEN LEFT(ID_Isikukood,1) = 3 THEN DATEFROMPARTS('19' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2)) 
	WHEN LEFT(ID_Isikukood,1) = 4 THEN DATEFROMPARTS('19' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2))
	WHEN LEFT(ID_Isikukood,1) = 5 THEN DATEFROMPARTS('20' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2)) 
	WHEN LEFT(ID_Isikukood,1) = 6 THEN DATEFROMPARTS('20' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2)) 
	ELSE 'error'
END birthday,

CASE
	WHEN LEFT(ID_Isikukood,1) = 3 THEN YEAR(GETDATE()) - YEAR(DATEFROMPARTS('19' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2))) 
	WHEN LEFT(ID_Isikukood,1) = 4 THEN YEAR(GETDATE()) - YEAR(DATEFROMPARTS('19' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2))) 
	WHEN LEFT(ID_Isikukood,1) = 5 THEN YEAR(GETDATE()) - YEAR(DATEFROMPARTS('20' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2)))  
	WHEN LEFT(ID_Isikukood,1) = 6 THEN YEAR(GETDATE()) - YEAR(DATEFROMPARTS('20' + SUBSTRING(ID_Isikukood,2,2),SUBSTRING(ID_Isikukood,4,2), SUBSTRING(ID_Isikukood,6,2)))  
	ELSE 'error'
END age

FROM Student WHERE ID_Isikukood = '50208302215'