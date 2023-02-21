--1
SELECT title
FROM course
WHERE dept_name = 'Comp. Sci.' AND credits = 3;

--2
SELECT DISTINCT course.course_id, course.title
FROM takes 
JOIN course ON course.course_id = takes.course_id
WHERE takes.id = '45678';

--3
SELECT course.course_id, course.title, SUM(course.credits) AS tot_credits
FROM takes 
JOIN course ON course.course_id = takes.course_id
WHERE takes.id = '45678'
GROUP BY course.course_id, course.title;

--4
SELECT student.id, SUM(course.credits) AS tot_credits
FROM student
INNER JOIN takes ON takes.id = student.id
INNER JOIN course ON course.course_id = takes.course_id
GROUP BY student.id;

--5
SELECT DISTINCT student.name
FROM student 
JOIN takes ON takes.ID = student.ID
JOIN course ON takes.course_id = course.course_id
WHERE course.dept_name = 'Comp. Sci.';

--6
SELECT instructor.id
FROM instructor
LEFT JOIN teaches ON instructor.id = teaches.id
WHERE teaches.id IS NULL;

--7
SELECT instructor.id, instructor.name
FROM instructor
LEFT JOIN teaches ON instructor.id = teaches.id
WHERE teaches.id IS NULL;
