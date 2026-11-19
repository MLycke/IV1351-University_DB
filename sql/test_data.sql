
CREATE TABLE course_layout (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    course_code VARCHAR(500) UNIQUE NOT NULL,
    course_name VARCHAR(500) NOT NULL,
    min_students INT NOT NULL,
    max_students INT NOT NULL,
    hp NUMERIC(4,1) NOT NULL,
    CONSTRAINT PK_course_layout PRIMARY KEY (id)
);


CREATE TABLE department (
    manager VARCHAR(500) NOT NULL,
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    department_name VARCHAR(500) UNIQUE NOT NULL,
    CONSTRAINT PK_department PRIMARY KEY (manager, id)
);


CREATE TABLE job_title (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    job_title VARCHAR(500) UNIQUE NOT NULL,
    CONSTRAINT PK_job_title PRIMARY KEY (id)
);


CREATE TABLE person (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    personal_number VARCHAR(12) UNIQUE NOT NULL,
    first_name VARCHAR(500) NOT NULL,
    last_name VARCHAR(500) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(500),
    CONSTRAINT PK_person PRIMARY KEY (id)
);


CREATE TABLE teaching_activity (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    activity_name VARCHAR(500) UNIQUE NOT NULL,
    factor NUMERIC(5,2) NOT NULL,
    CONSTRAINT PK_teaching_activity PRIMARY KEY (id)
);


CREATE TABLE course_instance (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    instance_id VARCHAR(500) UNIQUE NOT NULL,
    num_students INT NOT NULL,
    study_period INT NOT NULL,
    study_year INT NOT NULL,
    course_layout_id INT NOT NULL,
    CONSTRAINT PK_course_instance PRIMARY KEY (id)
);


CREATE TABLE employee (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    employment_id VARCHAR(500) UNIQUE NOT NULL,
    skill_set VARCHAR(500),
    salary NUMERIC(10,2) NOT NULL,
    person_id INT NOT NULL,
    job_title_id INT NOT NULL,
    department_id INT NOT NULL,
    manager VARCHAR(500) NOT NULL,
    CONSTRAINT PK_employee PRIMARY KEY (id)
);


CREATE TABLE planned_activity (
    course_instance_id INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    planned_hours NUMERIC(6,1) NOT NULL,
    CONSTRAINT PK_planned_activity PRIMARY KEY (course_instance_id, teaching_activity_id)
);


CREATE TABLE employee_planned_activity (
    employee_id INT NOT NULL,
    course_instance_id INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    allocated_hours NUMERIC(6,1) NOT NULL,
    CONSTRAINT PK_employee_planned_activity PRIMARY KEY (employee_id, course_instance_id, teaching_activity_id)
);


-- Foreign keys

ALTER TABLE course_instance
ADD CONSTRAINT FK_course_instance_0
FOREIGN KEY (course_layout_id) REFERENCES course_layout (id);


ALTER TABLE employee
ADD CONSTRAINT FK_employee_0
FOREIGN KEY (person_id) REFERENCES person (id);

ALTER TABLE employee
ADD CONSTRAINT FK_employee_1
FOREIGN KEY (job_title_id) REFERENCES job_title (id);

ALTER TABLE employee
ADD CONSTRAINT FK_employee_2
FOREIGN KEY (manager, department_id) REFERENCES department (manager, id);


ALTER TABLE planned_activity
ADD CONSTRAINT FK_planned_activity_0
FOREIGN KEY (course_instance_id) REFERENCES course_instance (id);

ALTER TABLE planned_activity
ADD CONSTRAINT FK_planned_activity_1
FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity (id);


ALTER TABLE employee_planned_activity
ADD CONSTRAINT FK_employee_planned_activity_0
FOREIGN KEY (employee_id) REFERENCES employee (id);

ALTER TABLE employee_planned_activity
ADD CONSTRAINT FK_employee_planned_activity_1
FOREIGN KEY (course_instance_id, teaching_activity_id)
REFERENCES planned_activity (course_instance_id, teaching_activity_id);
