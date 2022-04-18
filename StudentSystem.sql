CREATE DATABASE StudentSystemDB

USE StudentSystemDB

CREATE TABLE Students
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(20),
    Surname NVARCHAR(20),
    BirthDate DATETIME2
)

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
    ExamDate DATETIME2
)

CREATE TABLE StudentExams
(
    Id INT PRIMARY KEY IDENTITY,
    Result INT
)

ALTER TABLE Students
ADD GroupId INT FOREIGN KEY REFERENCES Groups(Id)

ALTER TABLE Exams
ADD SubjectId INT FOREIGN KEY REFERENCES Subjects(Id)

ALTER TABLE StudentExams
ADD StudentId INT FOREIGN KEY REFERENCES Students(Id)

ALTER TABLE StudentExams
ADD ExamId INT FOREIGN KEY REFERENCES Exams(Id)

INSERT INTO Students(Name, Surname, BirthDate)
VALUES
('Asif', 'Allazov', '2001-02-21'),
('Huseyn', 'Alizadeh', '2000-12-10'),
('Cavansir', 'Memmedov', '2001-01-10'),
('Vuqar', 'Memmedov', '2002-09-15'),
('Nermin', 'Qafarzade', '2000-05-26')

INSERT INTO Groups(No)
VALUES
('11A')

UPDATE Students
SET GroupId = 1

INSERT INTO Subjects(Name)
VALUES
('Math'),
('Physics'),
('Geography'),
('Chemistry')

INSERT INTO Exams(ExamDate)
VALUES
('2020-10-11'),
('2021-05-10'),
('2021-09-11')

INSERT INTO StudentExams(Result)
VALUES
(55),
(58),
(91),
(89),
(90),
(86),
(88),
(56)


SELECT * FROM Exams


SELECT Name, Surname, BirthDate, Groups.[No] AS 'Group No' FROM Students
LEFT JOIN Groups ON Students.GroupId = Groups.Id

SELECT Name, Surname, BirthDate, (SELECT COUNT(Id) FROM Exams WHERE Exams.Id = StudentExams.ExamId) AS 'Exam count' FROM Students
LEFT JOIN StudentExams ON Students.Id = StudentExams.ExamId

SELECT Name, Surname, BirthDate, ((SELECT COUNT(Id) FROM Exams WHERE Exams.Id = StudentExams.ExamId)=0) AS 'Exam count' FROM Students
LEFT JOIN StudentExams ON Students.Id = StudentExams.ExamId