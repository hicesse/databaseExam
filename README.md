# University Database Schema – SQL Implementation

## Overview

This project implements a relational database based on the **University Schema** used in the Database System mid-term examination.
The database models a university academic system including departments, instructors, students, courses, sections, and enrollments.

The SQL script contains:

* Table creation (DDL)
* Primary key and foreign key constraints
* Sample data insertion (DML)

The structure follows the schema provided in the exam document.

---

# Database Structure

The database consists of the following tables:

### Core Tables

1. **department**
   Stores information about academic departments.

2. **classroom**
   Contains classroom locations and capacity.

3. **course**
   Stores course information including course title, department, and credits.

4. **instructor**
   Contains instructor information and their department affiliation.

5. **student**
   Stores student data and total credits earned.

---

### Academic Activity Tables

6. **section**
   Represents specific offerings of a course in a particular semester and year.

7. **teaches**
   Connects instructors with the sections they teach.

8. **takes**
   Records which students take which course sections and their grades.

9. **advisor**
   Links students with their academic advisors.

---

### Scheduling Tables

10. **time_slot**
    Stores information about class schedule times.
    Each `time_slot_id` may correspond to multiple days (for example Monday, Wednesday, Friday).

Example:

| time_slot_id | day | start_time | end_time |
| ------------ | --- | ---------- | -------- |
| A            | M   | 08:00      | 08:50    |
| A            | W   | 08:00      | 08:50    |
| A            | F   | 08:00      | 08:50    |

When a section references `time_slot_id = 'A'`, it means the class meets on **multiple days using that slot**.

---

### Dependency Tables

11. **prereq**
    Stores prerequisite relationships between courses.

---

# Table Relationships

Key relationships in the schema include:

* `course.dept_name` → `department.dept_name`

* `instructor.dept_name` → `department.dept_name`

* `student.dept_name` → `department.dept_name`

* `section.course_id` → `course.course_id`

* `section.building, room_number` → `classroom(building, room_number)`

* `section.time_slot_id` → `time_slot.time_slot_id`

* `teaches.ID` → `instructor.ID`

* `teaches(course_id, sec_id, semester, year)` → `section`

* `takes.ID` → `student.ID`

* `takes(course_id, sec_id, semester, year)` → `section`

* `advisor.s_id` → `student.ID`

* `advisor.i_id` → `instructor.ID`

---

# Data Insertion Order

To avoid foreign key constraint errors, tables must be populated in the correct order:

1. classroom
2. department
3. course
4. instructor
5. student
6. time_slot
7. prereq
8. section
9. teaches
10. takes

This order ensures that referenced parent records exist before inserting dependent records.

---

# Features of the Implementation

* Uses **composite primary keys** for `section`, `teaches`, and `takes`
* Uses **foreign key constraints** to enforce relational integrity
* Implements **time_slot scheduling system**
* Includes **sample dataset from the provided schema**

---

# Example Query

Example query to see student course enrollments:

```sql
SELECT s.name, c.title, t.grade
FROM takes t
JOIN student s ON s.ID = t.ID
JOIN course c ON c.course_id = t.course_id;
```

---

# Conclusion

This database demonstrates the implementation of a university academic system using relational database design principles including:

* normalization
* primary and foreign key relationships
* composite keys
* structured data insertion
