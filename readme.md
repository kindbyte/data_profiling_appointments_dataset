📊 Appointments Data Profiling

This project performs a comprehensive data profiling of an appointments dataset to understand data quality, distribution, and anomalies. The analysis covers frequency counts, missing values, outliers detection, duplicates removal, and basic descriptive statistics.

📌 SQL Queries Overview

Frequency of Gender
SELECT gender, COUNT(*) AS frequency
FROM appointments
GROUP BY gender
ORDER BY frequency;
Goal: Analyze the distribution of patients by gender.
Insight: Understand if the dataset is balanced or skewed towards a particular gender.

Rare Neighbourhoods (frequency < 100)
SELECT neighbourhood, COUNT(*) AS frequency
FROM appointments
GROUP BY neighbourhood
HAVING COUNT(*) < 100
ORDER BY frequency;
Goal: Identify neighbourhoods with low appointment counts (rare categories).
Insight: These might be outliers or require special attention in analysis.

Missing vs Present Values in Gender
SELECT 'missing' AS status, COUNT(*) AS count
FROM appointments
WHERE gender IS NULL
UNION ALL
SELECT 'present' AS status, COUNT(*) AS count
FROM appointments
WHERE gender IS NOT NULL;
Goal: Check completeness of the gender field by counting missing and present values.
Insight: Helps assess data quality and completeness for this key demographic attribute.

Outlier Detection on Age using IQR Method
WITH percentiles AS (
  SELECT
    percentile_cont(0.25) WITHIN GROUP (ORDER BY age) AS q1,
    percentile_cont(0.75) WITHIN GROUP (ORDER BY age) AS q3
  FROM appointments
),
iqr AS (
  SELECT q1, q3, q3 - q1 AS iqr
  FROM percentiles
)
SELECT a.*, i.iqr
FROM appointments a
CROSS JOIN iqr i
WHERE a.age < i.q1 - 1.5 * i.iqr
   OR a.age > i.q3 + 1.5 * i.iqr;
Goal: Identify outliers in patient ages using the Interquartile Range (IQR) method.
Insight: Detects unusually young or old patients that may affect downstream analysis.

Count of Unique Values by Columns
SELECT
  COUNT(DISTINCT gender) AS gender_count,
  COUNT(DISTINCT neighbourhood) AS neighbourhood_count,
  COUNT(DISTINCT age) AS age_count,
  COUNT(DISTINCT appointmentday::date) AS app_date_count
FROM appointments;
Goal: Understand data diversity by counting distinct values in key columns.

Removing Duplicate Records
WITH duplicates AS (
  SELECT ctid,
         ROW_NUMBER() OVER (
           PARTITION BY patientid, appointmentday, scheduledday
           ORDER BY patientid
         ) AS row_number
  FROM appointments
)
DELETE FROM appointments a
USING duplicates d
WHERE a.ctid = d.ctid
  AND d.row_number > 1;
Goal: Remove duplicate appointment records based on patient and appointment dates, keeping only the first occurrence.

Basic Age Statistics
SELECT
  MIN(age) AS min_age,
  MAX(age) AS max_age,
  AVG(age) AS avg_age,
  percentile_cont(0.5) WITHIN GROUP (ORDER BY age) AS median_age
FROM appointments;
Goal: Calculate minimum, maximum, average, and median age of patients.
Insight: Provides summary statistics to understand the age distribution.

🛠️ Tools Used

PostgreSQL — for querying and data profiling
DBeaver — database client for query execution

