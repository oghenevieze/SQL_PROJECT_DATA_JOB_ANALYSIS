/*
Question: What are the top skills based on salary?
-Look at the average salary associated with each skill for data analyst positions.
-Focuses on roles with specified salaries, regardless of location.
-Why? It reveals how different skills impact salary levels for data analyst and 
        helps identify the most financiallyy rewarding skills to acquire or harness.
*/

SELECT 
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
    skills_dim.skills
ORDER BY 
    avg_salary DESC
LIMIT 50;

/*
Insight:
The highest-paying skills for Data Analyst roles cluster around three areas: niche engineering/DevOps tools (Golang, Kubernetes, Elasticsearch — all $145,000), 
    cloud and big data platforms (GCP, Databricks, AWS, Snowflake, BigQuery — $93,500–$123,750), and Python's ML/data ecosystem (Pandas, Scikit-learn, NumPy — $118,000–$126,000), 
    which pay noticeably more than plain Python itself ($95,080). By contrast, traditional BI and office tools like SQL ($90,624), Power BI ($91,098), Tableau ($93,863), 
    and Excel-adjacent skills (VBA, MS Access) sit near the bottom, 
    suggesting these are now baseline expectations rather than salary differentiators.

The clear takeaway is that pay premiums go to analysts who extend beyond core reporting into engineering-adjacent or ML-adjacent skill sets — cloud infrastructure and applied Python 
    libraries offer the best ROI for upskilling, since they signal a candidate can operate closer to data engineering or data science than traditional analytics.

[
  {
    "skills": "golang",
    "avg_salary": "145000",
    "count": "1"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "145000",
    "count": "1"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000",
    "count": "1"
  },
  {
    "skills": "swift",
    "avg_salary": "140500",
    "count": "1"
  },
  {
    "skills": "pandas",
    "avg_salary": "125913",
    "count": "5"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "125781",
    "count": "2"
  },
  {
    "skills": "gcp",
    "avg_salary": "123750",
    "count": "2"
  },
  {
    "skills": "databricks",
    "avg_salary": "120000",
    "count": "2"
  },
  {
    "skills": "numpy",
    "avg_salary": "118281",
    "count": "2"
  },
  {
    "skills": "vba",
    "avg_salary": "115000",
    "count": "1"
  },
  {
    "skills": "ibm cloud",
    "avg_salary": "111500",
    "count": "1"
  },
  {
    "skills": "unix",
    "avg_salary": "110000",
    "count": "2"
  },
  {
    "skills": "aws",
    "avg_salary": "105278",
    "count": "9"
  },
  {
    "skills": "outlook",
    "avg_salary": "104833",
    "count": "3"
  },
  {
    "skills": "c++",
    "avg_salary": "103500",
    "count": "4"
  },
  {
    "skills": "matlab",
    "avg_salary": "102750",
    "count": "4"
  },
  {
    "skills": "qlik",
    "avg_salary": "101588",
    "count": "8"
  },
  {
    "skills": "dax",
    "avg_salary": "101000",
    "count": "4"
  },
  {
    "skills": "java",
    "avg_salary": "100000",
    "count": "4"
  },
  {
    "skills": "sap",
    "avg_salary": "100000",
    "count": "1"
  },
  {
    "skills": "atlassian",
    "avg_salary": "100000",
    "count": "1"
  },
  {
    "skills": "ms access",
    "avg_salary": "98857",
    "count": "2"
  },
  {
    "skills": "github",
    "avg_salary": "98333",
    "count": "3"
  },
  {
    "skills": "looker",
    "avg_salary": "98128",
    "count": "20"
  },
  {
    "skills": "bigquery",
    "avg_salary": "97500",
    "count": "4"
  },
  {
    "skills": "javascript",
    "avg_salary": "96182",
    "count": "11"
  },
  {
    "skills": "ssis",
    "avg_salary": "95833",
    "count": "3"
  },
  {
    "skills": "python",
    "avg_salary": "95080",
    "count": "76"
  },
  {
    "skills": "microstrategy",
    "avg_salary": "95000",
    "count": "1"
  },
  {
    "skills": "tableau",
    "avg_salary": "93863",
    "count": "71"
  },
  {
    "skills": "r",
    "avg_salary": "93704",
    "count": "49"
  },
  {
    "skills": "snowflake",
    "avg_salary": "93667",
    "count": "9"
  },
  {
    "skills": "confluence",
    "avg_salary": "93500",
    "count": "4"
  },
  {
    "skills": "jenkins",
    "avg_salary": "93500",
    "count": "2"
  },
  {
    "skills": "hadoop",
    "avg_salary": "93140",
    "count": "5"
  },
  {
    "skills": "git",
    "avg_salary": "92750",
    "count": "4"
  },
  {
    "skills": "sql server",
    "avg_salary": "92143",
    "count": "7"
  },
  {
    "skills": "power bi",
    "avg_salary": "91098",
    "count": "36"
  },
  {
    "skills": "jira",
    "avg_salary": "90786",
    "count": "7"
  },
  {
    "skills": "sql",
    "avg_salary": "90624",
    "count": "121"
  },
  {
    "skills": "mysql",
    "avg_salary": "90500",
    "count": "5"
  },
  {
    "skills": "visio",
    "avg_salary": "90000",
    "count": "1"
  },
  {
    "skills": "microsoft teams",
    "avg_salary": "90000",
    "count": "1"
  },
  {
    "skills": "shell",
    "avg_salary": "90000",
    "count": "1"
  },
  {
    "skills": "clickup",
    "avg_salary": "90000",
    "count": "1"
  },
  {
    "skills": "vb.net",
    "avg_salary": "90000",
    "count": "1"
  },
  {
    "skills": "html",
    "avg_salary": "90000",
    "count": "1"
  },
  {
    "skills": "sas",
    "avg_salary": "89859",
    "count": "44"
  },
  {
    "skills": "ssrs",
    "avg_salary": "89375",
    "count": "4"
  },
  {
    "skills": "powerpoint",
    "avg_salary": "89351",
    "count": "14"
  }
]
*/