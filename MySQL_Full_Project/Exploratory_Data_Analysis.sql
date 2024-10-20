## EXPLORATORY DATA ANALYSIS

-- Returns the entire dataset after data cleaning
SELECT *
FROM layoffs_staging2;

-- Returns the maximum values for 'total_laid_off' and 'percentage_laid_off'
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Returns all rows where the percentage of laid-off employees is 100% and order them by 'total_laid_off' in descending order
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Returns all rows where 100% of employees were laid off, ordered by the amount of funds raised by the company (in millions)
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Returns sum of the total layoffs per company and order by the total layoffs in descending order
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Returns the earliest and latest date of layoffs in the dataset
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Returns sum of the total layoffs per industry and order by the total layoffs in descending order
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- View the entire dataset (repeated query)
SELECT *
FROM layoffs_staging2;

-- Returns sum of the total layoffs per country and order by the total layoffs in descending order
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Returns sum of the total layoffs per date and order by the total layoffs in descending order
SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 2 DESC;

-- Returns sum of the total layoffs per date and order by the date in descending order
SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

-- Returns sum of the total layoffs per year and order by the year in descending order
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Returns sum of the total layoffs by company stage and order by the stage name in ascending order
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC;

-- Returns sum of the total layoffs by company stage and order by the total layoffs in descending order
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Returns the average percentage of employees laid off per company, ordered by the average percentage in descending order
SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Extract the month from the 'date' field for each row
SELECT SUBSTRING(`date`, 6, 2) AS `Month`
FROM layoffs_staging2;

-- Returns sum of the total layoffs per month (derived from the 'date' field) and order by month in ascending order
SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC;

-- Calculate the cumulative (rolling) total layoffs per month, ordered by month
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC
)
SELECT `Month`, total_off, SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
FROM Rolling_Total;

-- Returns sum of the total layoffs per company and order by the total layoffs in descending order
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Returns sum of total layoffs by company and year, ordered alphabetically by company name
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

-- Returns sum of total layoffs by company and year, ordered by total layoffs in descending order
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- Common table expression (CTE) to calculate total layoffs per company and year
WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *
FROM Company_Year;

-- CTE with a dense rank of companies per year based on total layoffs, ordered by ranking
WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

-- CTE to rank companies by total layoffs per year, and filter to show only the top 5 companies for each year
WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;
