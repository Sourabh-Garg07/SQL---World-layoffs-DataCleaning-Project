-- DATA CLEANING AND EXPLORATION PROJECT (WORLD LAYOFFS)

-- A LOOK AT DATASET

SELECT * FROM 
layoffs;
	 -- 2361 ROWS RETURNED 
      
-- # DATA CLEANING

-- LOOKING ALL THE COLUMNS 
               -- 1. Company                  2. Location                       3. Industry 
               -- 4. Total_laid_off           5. Percentage_laid_off            6. date
               -- 7. Stage                    8. Country                        9. Funds_raised_millions

-- CREATING COPY OF DATASET

CREATE TABLE layoffs_cleaned LIKE layoffs;
INSERT layoffs_cleaned
SELECT * FROM layoffs;

SELECT * FROM layoffs_cleaned;

-- DATA CLEANING 

-- 1. CHECKING DUPLICATES 

SELECT *, ROW_NUMBER()
OVER(PARTITION BY  company, industry, location, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_cleaned;

WITH duplicate_CTE AS
(
SELECT *, ROW_NUMBER()
OVER(PARTITION BY  company, industry, location, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_cleaned
)
   
SELECT * FROM duplicate_CTE
WHERE row_num > 1;
                  -- DATASET HAS 5 DUPLICATE VALUES 

-- CREATING NEW TABLE TO DROP DUPLICATES 

CREATE TABLE `layoffs_clean` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_clean;

INSERT INTO layoffs_clean
SELECT *, ROW_NUMBER()
OVER(PARTITION BY  company, industry, location, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_cleaned;

DELETE FROM layoffs_clean
WHERE row_num > 1;

SELECT * FROM layoffs_clean;
                         -- DUPLICATED DATA HAS BEEN DROPPED 
                         
-- STANDARDIZING DATASET
-- 1. Looking at company column 

SELECT company, TRIM(company)
FROM layoffs_clean;

UPDATE layoffs_clean
SET company = TRIM(company);

SELECT DISTINCT(company)
FROM layoffs_clean
ORDER BY 1; 
           -- Company column has been standardized 
           
-- LOOKING AT INDUSTRY COLUMN

SELECT DISTINCT(industry) FROM layoffs_clean
ORDER BY 1;
           -- 34 Distinct industries 
           
-- STANDARDZING INDUSTRY COLUMN 

SELECT * FROM layoffs_clean
WHERE industry LIKE "%Crypto%";

UPDATE layoffs_clean
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
				-- INDUSTRY COLUMN HAS BEEN UPDATED 
                
-- LOOKING AT LOCATION COLUMN

SELECT DISTINCT(location) FROM layoffs_clean
ORDER BY 1; 
		-- Location column do not have any problem
        
-- LOOKING AT COUNTRY COLUMN 

SELECT DISTINCT(country) FROM layoffs_clean
ORDER BY 1;

-- STANDARDIZING COUNTRY COLUMN

UPDATE layoffs_clean
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';
                    -- Country column has been updated 
                    
-- CHANGING DATE FORMAT FROM TEXT TO DATETIME 

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_clean;

UPDATE layoffs_clean
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
                         
 -- CHANGING FORMAT TO DATETIME
 
 ALTER TABLE layoffs_clean
 MODIFY COLUMN `date` DATE;
				-- Date Column has been updated 
                
-- DEALING WITH NULLS 

SELECT * FROM layoffs_clean
WHERE industry IS NULL
OR industry = '';
                -- 4 EMPTY VALUES 
                
-- IDENTIFYING INDUSTRY TYPE THROUGH COMPANY NAME 

UPDATE layoffs_clean
SET industry = NULL
WHERE industry = '';

SELECT * 
FROM layoffs_clean AS T1
JOIN layoffs_clean AS T2
	ON T1.company = T2.company
WHERE (T1.industry IS NULL)
AND T2.industry IS NOT NULL;

-- REPLACING NULLS WITH INDUSTRY VALUES 

UPDATE layoffs_clean AS T1
JOIN layoffs_clean AS T2
	ON T1.company = T2.company
SET T1.industry = T2.industry
WHERE T1.industry IS NULL 
AND T2.industry IS NOT NULL;
                      -- INDUSTRY COLUMN HAS BEEN UPDATED 
                      
-- LOOKING NULLS FOR BOTH TOTAL LAID OFF AND PERCENTAGE LAID OFF 

SELECT * FROM layoffs_clean
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- DELETING ROWS WHERE BOTH TOTAL LAID OFF AND PERCENTAGE LAID OFF IS NULL 

DELETE FROM layoffs_clean
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
                         -- RECORDS HAVE BEEN DELETED 
                         
-- DROPPING UNNECESSARY COLUMNS 

ALTER TABLE layoffs_clean
DROP COLUMN row_num;

-- A LOOK AT CLEANED DATASET

SELECT * FROM layoffs_clean;


                         




                  
                  
                  











