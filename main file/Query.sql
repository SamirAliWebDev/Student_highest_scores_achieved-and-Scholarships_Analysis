SELECT 
    destination_country,
    COUNT(*) AS total_scholarship_students
FROM student_migration_4
WHERE scholarship_received = TRUE
GROUP BY destination_country
ORDER BY total_scholarship_students DESC;



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
