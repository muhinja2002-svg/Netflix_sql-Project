-- NETFLIX PROJECT --

DROP TABLE IF EXISTS netflix_table;
CREATE TABLE netflix_table (
show_id varchar(6),
type varchar(10),
title varchar(150),
director varchar(208),
casts varchar(1000),
country varchar(150),
date_added varchar(50),
release_year int,
rating varchar(10),
duration varchar(15),
listed_in varchar(150),
description varchar(250)
);

SELECT *
FROM netflix_table
;


-- DATA EXPLORATION --

SELECT 
COUNT(*)
FROM netflix_table
;

SELECT 
DISTINCT type
FROM netflix_table
;

-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows

SELECT
	type,
	COUNT (show_id) as quantity
FROM 
	netflix_table
GROUP BY
	type
;

-- 2. Find the most common rating for movies and TV shows

WITH
	ranked_rating
AS
(
	SELECT 
		type,
		rating,
		COUNT(rating) as quantity,
		RANK() OVER ( PARTITION BY type ORDER BY COUNT(rating) DESC ) AS ranks
	FROM 
		netflix_table
	GROUP BY
		type,
		rating
	ORDER BY
		type,
		quantity
	DESC
)
SELECT * 
FROM
	ranked_rating
WHERE
	ranks = 1
;

-- 3. List all movies released in a specific year (e.g., 2020)

SELECT
	show_id,
	type,
	title,
	release_year
FROM 
	netflix_table
WHERE
	release_year = 2020
AND
	type = 'Movie'
;

--4. Find the top 5 countries with the most content on Netflix

SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country_name,
    COUNT(show_id) AS movie_count
FROM
    netflix_table
WHERE
    country IS NOT NULL
    AND TRIM(country) <> ''
GROUP BY
    country_name
ORDER BY
    movie_count DESC,
    country_name ASC
LIMIT 5
;

-- 5. Identify the longest movie

SELECT
	*
FROM 
	netflix_table
WHERE
	type = 'Movie'
AND
	duration = (SELECT MAX(duration)FROM netflix_table)
;

-- 6. Find content added in the last 5 years

SELECT
    date_added,
    TO_DATE(date_added, 'Month DD, YYYY') AS date_added_converted
FROM
    netflix_table
WHERE
    date_added IS NOT NULL
LIMIT 10;

SELECT *
FROM 
	netflix_table
WHERE
	date_added >= CURRENT_DATE - INTERVAL '5 years'
;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT 
	*
FROM
	netflix_table
WHERE
	director ILIKE '%Rajiv Chilaka%'
;

--8. List all TV shows with more than 5 seasons

SELECT
	*
FROM
	netflix_table
WHERE
	type = 'TV Show'
AND
	SPLIT_PART(duration,' ',1) :: numeric > 5
;

-- 9. Count the number of content items in each genre

SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS movie_type,
    COUNT(show_id) AS total_content
FROM
    netflix_table
WHERE
    listed_in IS NOT NULL
	AND TRIM(listed_in) <> ''
GROUP BY movie_type
ORDER BY total_content DESC
;

-- 10.Find each year and the average numbers of content release in India on netflix. 
--return top 5 year with highest avg content release!

SELECT
    year,
    yearly_content,
    ROUND((yearly_content::numeric / SUM(yearly_content) OVER ()) * 100, 2) AS avg_content_percentage
FROM
    (
        SELECT
            EXTRACT(YEAR FROM date_added) AS year,
            COUNT(show_id) AS yearly_content
        FROM
            netflix_table 
        WHERE
            country ILIKE '%India%'
            AND date_added IS NOT NULL
        GROUP BY 1
    ) AS yearly_counts
ORDER BY
    avg_content_percentage DESC
LIMIT 5;

--

SELECT
    ROUND(COUNT(*)::numeric / COUNT(DISTINCT EXTRACT(YEAR FROM date_added))::numeric, 2) AS average_per_year
FROM
    netflix_table
WHERE
    country ILIKE '%India%'
    AND date_added IS NOT NULL;

--11. List all movies that are documentaries

SELECT 
	*,
	TRIM(UNNEST(STRING_TO_ARRAY(listed_in,' , '))) AS category
FROM netflix_table
WHERE
	listed_in ILIKE '%Documentaries%'
AND
	listed_in IS NOT NULL
AND 
	TRIM(listed_in) <> ''
AND
	type = 'Movie'
;
 
--12. Find all content without a director

SELECT *
FROM netflix_table
WHERE director IS NULL
;

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT
	*
FROM
    netflix_table
WHERE
    type = 'Movie'
AND
	casts ILIKE '%Salman Khan%'
AND 
	release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10
;

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor_name,
    COUNT(show_id) AS movie_count
FROM
    netflix_table
WHERE
    type = 'Movie'
    AND country ILIKE '%India%'
    AND casts IS NOT NULL
    AND TRIM(casts) <> ''
GROUP BY
    actor_name
ORDER BY
    movie_count DESC,
    actor_name ASC
LIMIT 10
;

--15.
--Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

SELECT
    CASE
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(show_id) AS total_content
FROM
    netflix_table
WHERE
    description IS NOT NULL
    AND TRIM(description) <> ''
GROUP BY
    category
ORDER BY
    total_content DESC
;





