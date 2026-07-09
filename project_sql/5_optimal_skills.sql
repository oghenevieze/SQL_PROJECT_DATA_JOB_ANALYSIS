/*
Question: What are the most optimal skills to learn (i.e It isin high demand and a high-paying skill)
-Identify skills in high demand and associated with high average salaries for data analyst roles
-Concentrate on remote positions with specified salaries.
-Why? Targets skills that offerjob security (high demand) and financial benefits (high salaries),
        offering strategic insights for career development in data analysis.
*/

WITH skills_demand as (     
    SELECT 
    skills_dim.skill_id,
    count(job_postings_fact.job_id) AS Number_of_postings,
    skills_dim.skills
    FROM job_postings_fact
    INNER JOIN skills_job_dim
    ON Skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim
    ON Skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
    job_postings_fact.job_title IN ('Data Analyst')
    AND job_postings_fact.salary_year_avg is not NULL
    AND job_postings_fact.job_work_from_home IS TRUE
    GROUP BY
    skills_dim.skill_id
),
 average_salary as (
   SELECT
    skills_dim.skill_id, 
    skills_dim.skills,
    Round(avg(job_postings_fact.salary_year_avg)) as avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim
    ON Skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim
    ON Skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
    job_postings_fact.job_title IN ('Data Analyst')
    AND job_postings_fact.salary_year_avg is not NULL
    AND job_postings_fact.job_work_from_home IS TRUE
    GROUP BY
    skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    average_salary.skills,
    skills_demand.Number_of_postings,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary
ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.Number_of_postings > 5
ORDER BY 
    average_salary.avg_salary DESC,
    skills_demand.Number_of_postings DESC
LIMIT 50;
