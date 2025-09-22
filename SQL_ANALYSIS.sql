# 10 Business problems

# Problem 1 - count the number of Movies vs Tv shows

SELECT 
	TYPE , 
	COUNT(*) AS Total_count
FROM netflix 
GROUP BY TYPE ;

# Problem 2 - Find the most common rating for movies and TV shows

SELECT
    type ,
    rating
FROM
(
SELECT
    type , 
    rating ,
    COUNT(*) ,
    RANK() OVER( PARTITION BY type ORDER BY COUNT(*) DESC ) AS Ranking
FROM netflix
GROUP BY 1 , 2 
) AS t1
WHERE 
Ranking = 1;

# Problem 3 - List All Movies Released in a Specific Year (e.g., 2020)

SELECT * 
FROM netflix
WHERE 
    type = 'Movie'
    AND
    release_year = 2020;
    
# Problem 4 - Find the Top 5 Countries with the Most Content on Netflix

SELECT 
    TRIM(j.country) AS country,
    COUNT(*) AS frequency
FROM netflix n
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(n.country, ',', '","'), '"]'),
    "$[*]" COLUMNS (country VARCHAR(255) PATH "$")
) AS j
WHERE n.country IS NOT NULL
  AND n.country <> ''
GROUP BY j.country
ORDER BY frequency DESC
LIMIT 5;

# Problem 5 - Identify the Longest Movie

SELECT 
    *
FROM netflix
WHERE type = 'Movie'
  AND duration = (SELECT MAX(duration) FROM netflix);
  
# Problem 6 - Find Content Added in the Last 5 Years

SELECT *
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR;



# Problem 7 - List all TV shows with more than 5 seasons

SELECT 
    title , 
    duration 
FROM netflix 
WHERE type = 'TV Show'
AND CAST(SUBSTRING_INDEX(duration , ' ' , 1) AS UNSIGNED ) > 5 ;

# Problem 8 - Count the number of content items in each genre

SELECT 
    TRIM(j.listed_in) AS genre,
    COUNT(*) AS frequency
FROM netflix n
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(n.listed_in, ',', '","'), '"]'),
    "$[*]" COLUMNS(listed_in VARCHAR(255) PATH "$")
) AS j
GROUP BY j.listed_in;

# Problem 9 - List all movies that are documentaries

SELECT *
FROM netflix
WHERE listed_in LIKE '%documentaries%' COLLATE utf8_general_ci;

# Problem 10 - Find all content without a director 

SELECT *
FROM netflix 
WHERE director != '';

