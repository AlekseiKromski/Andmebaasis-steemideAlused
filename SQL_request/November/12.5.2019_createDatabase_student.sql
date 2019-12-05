use STUDENT

--Drop tables
DROP TABLE profession
DROP TABLE schoolGroup

--System requests
SELECT * FROM Student
SELECT * FROM profession
SELECT * FROM schoolGroup

--Table profession
CREATE TABLE profession (id_profession INTEGER IDENTITY(10000,1) NOT NULL CONSTRAINT PK_id_profession PRIMARY KEY, name_profession CHAR(30) NOT NULL)
--Inser data 
INSERT INTO profession (name_profession) VALUES('noorem tarkvaraarendaja'),('keevitaja')


--Table school_group
CREATE TABLE schoolGroup (id_group CHAR(10) NOT NULL CONSTRAINT PK_id_group PRIMARY KEY,
	school CHAR(15) NOT NULL DEFAULT 'pohikool', CHECK (school IN ('pohikool', 'kesk kool')),
	languageGroup CHAR(15) NOT NULL DEFAULT 'vene', CHECK (languageGroup IN ('russian', 'eesti')),
	city CHAR(15) NOT NULL DEFAULT 'Johvi', CHECK (city IN ('Johvi', 'Sillamae')),
	groupDate_reg DATE NOT NULL DEFAULT getDate(),
	profession INTEGER NOT NULL,
	CONSTRAINT FK_profession FOREIGN KEY(profession) REFERENCES profession (id_profession))

--Insert data
INSERT INTO schoolGroup VALUES ('JPTVR18',DEFAULT,DEFAULT,DEFAULT,DEFAULT,10000)
