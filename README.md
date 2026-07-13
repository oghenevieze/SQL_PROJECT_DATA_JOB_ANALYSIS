# Introduction
This project takes a closer look at the data analyst job market, identifying the roles that pay the most, the skills that show up most often, and the overlap where high demand meets high salary. The queries behind this analysis are laid out here: [project_sql folder](/project_sql/) for anyone curious to dig in.

# Background
As someone exploring a shift toward data analytics, I wanted answers to a very practical question: which data analyst jobs actually pay well, and what skills do they expect in return? This project uses SQL to dig through real job posting data and surface those answers.

### The questions I wanted to answer through my SQL queries were

1. What are the top paying data analyst jobs?
2. What skills are required for those top paying jobs?
3. What skills are most in demand for data analysts?
4. What skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used 
For this deep dive into the data analyst job market, I leaned on several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, well-suited for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project was aimed at investigating a specific aspect of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs 
To identify the highest-paying opportunities, I filtered data analyst positions by average yearly salary and location, focusing on remote roles. This query highlights the high-paying opportunities in the field.

```SQL
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
```
### 2. Skills for Top Paying Data Analyst Jobs
To understand what it takes to land one of these high-paying roles, I joined the top 10 highest-paying jobs from Query 1 with their associated skills, giving a clearer picture of what employers expect in exchange for top-tier salaries.

```SQL
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
```

### 3. In-Demand Skills for Data Analysts
This query counts how many job postings mention each skill, then narrows down to the top 5 most frequently requested skills across all data analyst postings.
```SQL
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
```

### 4. Top Skills Based on Salary
This query looks at the average salary tied to each skill for data analyst roles, focusing on remote positions with specified salaries, to see which skills actually move the needle on pay.
```SQL
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
```

### 5. Most Optimal Skills to Learn
This query combines demand (number of postings) and pay (average salary) for each skill, then filters to skills appearing in more than 5 postings — so the results highlight skills that are both genuinely in-demand and financially rewarding, rather than one-off high-salary outliers.
```SQL
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
```
# what I Learned
Throughtout this project, I've harnessed the use of :
- **Data Aggregation:** Got comfortable with GROUP BY, COUNT(), and AVG() to turn raw job posting data into meaningful summary statistics.
- **Joining Across Tables:** Practiced joining multiple related tables (job postings, companies, skills) to pull together a complete picture from normalized data.

# Conclusion
## Insights

From this analysis, several key insights emerged:

1. **Top-Paying Data Analyst Jobs:** Remote data analyst salaries at the top end span an enormous range, from $184,000 to $650,000, proving that title alone says little about pay. Company and role specifics matter far more.

2. **Skills Behind the Top-Paying Jobs:** Python and SQL show up most consistently among the highest earners, appearing in the majority of top-paying postings, with R close behind. This points to a shared technical foundation across the best-paying roles.

3. **Most In-Demand Skills:** SQL tops the list by a wide margin (24,099 postings), followed by Excel, Python, Tableau, and Power BI. This is a clear signal that query languages, spreadsheets, and visualization tools together make up the baseline toolkit employers expect.

4. **Skills Tied to the Highest Salaries:** Specialized, engineering-adjacent skills, including Golang, Kubernetes, cloud platforms like AWS and Databricks, and Python's data science libraries, command noticeably higher pay than traditional BI tools like SQL, Excel, or Tableau. Those traditional tools function more as expected baseline skills than salary boosters.

5. **Most Optimal Skills to Learn:** Python strikes the best balance of high demand (76 postings) and strong pay ($95,080), while SQL offers unmatched job security through sheer volume (121 postings). Together, these make up the smartest combination of skills for job seekers to prioritize.

### Closing Thoughts
This project sharpened my SQL skills and gave me real insight into the data analyst job market. The findings act as a practical guide for prioritizing what to learn and where to focus my job search. By targeting skills that are both in high demand and well compensated, aspiring data analysts can position themselves more competitively in the market. Ultimately, this project reinforced how important it is to keep learning and stay adaptable as trends in data analytics continue to evolve.


