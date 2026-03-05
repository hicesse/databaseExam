CREATE TABLE classroom (
    building VARCHAR(50),
    room_number INT,
    capacity INT NOT NULL,
    PRIMARY KEY (building, room_number)
);

CREATE TABLE department (
    dept_name VARCHAR(50),
    building VARCHAR(50),
    budget DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (dept_name)
);

CREATE TABLE course (
    course_id VARCHAR(10),
    title VARCHAR(100) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL,

    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE instructor (
    ID INT,
    name VARCHAR(100) NOT NULL,
    dept_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE section (
    course_id VARCHAR(10),
    sec_id INT,
    semester VARCHAR(10),
    year INT,
    building VARCHAR(50),
    room_number INT,
    time_slot_id VARCHAR(5),

    PRIMARY KEY (course_id, sec_id, semester, year),

    FOREIGN KEY (course_id) REFERENCES course(course_id),

    FOREIGN KEY (building, room_number)
    REFERENCES classroom(building, room_number)
);

CREATE TABLE teaches (
    ID INT,
    course_id VARCHAR(10),
    sec_id INT,
    semester VARCHAR(10),
    year INT,

    PRIMARY KEY (ID, course_id, sec_id, semester, year),

    FOREIGN KEY (ID)
    REFERENCES instructor(ID),

    FOREIGN KEY (course_id, sec_id, semester, year)
    REFERENCES section(course_id, sec_id, semester, year)
);

CREATE TABLE student (
    ID INT,
    name VARCHAR(100) NOT NULL,
    dept_name VARCHAR(50),
    tot_cred INT DEFAULT 0,

    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE takes (
    ID INT,
    course_id VARCHAR(10),
    sec_id INT,
    semester VARCHAR(10),
    year INT,
    grade VARCHAR(4),

    PRIMARY KEY (ID, course_id, sec_id, semester, year),

    FOREIGN KEY (ID)
        REFERENCES student(ID),

    FOREIGN KEY (course_id, sec_id, semester, year)
        REFERENCES section(course_id, sec_id, semester, year)
);

CREATE TABLE advisor (
    s_id INT,
    i_id INT,

    PRIMARY KEY (s_id),

    FOREIGN KEY (s_id)
        REFERENCES student(ID),

    FOREIGN KEY (i_id)
        REFERENCES instructor(ID)
);

CREATE TABLE time_slot (
    time_slot_id VARCHAR(5),
    day VARCHAR(2),

    start_time TIME,
    end_time TIME,

    start_hr INT,
    start_min INT,
    end_hr INT,
    end_min INT,

    PRIMARY KEY (time_slot_id, day)
);

ALTER TABLE section
ADD FOREIGN KEY (time_slot_id)
REFERENCES time_slot(time_slot_id);

CREATE TABLE prereq (
    course_id VARCHAR(10),
    prereq_id VARCHAR(10),

    PRIMARY KEY (course_id, prereq_id),

    FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    FOREIGN KEY (prereq_id)
        REFERENCES course(course_id)
);

INSERT INTO classroom VALUES
('Packard', 101, 500),
('Painter', 514, 10),
('Taylor', 3128, 70),
('Watson', 100, 30),
('Watson', 120, 50);

INSERT INTO department VALUES
('Biology', 'Watson', 90000),
('Comp. Sci.', 'Taylor', 100000),
('Elec. Eng.', 'Taylor', 85000),
('Finance', 'Painter', 120000),
('History', 'Painter', 50000),
('Music', 'Packard', 80000),
('Physics', 'Watson', 70000);

INSERT INTO course VALUES
('BIO-101','Intro. to Biology','Biology',4),
('BIO-301','Genetics','Biology',4),
('BIO-399','Computational Biology','Biology',3),
('CS-101','Intro. to Computer Science','Comp. Sci.',4),
('CS-190','Game Design','Comp. Sci.',4),
('CS-315','Robotics','Comp. Sci.',3),
('CS-319','Image Processing','Comp. Sci.',3),
('CS-347','Database System Concepts','Comp. Sci.',3),
('EE-181','Intro. to Digital Systems','Elec. Eng.',3),
('FIN-201','Investment Banking','Finance',3),
('HIS-351','World History','History',3),
('MU-199','Music Video Production','Music',3),
('PHY-101','Physical Principles','Physics',4);

INSERT INTO instructor VALUES
(10101,'Srinivasan','Comp. Sci.',65000),
(12121,'Wu','Finance',90000),
(15151,'Mozart','Music',40000),
(22222,'Einstein','Physics',95000),
(32343,'El Said','History',60000),
(33456,'Gold','Physics',87000),
(45565,'Katz','Comp. Sci.',75000),
(58583,'Califieri','History',62000),
(76543,'Singh','Finance',80000),
(76766,'Crick','Biology',72000),
(83821,'Brandt','Comp. Sci.',92000),
(98345,'Kim','Elec. Eng.',80000);

INSERT INTO student VALUES
(00128,'Zhang','Comp. Sci.',102),
(12345,'Shankar','Comp. Sci.',32),
(19991,'Brandt','History',80),
(23121,'Chavez','Finance',110),
(44553,'Peltier','Physics',56),
(45678,'Levy','Physics',46),
(54321,'Williams','Comp. Sci.',54),
(55739,'Sanchez','Music',38),
(70557,'Snow','Physics',0),
(76543,'Brown','Comp. Sci.',58),
(76653,'Aoi','Elec. Eng.',60),
(98765,'Bourikas','Elec. Eng.',98),
(98988,'Tanaka','Biology',120);

INSERT INTO time_slot VALUES
('A','M','08:00:00','08:50:00',8,0,8,50),
('A','W','08:00:00','08:50:00',8,0,8,50),
('A','F','08:00:00','08:50:00',8,0,8,50),

('B','M','09:00:00','09:50:00',9,0,9,50),
('B','W','09:00:00','09:50:00',9,0,9,50),
('B','F','09:00:00','09:50:00',9,0,9,50),

('C','M','11:00:00','11:50:00',11,0,11,50),
('C','W','11:00:00','11:50:00',11,0,11,50),
('C','F','11:00:00','11:50:00',11,0,11,50),

('D','M','13:00:00','13:50:00',13,0,13,50),
('D','W','13:00:00','13:50:00',13,0,13,50),
('D','F','13:00:00','13:50:00',13,0,13,50),

('E','T','10:30:00','11:45:00',10,30,11,45),
('E','R','10:30:00','11:45:00',10,30,11,45),

('F','T','14:30:00','15:45:00',14,30,15,45),
('F','R','14:30:00','15:45:00',14,30,15,45),

('G','M','16:00:00','16:50:00',16,0,16,50),
('G','W','16:00:00','16:50:00',16,0,16,50),
('G','F','16:00:00','16:50:00',16,0,16,50),

('H','W','10:00:00','12:30:00',10,0,12,30);

INSERT INTO prereq VALUES
('BIO-301','BIO-101'),
('BIO-399','BIO-101'),
('CS-190','CS-101'),
('CS-315','CS-101'),
('CS-319','CS-101'),
('CS-347','CS-101'),
('EE-181','PHY-101');

INSERT INTO section VALUES
('BIO-101',1,'Summer',2017,'Painter',514,'B'),
('BIO-301',1,'Summer',2018,'Painter',514,'A'),
('CS-101',1,'Fall',2017,'Packard',101,'H'),
('CS-101',1,'Spring',2018,'Packard',101,'F'),
('CS-190',1,'Spring',2017,'Taylor',3128,'E'),
('CS-190',2,'Spring',2017,'Taylor',3128,'A'),
('CS-315',1,'Spring',2018,'Watson',120,'D'),
('CS-319',1,'Spring',2018,'Watson',100,'B'),
('CS-319',2,'Spring',2018,'Taylor',3128,'C'),
('CS-347',1,'Fall',2017,'Taylor',3128,'A'),
('EE-181',1,'Spring',2017,'Taylor',3128,'C'),
('FIN-201',1,'Spring',2018,'Packard',101,'B'),
('HIS-351',1,'Spring',2018,'Painter',514,'C'),
('MU-199',1,'Spring',2018,'Packard',101,'D'),
('PHY-101',1,'Fall',2017,'Watson',100,'A');

INSERT INTO teaches VALUES
(10101,'CS-101',1,'Fall',2017),
(10101,'CS-315',1,'Spring',2018),
(10101,'CS-347',1,'Fall',2017),

(12121,'FIN-201',1,'Spring',2018),

(15151,'MU-199',1,'Spring',2018),

(22222,'PHY-101',1,'Fall',2017),

(32343,'HIS-351',1,'Spring',2018),

(45565,'CS-101',1,'Spring',2018),
(45565,'CS-319',1,'Spring',2018),

(76766,'BIO-101',1,'Summer',2017),
(76766,'BIO-301',1,'Summer',2018),

(83821,'CS-190',1,'Spring',2017),
(83821,'CS-190',2,'Spring',2017),
(83821,'CS-319',2,'Spring',2018),

(98345,'EE-181',1,'Spring',2017);

INSERT INTO takes VALUES
(00128,'CS-101', 1, 'Fall', 2017, 'A'),
(00128,'CS-347', 1, 'Fall', 2017, 'A-'),
(12345,'CS-101',1,'Fall',2017,'C'),
(12345,'CS-190',2,'Spring',2017,'A'),
(12345,'CS-315',1,'Spring',2018,'A'),
(12345,'CS-347',1,'Fall',2017,'A'),

(19991,'HIS-351',1,'Spring',2018,'B'),

(23121,'FIN-201',1,'Spring',2018,'C+'),

(44553,'PHY-101',1,'Fall',2017,'B-'),

(45678,'CS-101',1,'Fall',2017,'F'),
(45678,'CS-101',1,'Spring',2018,'B+'),
(45678,'CS-319',1,'Spring',2018,'B'),

(54321,'CS-101',1,'Fall',2017,'A-'),
(54321,'CS-190',2,'Spring',2017,'B+'),

(55739,'MU-199',1,'Spring',2018,'A-'),

(76543,'CS-101',1,'Fall',2017,'A'),
(76543,'CS-319',2,'Spring',2018,'A'),
(76653,'EE-181',1,'Spring',2017,'C'),

(98765,'CS-101',1,'Fall',2017,'C-'),
(98765,'CS-315',1,'Spring',2018,'B'),

(98988,'BIO-101',1,'Summer',2017,'A'),
(98988,'BIO-301',1,'Summer',2018,NULL);