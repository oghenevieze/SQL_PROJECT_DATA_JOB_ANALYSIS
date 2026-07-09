/*
Question: What are the most in-demand skills for data analysts?
-Join job postings to inner join table similar to query 2.
-Identify the top 5 in-demand skills for data analyst.
-Focus on allthe job postings.
Why? Retrieves the top 5 skills with the highest demand in the job market,
        providing insights into the most valuable skills for job seekers.
*/

SELECT 
    count(job_postings_fact.job_id) AS Number_of_postings,
    skills_dim.skills
FROM job_postings_fact
INNER JOIN skills_job_dim
ON Skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
ON Skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title IN ('Data Analyst')
GROUP BY
    skills_dim.skills
ORDER BY
    Number_of_postings DESC
LIMIT 5;

