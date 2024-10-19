## DATA CLEANING

# Step 1: Remove duplicates if any
# Step 2: Standadizing data: Check for issues with spellings, white spaces etc.
# Step 3: Look at the Null or Blank values, see if you should or shouldn't populate them
# Step 4: Remove irrelevant rows and columns

# Step 1: Remove duplicates if any

-- Selecting all records from the 'layoffs' table for initial inspection
SELECT * 
FROM layoffs;

-- Creating a staging table 'layoffs_staging' that mirrors the structure of the 'layoffs' table.
-- This protects the original data from accidental modifications, deletions, or corruption during the cleaning process.
CREATE TABLE layoffs_staging 
LIKE layoffs;

-- Verifying the structure of the staging table
SELECT * 
FROM layoffs_staging;

-- Inserting data from the 'layoffs' table into the staging table
INSERT INTO layoffs_staging 
SELECT * 
FROM layoffs;

-- Adding a row number to help identify duplicates based on key columns
SELECT *, 
ROW_NUMBER() OVER ( 
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging;

-- Using a Common Table Expression (CTE) to identify duplicate rows
WITH duplicate_cte AS (
  SELECT *, 
  ROW_NUMBER() OVER ( 
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
  FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte 
WHERE row_num > 1;  -- Filtering for rows marked as duplicates

-- Creating another staging table 'layoffs_staging2' with an additional colunm 'row_num
CREATE TABLE `layoffs_staging2` (
  `company` TEXT,
  `location` TEXT,
  `industry` TEXT,
  `total_laid_off` INT DEFAULT NULL,
  `percentage_laid_off` TEXT,
  `date` TEXT,
  `stage` TEXT,
  `country` TEXT,
  `funds_raised_millions` INT DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Verifying the structure of the second staging table
SELECT * 
FROM layoffs_staging2;

-- Inserting data along with row numbers into 'layoffs_staging2'
INSERT INTO layoffs_staging2 
SELECT *, 
ROW_NUMBER() OVER ( 
  PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num 
FROM layoffs_staging;

-- Identifying the duplicate rows in 'layoffs_staging2'
SELECT * 
FROM layoffs_staging2 
WHERE row_num > 1;

-- Deleting the duplicate rows from 'layoffs_staging2'
DELETE 
FROM layoffs_staging2 
WHERE row_num > 1;


# Step 2: Standardizing data: Check for issues with spellings, white spaces, etc.
# Note: Always check each columns individually, where necessary 

-- Checking for leading/trailing white spaces in 'company' names
SELECT company, TRIM(company) 
FROM layoffs_staging2;

-- Removing leading/trailing white spaces from 'company' names
UPDATE layoffs_staging2 
SET company = TRIM(company);

-- Listing distinct 'industry' values for review
SELECT DISTINCT industry 
FROM layoffs_staging2 
ORDER BY 1;

-- Checking for inconsistencies in industry names, focusing on 'Crypto%'
SELECT * 
FROM layoffs_staging2 
WHERE industry LIKE 'Crypto%';

-- Changing all Crypto-like industries into a unified 'Crypto' term
UPDATE layoffs_staging2 
SET industry = 'Crypto' 
WHERE industry LIKE 'Crypto%';

-- Verifying that the 'industry' column is standardized
SELECT DISTINCT industry 
FROM layoffs_staging2;

-- Listing distinct 'location' values for review
SELECT DISTINCT location 
FROM layoffs_staging2 
ORDER BY 1;

-- Listing distinct 'country' values for review
SELECT DISTINCT country 
FROM layoffs_staging2 
ORDER BY 1;

-- Identifying inconsistencies in country names, specifically 'United States%'
SELECT * 
FROM layoffs_staging2 
WHERE country LIKE 'United States%' 
ORDER BY 1;

-- Removing trailing periods from country names
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country) 
FROM layoffs_staging2 
ORDER BY 1;

-- Updating the 'country' column to remove trailing periods
UPDATE layoffs_staging2 
SET country = TRIM(TRAILING '.' FROM country) 
WHERE country LIKE 'United states%';

-- Converting 'date' from string format to DATE format using STR_TO_DATE
SELECT `date`, 
STR_TO_DATE(`date`, '%m/%d/%Y') 
FROM layoffs_staging2;

-- Updating the 'date' column to a valid DATE format
UPDATE layoffs_staging2 
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Verifying the 'date' conversion
SELECT `date` 
FROM layoffs_staging2;

-- Modifying the 'date' column type to DATE
ALTER TABLE layoffs_staging2 
MODIFY COLUMN `date` DATE;


# Step 3: Look at the Null or Blank values, see if you should or shouldn't populate them

-- Reviewing all records in the 'layoffs_staging2' table
SELECT * 
FROM layoffs_staging2;

-- Checking for NULL or blank values in the 'industry' column
SELECT * 
FROM layoffs_staging2 
WHERE industry IS NULL 
OR industry = '';

-- Changing blank 'industry' values by setting them to NULL
UPDATE layoffs_staging2 
SET industry = NULL 
WHERE industry = '';

-- Finding other rows from the same company with valid 'industry' values to populate missing ones
SELECT t1.industry, t2.industry 
FROM layoffs_staging2 t1 
JOIN layoffs_staging2 t2 
  ON t1.company = t2.company 
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

-- Updating the NULL 'industry' values using valid data from matching companies
UPDATE layoffs_staging2 t1 
JOIN layoffs_staging2 t2 
  ON t1.company = t2.company 
SET t1.industry = t2.industry 
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

-- Verifying that no NULL or empty 'industry' values remain
SELECT * 
FROM layoffs_staging2 
WHERE industry IS NULL 
OR industry = '';
-- The company named Bally did not have a matching row so the NULL 'industry' value was not populated

-- Checking if 'company' data starting with 'Bally%' has missing details
SELECT * 
FROM layoffs_staging2 
WHERE company LIKE 'Bally%';


# Step 4: Remove irrelevant rows and columns

-- Reviewing the contents of the 'layoffs_staging2' table
SELECT * 
FROM layoffs_staging2;

-- Identifying rows where both 'total_laid_off' and 'percentage_laid_off' are NULL
SELECT * 
FROM layoffs_staging2 
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

-- Deleting rows where both 'total_laid_off' and 'percentage_laid_off' are NULL
DELETE 
FROM layoffs_staging2 
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

-- Verifying the deletion of irrelevant rows
SELECT * 
FROM layoffs_staging2;

-- Dropping the 'row_num' column, as it's no longer needed after cleaning duplicates
ALTER TABLE layoffs_staging2 
DROP COLUMN row_num;
