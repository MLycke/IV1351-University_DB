
BEGIN;

-- 1. Course layouts
INSERT INTO course_layout
    (course_code, course_name, min_students, max_students, hp)
VALUES
    ('DB101', 'Introduction to Databases', 10, 40, 7.5),
    ('DB102', 'Database Design', 10, 35, 7.5),
    ('DB201', 'Advanced Database Systems', 8, 30, 7.5);

-- 2. Departments
INSERT INTO department (manager, department_name)
VALUES
    ('Alex Morgan', 'Computer Science'),
    ('Sam Taylor', 'Information Systems');

-- 3. Job titles
INSERT INTO job_title (job_title)
VALUES
    ('Lecturer'),
    ('Senior Lecturer'),
    ('Teaching Assistant');

-- 4. Persons
INSERT INTO person
    (personal_number, first_name, last_name, phone_number, address)
VALUES
    ('199001010001', 'Jamie', 'Andersson', '0701234567', 'Stockholm'),
    ('198505050002', 'Robin', 'Berg', '0702345678', 'Uppsala'),
    ('199203030003', 'Taylor', 'Lind', '0703456789', 'Stockholm'),
    ('199507070004', 'Casey', 'Nilsson', '0704567890', 'Solna');

-- 5. Teaching activities
INSERT INTO teaching_activity (activity_name, factor)
VALUES
    ('Lecture', 1.50),
    ('Seminar', 1.00),
    ('Laboratory', 1.25),
    ('Examination', 1.00);

-- 6. Course instances
INSERT INTO course_instance
    (instance_id, num_students, study_period, study_year, course_layout_id)
SELECT
    'DB101-2026-P1', 35, 1, 2026, id
FROM course_layout WHERE course_code = 'DB101';

INSERT INTO course_instance
    (instance_id, num_students, study_period, study_year, course_layout_id)
SELECT
    'DB102-2026-P1', 30, 1, 2026, id
FROM course_layout WHERE course_code = 'DB102';

INSERT INTO course_instance
    (instance_id, num_students, study_period, study_year, course_layout_id)
SELECT
    'DB201-2026-P1', 25, 1, 2026, id
FROM course_layout WHERE course_code = 'DB201';

INSERT INTO course_instance
    (instance_id, num_students, study_period, study_year, course_layout_id)
SELECT
    'DB101-2026-P2', 32, 2, 2026, id
FROM course_layout WHERE course_code = 'DB101';

-- 7. Employees
INSERT INTO employee
    (employment_id, skill_set, salary, person_id,
     job_title_id, department_id, manager)
VALUES
    ('EMP001', 'Databases, SQL', 42000.00,
     (SELECT id FROM person WHERE personal_number = '199001010001'),
     (SELECT id FROM job_title WHERE job_title = 'Senior Lecturer'),
     (SELECT id FROM department
      WHERE department_name = 'Computer Science' AND manager = 'Alex Morgan'),
     'Alex Morgan'),

    ('EMP002', 'Database design, teaching', 39000.00,
     (SELECT id FROM person WHERE personal_number = '198505050002'),
     (SELECT id FROM job_title WHERE job_title = 'Lecturer'),
     (SELECT id FROM department
      WHERE department_name = 'Computer Science' AND manager = 'Alex Morgan'),
     'Alex Morgan'),

    ('EMP003', 'Programming, laboratory work', 32000.00,
     (SELECT id FROM person WHERE personal_number = '199203030003'),
     (SELECT id FROM job_title WHERE job_title = 'Teaching Assistant'),
     (SELECT id FROM department
      WHERE department_name = 'Information Systems' AND manager = 'Sam Taylor'),
     'Sam Taylor'),

    ('EMP004', 'Examination, SQL', 41000.00,
     (SELECT id FROM person WHERE personal_number = '199507070004'),
     (SELECT id FROM job_title WHERE job_title = 'Lecturer'),
     (SELECT id FROM department
      WHERE department_name = 'Information Systems' AND manager = 'Sam Taylor'),
     'Sam Taylor');

-- 8. Planned activities
INSERT INTO planned_activity
    (course_instance_id, teaching_activity_id, planned_hours)
VALUES
    ((SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 10.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Seminar'), 5.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB102-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 12.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB102-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Seminar'), 6.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB201-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 8.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB201-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Laboratory'), 10.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB201-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Examination'), 6.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P2'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 9.0),

    ((SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P2'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Seminar'), 4.0);

-- 9. Employee allocations
INSERT INTO employee_planned_activity
    (employee_id, course_instance_id, teaching_activity_id, allocated_hours)
VALUES
    -- EMP001: allocated to four course instances in study period 1
    ((SELECT id FROM employee WHERE employment_id = 'EMP001'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 6.0),

    ((SELECT id FROM employee WHERE employment_id = 'EMP001'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB102-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 7.0),

    ((SELECT id FROM employee WHERE employment_id = 'EMP001'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB201-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 5.0),

    ((SELECT id FROM employee WHERE employment_id = 'EMP001'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P2'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Lecture'), 5.0),

    -- Other employee allocations
    ((SELECT id FROM employee WHERE employment_id = 'EMP002'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Seminar'), 3.0),

    ((SELECT id FROM employee WHERE employment_id = 'EMP002'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB102-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Seminar'), 4.0),

    ((SELECT id FROM employee WHERE employment_id = 'EMP003'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB201-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Laboratory'), 8.0),

    ((SELECT id FROM employee WHERE employment_id = 'EMP004'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB201-2026-P1'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Examination'), 4.0),

    ((SELECT id FROM employee WHERE employment_id = 'EMP002'),
     (SELECT id FROM course_instance WHERE instance_id = 'DB101-2026-P2'),
     (SELECT id FROM teaching_activity WHERE activity_name = 'Seminar'), 2.0);

COMMIT;
