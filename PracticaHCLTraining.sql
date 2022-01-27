/*1. Create new database, schema and table*/
CREATE DATABASE testDB;
DROP DATABASE testDB;

/*2. Drop database and table*/
CREATE SCHEMA NewDBSchema;
DROP schema NewDBSchema;

CREATE DATABASE Training;

CREATE TABLE Training.Students(
	StudentId INT NOT NULL,
    Name varchar(255),
    LastName varchar(255),
    Adress varchar(255)
    /*primary key(StudentId)*/
);


CREATE TABLE training.Course(
	CourseId INT NOT NULL,
    Name varchar(255)
    /*primary key(CourseId)*/
);

CREATE TABLE training.Enrollment(
	EnrollmentId INT,
    CourseId INT NOT NULL,
    StudentId INT NOT NULL,
    DATE DATETIME DEFAULT CURRENT_TIMESTAMP()
    /*PRIMARY KEY(EnrollmentId),
    FOREIGN KEY (CourseId) REFERENCES Course(CourseId),
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId)*/
);

/*3. Alter table to add unique, primary and foreign key constraints*/

ALTER TABLE training.Students
MODIFY COLUMN StudentId INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(StudentId);

ALTER TABLE training.Course
MODIFY COLUMN CourseId INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(CourseId);

ALTER TABLE training.Enrollment
MODIFY COLUMN EnrollmentId INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(EnrollmentId),
ADD FOREIGN KEY (CourseId) REFERENCES training.Course(CourseId),
ADD FOREIGN KEY (StudentId) REFERENCES training.Students(StudentId)
;


/*Insert values to all 3 tables*/
INSERT INTO training.Course (Name) VALUES('MySql');
INSERT INTO training.Course (Name) VALUES('MariaDB');
INSERT INTO training.Course (Name) VALUES('PL/SQL');
INSERT INTO training.Course (Name) VALUES('Java');
INSERT INTO training.Course (Name) VALUES('PHP');
INSERT INTO training.Course (Name) VALUES('FullStack');
INSERT INTO training.Course (Name) VALUES('JavaScript');

INSERT INTO training.students (Name,LastName,Adress) VALUES('Kevin','Ibarra','Lázaro Cárdenas');
INSERT INTO training.students (Name,LastName,Adress) VALUES('Pedro','Benites','Lázaro Cárdenas');
INSERT INTO training.students (Name,LastName,Adress) VALUES('ALejandro','Rodriguez','Lázaro Cárdenas');
INSERT INTO training.students (Name,LastName,Adress) VALUES('Enrique','Peña','Lázaro Cárdenas');
INSERT INTO training.students (Name,LastName,Adress) VALUES('Andres','Lopez','Lázaro Cárdenas');

INSERT INTO training.Enrollment (StudentId,CourseId) VALUES(1,2);
INSERT INTO training.Enrollment (StudentId,CourseId) VALUES(1,3);
INSERT INTO training.Enrollment (StudentId,CourseId) VALUES(1,4);
INSERT INTO training.Enrollment (StudentId,CourseId) VALUES(2,1);
INSERT INTO training.Enrollment (StudentId,CourseId) VALUES(2,3);
INSERT INTO training.Enrollment (StudentId,CourseId) VALUES(3,3);

SET SQL_SAFE_UPDATES = 0;

/*5. Delete a few courses*/
DELETE FROM training.Course where Name='JavaScript';
DELETE FROM training.Course where Name='FullStack';

/*6.(A)Fetch all student details who have courses enrolled and 
(B)all students who have not enrolled also

(A)*/
SELECT DISTINCT A.StudentId,Name, lastName from training.students as A
INNER JOIN training.Enrollment as B ON A.StudentId = B.StudentId;

/*(B) all students who have not enrolled also*/
SELECT DISTINCT StudentId,Name, lastName from training.students WHERE StudentId NOT IN (SELECT StudentId FROM training.enrollment);

/*7. Get the number of students enrolled for all courses*/
SELECT COUNT(DISTINCT StudentId) as 'number of students enrolled for all courses'  FROM training.enrollment;

/*8. Get the course name with the maximum number of enrollments*/
SELECT B.Name FROM training.enrollment as A
INNER JOIN training.course as B on A.CourseId = B.CourseId
GROUP BY B.Name
ORDER BY count(*) DESC LIMIT 1;

/*DROP database training;*/






