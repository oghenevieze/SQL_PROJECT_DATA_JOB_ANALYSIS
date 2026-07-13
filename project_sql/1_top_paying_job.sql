/*
Question: What are the top-paying data analyst jobs?
-Identify the top 10 highest paying data analyst roles that are available remotely.
-Focuses on job postings with specified salaries (remove nulls).
-Why? Highlight the top paying oppurtunities for data analysts, offering insights into employment benefits and opportunities
*/

SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    company.name as hiring_firm,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date
FROM 
    job_postings_fact
-- The addition of the company's information aids the application process
LEFT JOIN company_dim As company
ON company.company_id = job_postings_fact.company_id
WHERE 
    job_title IN ('Data Analyst')
    AND job_location = 'Anywhere'
    AND (salary_year_avg IS NOT NULL)
ORDER BY
    salary_year_avg DESC
LIMIT 10;