# Netflix_sql-Project
# 🎬 NETFLIX Data Deep Dive: Uncovering Streaming Secrets with SQL

---

## 🌟 Project Overview

This repository is dedicated to a **comprehensive data exploration and business intelligence project** using raw Netflix content data. The goal was to transform raw streaming metadata into actionable insights by leveraging the power of **SQL**.

Using a provided dataset of Netflix movies and TV shows, we built a robust relational table and executed a series of complex SQL queries designed to answer **15 key business questions**, revealing hidden trends in content catalog, audience reception, and creative talent.

---

## 🛠️ Tech Stack

**Language:** SQL (Solutions utilize advanced features like `RANK()`, `WITH` clauses, and array/string manipulation functions such as `UNNEST(STRING_TO_ARRAY())`, indicating compatibility with flavors like **PostgreSQL** or similar environments).
**Data Source:** `netflix_titles.csv` (Contains over 8,800 entries detailing show IDs, titles, directors, cast, ratings, and release years).

---

## 📈 Key Analysis & Business Questions Solved

The `solutions netflix.sql` file contains the queries and solutions for 15 in-depth business problems, providing immediate insights into the streaming giant's data.

Here are a few examples of the questions tackled:

* **Content Volume Analysis:** How many **Movies vs. TV Shows** are present in the catalog?
* **Audience Preference:** What is the **most common rating** for both Movies and TV Shows?
* **Content Metadata Gaps:** Find all content entries that are missing a **director** entry.
* **Talent Deep Dive:** Identify the **Top 10 actors** who have appeared in the highest number of movies produced specifically in **India**.
* **Content Safety/Keyword Analysis:** Categorize content based on the presence of the keywords `'kill'` and `'violence'` in the description field for safety/genre categorization.
  **Recency Analysis:** Find how many movies a specific actor (e.g., 'Salman Khan') appeared in over the last **10 years**.

---

## ⚙️ Setup and Schema

The project starts with the schema definition used to ingest the raw CSV data into a SQL table.

### Table Schema: `netflix_table`

The following structure was used for the primary table:

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `show_id` | `varchar(6)` | Unique ID for the show/movie |
| `type` | `varchar(10)` | 'Movie' or 'TV Show' |
| `title` | `varchar(150)` | Title of the content |
| `director` | `varchar(208)` | Director(s) of the content |
| `casts` | `varchar(1000)` | List of primary actors |
| `country` | `varchar(150)` | Country/countries of production |
| `date_added` | `varchar(50)` | Date added to Netflix |
| `release_year` | `int` | Original release year |
| `rating` | `varchar(10)` | Content rating (e.g., TV-MA, PG-13) |
| `duration` | `varchar(15)` | Duration (e.g., '90 min' or '2 Seasons') |
| `listed_in` | `varchar(150)` | Genres/Categories |
| `description` | `varchar(250)` | Short content description |

### Running the Project

1.  **Database Setup:** Create a new database in your preferred SQL environment (e.g., PostgreSQL, SQL Server).
2.  **Schema and Data Loading:** Execute the `solutions netflix.sql` file.The file first includes the `DROP TABLE` and `CREATE TABLE` commands to set up the schema, followed by the SQL necessary to answer the business questions[cite: 1].
3.  [cite_start]**Run Queries:** Review and execute the 15 distinct business problem solutions found in the SQL file to retrieve the analytical results[cite: 1].
