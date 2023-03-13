--- Checking the dimensions and size. w/ rows & column checks

SELECT COUNT(*) as rows_num 
FROM ins_pol;

SELECT COUNT(*) as col_num
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ins_pol';

--- checking the distinct values of some columns

SELECT DISTINCT marital_status
FROM ins_pol

SELECT DISTINCT car_use
FROM ins_pol

SELECT DISTINCT gender
FROM ins_pol

SELECT DISTINCT kids_driving
FROM ins_pol

SELECT DISTINCT parent
FROM ins_pol

SELECT DISTINCT education
FROM ins_pol

SELECT DISTINCT car_make
FROM ins_pol

SELECT DISTINCT car_model
FROM ins_pol

SELECT DISTINCT car_color
FROM ins_pol

SELECT DISTINCT car_year
FROM ins_pol

SELECT DISTINCT claim_freq
FROM ins_pol

SELECT DISTINCT coverage_zone
FROM ins_pol

SELECT DISTINCT claim_amt
FROM ins_pol

SELECT DISTINCT household_income
FROM ins_pol

---The cnt & pct from ttl of each of the distinct valz we got:

SELECT marital_status, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY marital_status
ORDER BY pct DESC;

SELECT car_use, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY car_use
ORDER BY pct DESC;

SELECT gender, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY gender
ORDER BY pct DESC;

SELECT kids_driving, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY kids_driving
ORDER BY pct DESC;

SELECT parent, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY parent
ORDER BY pct DESC;

SELECT education, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY education
ORDER BY pct DESC;

SELECT car_make, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY car_make
ORDER BY pct DESC;

SELECT car_color, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct 
FROM ins_pol
GROUP BY car_color
ORDER BY cnt DESC;


SELECT car_year, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY car_year
ORDER BY pct DESC;

SELECT claim_freq, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY claim_freq
ORDER BY pct DESC;

SELECT coverage_zone, COUNT(*) as cnt, ROUND((COUNT(*) * 100)/ 
	(SELECT COUNT(*)
	FROM ins_pol), 1) as pct
FROM ins_pol
GROUP BY coverage_zone
ORDER BY pct DESC;

---Let's find the ages with most frequent coverage claims

SELECT birthdate, COUNT(*) as cnt, DATEDIFF(YEAR, birthdate, GETDATE()) - 
	CASE 
	WHEN MONTH(birthdate) * 100 + DAY(birthdate) > MONTH(GETDATE()) * 100 + DAY(GETDATE()) 
	THEN 1 
	ELSE 0 
	END AS age
FROM ins_pol
GROUP BY birthdate
ORDER BY age DESC;

---Aggregations:

SELECT MIN(kids_driving) as min_kidsdrv, 
	MAX(kids_driving) as max_kidsdrv,
	ROUND(AVG(kids_driving), 1) as avg_score
FROM ins_pol

SELECT MIN(claim_freq) as min_cf, 
	MAX(claim_freq) as max_cf,
	ROUND(AVG(claim_freq), 1) as avg_cf
FROM ins_pol;

SELECT 
	MIN(claim_amt) as min_ca,
	MAX(claim_amt) as max_ca,
	ROUND(AVG(claim_amt), 1) as avg_ca
FROM ins_pol
WHERE claim_amt >1 ---Lets say anything less than '1' is not significant;

SELECT 
	MIN(household_income) as min_hi,
	MAX(household_income) as max_hi,
	ROUND(AVG(household_income), 1)
FROM ins_pol;

SELECT kids_driving, COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY kids_driving
ORDER BY cnt_cf DESC;

SELECT marital_status, COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY marital_status
ORDER BY cnt_cf DESC

SELECT kids_driving, marital_status, COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY marital_status, kids_driving
ORDER BY kids_driving, cnt_cf DESC

SELECT kids_driving, car_make, COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY car_make, kids_driving
ORDER BY kids_driving, cnt_cf DESC

SELECT
	gender,
	COUNT(claim_freq) as cnt_cf, 
	COUNT(*) as cnt, 
	DATEDIFF(YEAR, birthdate, GETDATE()) - 
	CASE 
	WHEN MONTH(birthdate) * 100 + DAY(birthdate) > MONTH(GETDATE()) * 100 + DAY(GETDATE()) 
	THEN 1 
	ELSE 0 
	END AS age
FROM ins_pol
WHERE gender = 'Male'
GROUP BY gender, birthdate
ORDER BY age DESC;

SELECT
	gender,
	COUNT(claim_freq) as cnt_cf, 
	COUNT(*) as cnt, 
	DATEDIFF(YEAR, birthdate, GETDATE()) - 
	CASE 
	WHEN MONTH(birthdate) * 100 + DAY(birthdate) > MONTH(GETDATE()) * 100 + DAY(GETDATE()) 
	THEN 1 
	ELSE 0 
	END AS age
FROM ins_pol
WHERE gender = 'Female'
GROUP BY gender, birthdate
ORDER BY age DESC;

SELECT coverage_zone, COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY coverage_zone
ORDER BY cnt_cf DESC;

SELECT education, COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY education
ORDER BY cnt_cf DESC;

SELECT 
	AVG(car_year) OVER(PARTITION BY car_year)as avg_yr, 
	COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY car_year
ORDER BY cnt_cf DESC;

SELECT 
	AVG(household_income) OVER(PARTITION BY household_income)as avg_hi, 
	COUNT(claim_freq) as cnt_cf
FROM ins_pol
GROUP BY household_income
ORDER BY cnt_cf DESC;



	



