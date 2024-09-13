-- EXPLORATORY DATA ANALYSIS (WORLD LAYOFFS)

SELECT * FROM layoffs_clean;

-- TOTAL LAIDOFFS 

SELECT SUM(total_laid_off) FROM layoffs_clean;
						-- 383659 PEOPLE WERE LAID OFF

-- HIGHEST LAIDOFFS IN A DAY 

SELECT MAX(total_laid_off) FROM layoffs_clean; 
                          -- 12000 MAXIMUM LAYOFFS IN A DAY 

SELECT company FROM layoffs_clean
WHERE total_laid_off = 12000;
                          -- GOOGLE HAS THE MAXIMUM NUMBER OF LAYOFFS IN A SINGLE DAY
                          
-- LOOKING COMPANIES WITH 100% LAYOFFS 

SELECT company, total_laid_off, percentage_laid_off FROM layoffs_clean
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
						-- 116 COMPANIES HAVE 100% LAYOFFS 
                        
-- LOOKING AT TOTAL LAYOFFS COMPANY WISE 

SELECT company, SUM(total_laid_off) FROM layoffs_clean
GROUP BY company
ORDER BY 2 DESC; 
			-- AMAZON HAS THE HIGHEST NUMBER OF TOTAL LAYOFFS 18150
            
-- LOOKING AT TOTAL LAYOFFS INDUSTRY WISE 

SELECT industry, SUM(total_laid_off) FROM layoffs_clean
GROUP BY industry
ORDER BY 2 DESC; 
			-- CONSUMER INDUSTRY HAS MOST LAYOFFS 45182
            
-- LOOKIG AT TOTAL LAID OFFS COUNTRY WISE 

SELECT country, SUM(total_laid_off) FROM layoffs_clean
GROUP BY country
ORDER BY 2 DESC; 
			-- UNITED STATES HAS THE MOST LAYOFFS 256559
            
-- LOOKING AT RANGE OF DATES 

SELECT MIN(`date`), MAX(`date`) FROM layoffs_clean;

-- LOOKING YEAR WISE TOTAL LAID OFFS 

SELECT YEAR(`date`), SUM(total_laid_off) FROM layoffs_clean
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;
			-- YEAR 2022 HAS HIGHEST LAIDOFFS 160661
            
-- LOOKING MONTH WISE LAYOFFS 

SELECT SUBSTRING(`date`, 1,7) AS 'Month', SUM(total_laid_off)
FROM layoffs_clean
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`, 1,7)
ORDER BY 1 ASC;

-- MONTH WISE ROLLING TOTAL OF LAYOFFS 

WITH Running_total AS
(
SELECT SUBSTRING(`date`, 1,7) AS 'Month', SUM(total_laid_off) AS total_laid
FROM layoffs_clean
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`, 1,7)
ORDER BY 1 ASC
)
SELECT `Month`, total_laid, SUM(total_laid) OVER(ORDER BY `Month`) AS running_sum
FROM Running_total;

-- RANKING COMPANIES WITH MOST LAYOFFS

WITH Ranking (company, years, laid_offs) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off) FROM layoffs_clean
GROUP BY company, YEAR(`date`)
ORDER BY 1 DESC
), TOP_RANK AS 
(
SELECT * , DENSE_RANK() OVER (PARTITION BY years ORDER BY (laid_offs) DESC) AS Ranks
FROM Ranking
WHERE years IS NOT NULL
ORDER BY Ranks ASC
) 
-- FILTERING FOR TOP 5 RANKS EACH YEAR 

SELECT * FROM TOP_RANK
WHERE Ranks <= 5
ORDER BY 2 ASC;







