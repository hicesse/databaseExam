-- Question 1
-- Find the IDs of all students who were taught by an instructor named Einstein;
-- make sure there are no duplicates in the result.

SELECT DISTINCT t.ID
FROM instructor i
JOIN teaches te
    ON i.ID = te.ID
JOIN takes t
    ON te.course_id = t.course_id
   AND te.sec_id = t.sec_id
   AND te.semester = t.semester
   AND te.year = t.year
WHERE i.name = 'Einstein';

-- Question 2
-- Find all instructors earning the highest salary 
-- (there may be more than one with the same salary).

SELECT ID, name, dept_name, salary
FROM instructor
WHERE salary = (
    SELECT MAX(salary)
    FROM instructor
);

-- Question 3
-- Find the titles of courses in the Comp. Sci. department that have 3 credits.

SELECT title
FROM course
WHERE dept_name = 'Comp. Sci.'
AND credits = 3;

-- Question 4
-- Find the enrollment of each section that was offered in Fall 2017.

SELECT 
    s.course_id,
    s.sec_id,
    s.semester,
    s.year,
    COUNT(t.ID) AS enrollment
FROM section s
LEFT JOIN takes t
    ON s.course_id = t.course_id
   AND s.sec_id = t.sec_id
   AND s.semester = t.semester
   AND s.year = t.year
WHERE s.semester = 'Fall'
AND s.year = 2017
GROUP BY s.course_id, s.sec_id, s.semester, s.year;

-- Question 5
-- Find the maximum enrollment, across all sections, in Fall 2017.

SELECT MAX(enrollment) AS max_enrollment
FROM (
    SELECT COUNT(ID) AS enrollment
    FROM takes
    WHERE semester = 'Fall'
      AND year = 2017
    GROUP BY course_id, sec_id, semester, year
) AS section_enrollment;

-- Question 6
-- Find the sections that had the maximum enrollment in Fall 2017.

SELECT course_id, sec_id, semester, year
FROM takes
WHERE semester = 'Fall'
  AND year = 2017
GROUP BY course_id, sec_id, semester, year
HAVING COUNT(ID) = (
    SELECT MAX(enrollment)
    FROM (
        SELECT COUNT(ID) AS enrollment
        FROM takes
        WHERE semester = 'Fall'
          AND year = 2017
        GROUP BY course_id, sec_id, semester, year
    ) AS section_enrollment
);


-- ceckpoint sebelum tabel diubah(tidak perlu ditulis)

START TRANSACTION;
SET SQL_SAFE_UPDATES = 0;

-- Question 7
-- Increase the salary of each instructor in the Comp. Sci. department by 10%.

UPDATE instructor
SET salary = salary * 1.10
WHERE dept_name = 'Comp. Sci.';

-- Question 8
-- Delete all courses that have never been offered 
-- (that is, do not occur in the section relation).

-- hapus relasi prerequisite terlebih dahulu
DELETE FROM prereq
WHERE course_id NOT IN (
    SELECT course_id
    FROM section
);

-- baru hapus course
DELETE FROM course
WHERE course_id NOT IN (
    SELECT course_id
    FROM section
);

-- Question 9
-- Insert every student whose tot_cred attribute is greater than 100
-- as an instructor in the same department, with a salary of $10,000.

INSERT INTO instructor (ID, name, dept_name, salary)
SELECT ID, name, dept_name, 10000
FROM student
WHERE tot_cred > 100;

-- Question 10
-- List all course_id and title along with their prerequisite course_id 
-- and title for all courses.

SELECT 
    c.course_id,
    c.title,
    p.prereq_id,
    cp.title AS prereq_title
FROM course c
LEFT JOIN prereq p
    ON c.course_id = p.course_id
LEFT JOIN course cp
    ON p.prereq_id = cp.course_id;
    
    
-- akhir checkpoint (tidak perlu ditulis)
ROLLBACK;