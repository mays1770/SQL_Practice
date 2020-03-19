--xuesql.cn

--Lesson 1
SELECT ColumnA, ColumnB FROM mytable; 
--* means all
SELECT * FROM mytable --show all rows in mytable
SELECT title,id,'US' as country FROM movies -- Add a new column called country with 'US'

--Lesson 2
SELECT ColumnA, ColumnB FROM mytable WHERE ConditionA AND/OR ConditionB AND/OR ConditionC ;
--condition examples:
--col_name BETWEEN 1.5 AND 10.5 (inclusive)
--col_name NOT BETWEEN 1.5 AND 10.5 (inclusive)
--col_name IN(2,4,6)
--col_name NOT IN(2,4,6)
-- = is enough

--Lesson 3
--condition examples(strings):
--LIKE (=) / NOT LIKE (!=)
--col_name LIKE "%AT%"   %:any strings   such as BATS,BAT,CAT,AT,ATL
--col_name LIKE "AN_"    _:one character such as AND, ANT
--col_name IN("A","B","C")
--col_name NOT IN("D","E","F")

--Lesson 4
SELECT DISTINCT ColumnA FROM mytable WHERE ConditionA
SELECT ColumnA FROM mytable WHERE ConditionA ORDER BY ColumnA ASC/DESC LIMIT num_limit OFFSET num_offset;
-- LIMIT: how many rows are selected / OFFSET: select starting from where , e.g. OFFSET 5, acutally start from 6
SELECT DISTINCT ColumnA -- only see unique values

--Lesson 5 Review

--Lesson 6/7
--INNER/LEFT/RIGHT/FULL JOIN
SELECT ColumnA, ColumnB FROM TableA INNER/LEFT/RIGHT/FULL JOIN TableB ON TableA.id=TableB.id
WHERE Conditions ORDER BY Columns ASC/DESC
LIMIT num_limit OFFSET num_offset

--Lesson 8
WHERE ColumnA IS NULL
WHERE ColumnA IS NOT NULL

--Lesson 9
SELECT speed/2 AS half_speed FROM mytable WHERE ABS(position)*10>500
AS -- can be used for rename an existed column/table
--MOD:%

--Lesson 10/11
COUNT(*) -- count all rows
COUNT(ColumnA) -- count non-null rows
MIN(CoulmnA)
MAX(CoulmnA)
AVG(ColumnA)
SUM(ColumnA)

SELECT AGG_FUNC(ColumnA) AS XXX FROM mytable WHERE Conditions GROUP BY ColumnB

/*e.g. TO BE REVISED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT Years_employed, COUNT(Years_employed)/COUNT(*)*100 AS Percentage FROM employees 
WHERE Years_employed IN (1,3,5,7)
GROUP BY Years_employed
*/

HAVING Conditions

--Lesson 12
SELECT DISTINCT column, AGG_FUNC(column_or_expression), …
FROM mytable
    JOIN another_table
      ON mytable.column = another_table.column
    WHERE constraint_expression
    GROUP BY column
    HAVING constraint_expression
    ORDER BY column ASC/DESC
    LIMIT count OFFSET COUNT;


--Other Hints
substr(col,0,4) --get the string
select * from (select * from table where col > 1) as tmp where col < 1
 


-- sqlzoo.net

XOR -- exclusive OR, satisfy each criterion but not both

--SELECT from WORLD Tutorial
--Q13:Find the country that has all the vowels and no spaces in its name
SELECT name FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %'

--SELECT from Nobel Tutorial
--Q8:Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT yr,subject,winner FROM nobel
WHERE (subject='Physics' AND yr=1980) OR (subject='Chemistry' AND yr=1984)

--Q11: Non-ASCII characters: Use % instead
--Q12: Escaping single quotes/Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel
WHERE winner='EUGENE O''NEILL'
--Q14:The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
--    Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject,winner

--SELECT from Nobel Tutorial QUIZ
--Q3:Pick the code that shows the amount of years where no Medicine awards were given
SELECT COUNT(DISTINCT yr) FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')

--Q5:Select the code which would show the year when neither a Physics or Chemistry award was given
SELECT yr FROM nobel
 WHERE yr NOT IN(SELECT yr FROM nobel WHERE subject IN ('Chemistry','Physics'))

--Q6:Select the code which shows the years when a Medicine award was given but no Peace or Literature award was
SELECT DISTINCT yr
  FROM nobel
 WHERE subject='Medicine' 
   AND yr NOT IN(SELECT yr FROM nobel 
                  WHERE subject='Literature')
   AND yr NOT IN (SELECT yr FROM nobel
                   WHERE subject='Peace')


--SELECT from Nobel Tutorial
--Q1: List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world WHERE name='Russia')
	  
--Q2: Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
	WHERE continent='Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name='United Kingdom')
	
--Q3: List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.	
SELECT name, continent FROM world
	WHERE continent IN (SELECT continent FROM world WHERE name='Argentina' OR name='Australia')
	ORDER BY name

--Q4: Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population FROM world 
WHERE population > (SELECT population FROM world WHERE name='Canada') 
	AND population < (SELECT population FROM world WHERE name='Poland')
	  
--Q5: Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name='Germany')*100),'%') AS population_percentage
FROM world WHERE continent='Europe' 

--Using ALL in subquery
SELECT name
  FROM world
 WHERE population >= ALL(SELECT population
                           FROM world
                          WHERE population>0)

--Q6: Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world WHERE gdp> ALL(SELECT gdp FROM world WHERE continent='Europe' AND gdp>0)

--Q7: Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
		  
--Q8: List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world x
WHERE name<= ALL(SELECT name FROM world y WHERE x.continent=y.continent)

--Q9: Find the continents where all countries have a population <= 25000000. 
--    Then find the names of the countries associated with these continents. 
--    Show name, continent and population.
	  
SELECT name, continent, population FROM world x
  WHERE 25000000>=ALL (SELECT population FROM world y
                         WHERE x.continent=y.continent
                         AND population>0)
						 				 
--Q10: 
SELECT name, continent FROM world x
WHERE population >ALL(SELECT 3*population FROM world y 
								WHERE x.continent=y.continent 
									AND population>0 
									AND x.population<>y.population)

--SELECT from Nobel Tutorial QUIZ
--Q5: Select the code that would show the countries with a greater GDP than any country in Africa (some countries may have NULL gdp values).
SELECT name FROM bbc
 WHERE gdp > (SELECT MAX(gdp) FROM bbc WHERE region = 'Africa')
 
 
-- SUM and COUNT

--Q2: List all the continents - just once each.
SELECT DISTINCT continent FROM world

--Q8: List the continents that have a total population of at least 100 million.
SELECT continent FROM world GROUP BY continent HAVING SUM(population) >= 100000000
 
-- SUM and COUNT QUIZ
--Q7: Select the statement that shows the name and population density of the country with the largest population
SELECT name, population/area AS density FROM bbc WHERE population = (SELECT MAX(population) FROM bbc)
 
--The JOIN Operation
--Q8: show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id AND goal.teamid!='GER' -- teamid!='GER': prevent listing German players.
    WHERE (team1='GER' OR team2='GER')

--Q11: For every match involving 'POL', show the matchid, date and the number of goals scored.
--SELECT both matchid and mdate, group by should also include both of them
SELECT matchid, mdate, COUNT(player) 
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate

--Q12: For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(player)
FROM game JOIN goal ON game.id=goal.matchid
WHERE teamid='GER'
GROUP BY teamid,matchid,mdate

--Q13:If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. 
--You could SUM this column to get a count of the goals scored by team1. 
--Sort your result by mdate, matchid, team1 and team2.

--Show each match's result
SELECT mdate, 
team1, 
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) AS score1, 
team2, 
SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) AS score2 
FROM game LEFT JOIN goal ON matchid = id 
GROUP BY mdate, matchid, team1, team2

--The JOIN Operation QUIZ
--Q3: Select the code which shows players, their team and the amount of goals they scored against Greece(GRE).
SELECT player, teamid, COUNT(*)
FROM game JOIN goal ON matchid = id
WHERE (team1 = "GRE" OR team2 = "GRE")
AND teamid != 'GRE'
GROUP BY player, teamid

--Q5: Select the code which would show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.
SELECT DISTINCT player, teamid 
FROM game JOIN goal ON matchid = id 
WHERE stadium = 'National Stadium, Warsaw' 
AND (team1 = 'POL' OR team2 = 'POL')
AND teamid != 'POL'

--Q6: Select the code which shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA)
SELECT DISTINCT player, teamid, gtime
FROM game JOIN goal ON matchid = id
WHERE stadium = 'Stadion Miejski (Wroclaw)'
AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))


-- More JOIN operations
--Q12: List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE movieid IN (
  SELECT movieid FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
  WHERE name='Julie Andrews')  AND ord=1
  
--Q13: Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT name FROM 
actor JOIN casting ON (id=actorid and(select count(*) FROM casting WHERE actorid = id and ord=1)>=30)
GROUP BY name

--Q14: List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT DISTINCT title, COUNT(*) FROM 
movie JOIN casting ON movie.id=casting.movieid
JOIN actor ON actor.id=casting.actorid
WHERE yr=1978
GROUP BY title
ORDER BY COUNT(*) DESC, title

--Q15: List all the people who have worked with 'Art Garfunkel'.




https://sqlzoo.net/wiki/More_JOIN_operations


-- Managing Big Data Class

-- HW1
-- UNION : Combine the sql result all together (add more rows)
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;


-- Examples for unique values
-- Write a SELECT statement that returns the name and discount percent of each product that has a unique discount percent. 
-- In other words, don’t include products that have the same discount percent as another product. 
-- Sort the results by the product_name column.



--FUNCTIONS
FORMAT(col_name,format)
-- When using format function to deal with digits, same as ROUND()
CONVERT(expression, data_type)
CAST(expression AS cast_type)



-- 0127 Session 4
--P5
SELECT AVG(grade) FROM course_studnet 
JOIN semester ON course_student.semester_id=semester.semester_id
JOIN courses ON course_student.course_id=courses.course_id
WHERE course_name='biology' AND semester_name='XX'

-- JOIN course_semester ON semester.semester_id=course_semester.semester_id

--P6
CREATE VIEW fact_enrollment AS
	SELECT course_id, person_id .......;

--------------------------------------------------------------Big Data HW-------------------------------------------------------

-- HW1 10
-- Return one row for each product that has the same list price as another product
SELECT p1.product_name, p1.list_price
FROM products p1 JOIN products p2
	ON p1.product_id<>p2.product_id
	AND p1.list_price=p2.list_price
ORDER BY p1.product_name;

























