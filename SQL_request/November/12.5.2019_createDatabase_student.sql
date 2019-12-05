
--################## SYSTEM QUERY #################

use STUDENT

--Drop tables
DROP TABLE student
DROP TABLE profession
DROP TABLE schoolGroup

--Delete tables data
DELETE FROM study

--System requests
SELECT * FROM student
SELECT * FROM profession
SELECT * FROM schoolGroup
SELECT * FROM study

--################## SYSTEM QUERY #################


/*
* Создание трех таблиц для задания 10.1
* 
* В программе описаны запросы создание 3ех таблиц 
* и так же прилагается запросы на добавления в них информации
* 
*
*
* В system query описаны запросы для debuga и проверки таблиц
*/

--Table profession
CREATE TABLE profession (id_profession INTEGER IDENTITY(10000,1) NOT NULL CONSTRAINT PK_id_profession PRIMARY KEY, name_profession CHAR(30) NOT NULL)
--Inser data into profession
INSERT INTO profession (name_profession) VALUES('noorem tarkvaraarendaja'),('keevitaja')


--Table school_group
CREATE TABLE schoolGroup (id_group CHAR(10) NOT NULL CONSTRAINT PK_id_group PRIMARY KEY,
	school CHAR(15) NOT NULL DEFAULT 'pohikool', CHECK (school IN ('pohikool', 'kesk kool')),
	languageGroup CHAR(15) NOT NULL DEFAULT 'russian', CHECK (languageGroup IN ('russian', 'eesti')),
	city CHAR(15) NOT NULL DEFAULT 'Johvi', CHECK (city IN ('Johvi', 'Sillamae')),
	groupDate_reg DATE NOT NULL DEFAULT getDate(),
	profession INTEGER NOT NULL,
	CONSTRAINT FK_profession FOREIGN KEY(profession) REFERENCES profession (id_profession))
--Insert data into school_group
INSERT INTO schoolGroup VALUES ('JPTVR18','pohikool','russian','Johvi',DEFAULT,10000)
INSERT INTO schoolGroup VALUES ('JKKKR19','pohikool','eesti','Sillamae',DEFAULT,10001)


--Table study
CREATE TABLE study (sudent varchar(20) NOT NULL,
	schoolGroup CHAR(10) NOT NULL,
	start_study DATE NOT NULL DEFAULT getDate(),
	finish_study DATE NULL DEFAULT getDate(),
	study_status CHAR(20) NOT NULL, CHECK(study_status IN ('study','finish','expelled')),
	CONSTRAINT FK_sudent FOREiGN KEY(sudent) REFERENCES student (ID_Isikukood),
	CONSTRAINT FK_schoolGroup FOREiGN KEY(schoolGroup) REFERENCES schoolGroup (id_group))
--Insert data into study
INSERT INTO study VALUES (50208302215,'JPTVR18','2018-09-01',NULL,'study'),
	(50405028515,'KTVRI18','2017-09-01',DEFAULT,'finish'),
	(40405028512,'JKKKR19','2017-09-01','2017-12-06','expelled')

