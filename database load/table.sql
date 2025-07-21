DROP TABLE IF EXISTS student_migration_4
CREATE TABLE student_migration_4 (
    student_id VARCHAR(20) PRIMARY KEY,                
    origin_country VARCHAR(100),
    destination_country VARCHAR(100),
    destination_city VARCHAR(100),                                
                             
    university_name TEXT,
    course_name TEXT,
    field_of_study VARCHAR(100),

    year_of_enrollment INT,                            -- e.g., 2022
    scholarship_received BOOLEAN,                      -- TRUE/FALSE or 1/0
    enrollment_reason TEXT,      
                                               
    graduation_year INT,                      
    placement_status VARCHAR(20),                      -- Placed / Not Placed
    placement_country VARCHAR(100),
    placement_company TEXT,

    starting_salary_usd NUMERIC(12, 2),                -- allows larger salary values
    gpa_or_score VARCHAR(20),                          -- e.g., "3.5", "85%", "A+"
    visa_status VARCHAR(50),  -- e.g., "Student Visa"

    post_graduation_visa VARCHAR(50),                  -- e.g., "Work Permit"
    language_proficiency_test VARCHAR(50),             -- e.g., IELTS, TOEFL
    test_score VARCHAR(20)                             -- e.g., "7.5", "110", "C1"
);
COPY student_migration_4
FROM 'D:\.MY PERSONAL DATA/programming Practice/Data Analytics/Real Dataset Practice/global_student_migration/Code of the project/csv file/global_student_migration.csv'
DELIMITER ','
CSV HEADER;
