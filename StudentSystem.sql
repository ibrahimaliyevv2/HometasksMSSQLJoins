CREATE DATABASE StudentSystemDB

USE StudentSystemDB

CREATE TABLE Students
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(20),
    Surname NVARCHAR(20),
    BirthDate DATETIME2
)

ALTER TABLE Students
ADD GroupId INT FOREIGN KEY REFERENCES Groups(Id)

INSERT INTO Groups(No)
VALUES
('11A')

UPDATE Students
SET GroupId = 1

CREATE TABLE Groups
(
    Id INT PRIMARY KEY IDENTITY,
    No NVARCHAR(20)
)

CREATE TABLE Subjects
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(20)
)

CREATE TABLE Exams
(
    Id INT PRIMARY KEY IDENTITY,
    ExamDate DATETIME2,
    SubjectId INT FOREIGN KEY REFERENCES Subjects(Id)
)

CREATE TABLE StudentExams
(
    Id INT PRIMARY KEY IDENTITY,
    Result INT,
    StudentId INT FOREIGN KEY REFERENCES Students(Id),
	ExamId INT FOREIGN KEY REFERENCES Exams(Id)
)


INSERT INTO Students(Name, Surname, BirthDate)
VALUES
('Asif', 'Allazov', '2001-02-21'),
('Huseyn', 'Alizadeh', '2000-12-10'),
('Cavansir', 'Memmedov', '2001-01-10'),
('Vuqar', 'Memmedov', '2002-09-15'),
('Nermin', 'Qafarzade', '2000-05-26')


INSERT INTO Subjects(Name)
VALUES
('Math'),
('Physics'),
('Geography'),
('Chemistry')

INSERT INTO Exams(ExamDate, SubjectId)
VALUES
('2020-10-11',1),
('2021-05-10',2),
('2021-09-11',3)

INSERT INTO StudentExams(Result)
VALUES
(80,2,4),
(90,1,2),
(97,1,1),
(35,2,2),
(56,3,1)


SELECT * FROM Exams


SELECT Name, Surname, BirthDate, Groups.No FROM Students
JOIN Groups ON GroupId=Groups.Id

SELECT *,(SELECT COUNT(ExamId) FROM StudentExams WHERE StudentId=Students.Id) AS 'Exam count' FROM Students

SELECT * FROM Students where (SELECT COUNT(ExamId) FROM StudentExams WHERE StudentId=Students.Id)=0

SELECT *,(SELECT COUNT(StudentExams.ExamId) FROM StudentExams WHERE ExamId=Exams.Id) AS 'Student Count' FROM Exams
JOIN Subjects ON Subjects.Id = Exams.SubjectId  WHERE Exams.ExamDate = '2020-10-11'

SELECT StudentExams.Id,ExamId,StudentId,Result,Students.Name+' '+ Students.Surname AS 'Fullname',Groups.No FROM StudentExams JOIN Students ON StudentId=Students.Id JOIN Groups ON Students.GroupId=Groups.Id

SELECT Students.Id,Students.Name,Students.Surname,Students.GroupId,Result FROM Students JOIN StudentExams ON Students.Id=StudentId
