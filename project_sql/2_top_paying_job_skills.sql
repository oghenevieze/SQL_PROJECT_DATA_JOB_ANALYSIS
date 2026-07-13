/*
Question: What skills are required for the top-paying data analyst jobs?
-Use the the top 10 paying data analyst jobs from the first query.
-Add the specific skills required for these roles.
-Why? It provides a detailed look at which high-paying jobs demand certain skills,
        helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_job As (
    SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    company.name as hiring_firm,
    job_postings_fact.job_location,
    job_postings_fact.salary_year_avg
    FROM 
    job_postings_fact
-- The addition of the company's information aids application 
    LEFT JOIN company_dim As company
    ON company.company_id = job_postings_fact.company_id
    WHERE 
    job_title IN ('Data Analyst')
    AND job_location = 'Anywhere'
    AND (salary_year_avg IS NOT NULL)
    ORDER BY
    salary_year_avg DESC
    LIMIT 10
)
 SELECT 
    top_paying_job.job_id,
    top_paying_job.job_title,
    top_paying_job.hiring_firm,
    top_paying_job.job_location,
    top_paying_job.salary_year_avg,
    skills_dim.skills as job_skills
FROM
    top_paying_job
INNER JOIN skills_job_dim
ON Skills_job_dim.job_id = top_paying_job.job_id
INNER JOIN skills_dim
ON Skills_job_dim.skill_id = skills_dim.skill_id;

/* 
Analysis of the highest-paying remote Data Analyst postings ($135K–$165K) reveals a clear skill hierarchy:

Python (77%) and SQL (67%) are the dominant skills across nearly all top-paying roles, 
    confirming these two as the non-negotiable technical foundation for high-earning analyst positions.
R (56%) appears as a strong secondary language, often paired with Python rather than replacing it.
Visualization tools (Tableau, Looker, Power BI) each appear in ~30% of postings, 
    showing that technical skills alone aren't enough — communicating insights visually is equally valued.
Cloud/infrastructure skills (AWS, GCP, BigQuery, Kubernetes) cluster specifically in the $140K–$145K range,
     suggesting exposure to cloud data ecosystems provides a measurable pay premium over traditional desktop-tool-only roles (Excel/Power BI), which cluster closer to $135K
[
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "hiring_firm": "Plexus Resource Solutions",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "python"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "hiring_firm": "Plexus Resource Solutions",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "mysql"
  },
  {
    "job_id": 1246069,
    "job_title": "Data Analyst",
    "hiring_firm": "Plexus Resource Solutions",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "aws"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "sql"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "python"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "r"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "sas"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "matlab"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "pandas"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "tableau"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "looker"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Information Technology",
    "job_location": "Anywhere",
    "salary_year_avg": "165000.0",
    "job_skills": "sas"
  },
  {
    "job_id": 456042,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Healthcare",
    "job_location": "Anywhere",
    "salary_year_avg": "151500.0",
    "job_skills": "sql"
  },
  {
    "job_id": 456042,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Healthcare",
    "job_location": "Anywhere",
    "salary_year_avg": "151500.0",
    "job_skills": "python"
  },
  {
    "job_id": 456042,
    "job_title": "Data Analyst",
    "hiring_firm": "Get It Recruit - Healthcare",
    "job_location": "Anywhere",
    "salary_year_avg": "151500.0",
    "job_skills": "r"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "sql"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "python"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "r"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "golang"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "elasticsearch"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "aws"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "bigquery"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "gcp"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "pandas"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "scikit-learn"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "looker"
  },
  {
    "job_id": 479485,
    "job_title": "Data Analyst",
    "hiring_firm": "Level",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "kubernetes"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "python"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "java"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "r"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "javascript"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "c++"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "tableau"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "power bi"
  },
  {
    "job_id": 405581,
    "job_title": "Data Analyst",
    "hiring_firm": "CyberCoders",
    "job_location": "Anywhere",
    "salary_year_avg": "145000.0",
    "job_skills": "qlik"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "hiring_firm": "Uber",
    "job_location": "Anywhere",
    "salary_year_avg": "140500.0",
    "job_skills": "sql"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "hiring_firm": "Uber",
    "job_location": "Anywhere",
    "salary_year_avg": "140500.0",
    "job_skills": "python"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "hiring_firm": "Uber",
    "job_location": "Anywhere",
    "salary_year_avg": "140500.0",
    "job_skills": "r"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "hiring_firm": "Uber",
    "job_location": "Anywhere",
    "salary_year_avg": "140500.0",
    "job_skills": "swift"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "hiring_firm": "Uber",
    "job_location": "Anywhere",
    "salary_year_avg": "140500.0",
    "job_skills": "excel"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "hiring_firm": "Uber",
    "job_location": "Anywhere",
    "salary_year_avg": "140500.0",
    "job_skills": "tableau"
  },
  {
    "job_id": 1090975,
    "job_title": "Data Analyst",
    "hiring_firm": "Uber",
    "job_location": "Anywhere",
    "salary_year_avg": "140500.0",
    "job_skills": "looker"
  },
  {
    "job_id": 1482852,
    "job_title": "Data Analyst",
    "hiring_firm": "Overmind",
    "job_location": "Anywhere",
    "salary_year_avg": "138500.0",
    "job_skills": "sql"
  },
  {
    "job_id": 1482852,
    "job_title": "Data Analyst",
    "hiring_firm": "Overmind",
    "job_location": "Anywhere",
    "salary_year_avg": "138500.0",
    "job_skills": "python"
  },
  {
    "job_id": 1326467,
    "job_title": "Data Analyst",
    "hiring_firm": "EPIC Brokers",
    "job_location": "Anywhere",
    "salary_year_avg": "135000.0",
    "job_skills": "excel"
  },
  {
    "job_id": 479965,
    "job_title": "Data Analyst",
    "hiring_firm": "InvestM Technology LLC",
    "job_location": "Anywhere",
    "salary_year_avg": "135000.0",
    "job_skills": "sql"
  },
  {
    "job_id": 479965,
    "job_title": "Data Analyst",
    "hiring_firm": "InvestM Technology LLC",
    "job_location": "Anywhere",
    "salary_year_avg": "135000.0",
    "job_skills": "excel"
  },
  {
    "job_id": 479965,
    "job_title": "Data Analyst",
    "hiring_firm": "InvestM Technology LLC",
    "job_location": "Anywhere",
    "salary_year_avg": "135000.0",
    "job_skills": "power bi"
  }
]
*/