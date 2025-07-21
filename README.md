# Students highest scores and Scholarships Analysis

This dataset contains the students origin_country, their destination_country with test_scores,scholarships and many more.

## 🎯 Project Objectives:
- To find from which country students are scoring best in test scores
- to which country students are migrating to after their test scores

## 📝 Explanation:

I first created a database and then loaded the data into it:

```sql

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

```


Then i filtered the data to check for the origin_country_destination_countr and their test scores

```sql
WITH filtered_students AS (
    SELECT
        origin_country,
        destination_country,
        scholarship_received,
        test_score,
        CASE
            WHEN test_score ~ '^\d+(\.\d+)?$' THEN test_score::NUMERIC
            ELSE NULL
        END AS numeric_score
    FROM student_migration_4
    WHERE scholarship_received = TRUE
),
top_scores AS (
    SELECT
        destination_country,
        MAX(numeric_score) AS highest_score
    FROM filtered_students
    GROUP BY destination_country
)
SELECT 
    fs.origin_country,
    fs.destination_country,
    fs.numeric_score AS test_score
FROM filtered_students fs
JOIN top_scores ts
  ON fs.destination_country = ts.destination_country
 AND fs.numeric_score = ts.highest_score
ORDER BY fs.test_score DESC;

```

And i filter the data even more to see the total_scholarships

```sql
SELECT 
    destination_country,
    COUNT(*) AS total_scholarship_students
FROM student_migration_4
WHERE scholarship_received = TRUE
GROUP BY destination_country
ORDER BY total_scholarship_students DESC;
```