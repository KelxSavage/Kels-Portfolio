--- checking the distinct values fof some columns:

SELECT DISTINCT sentiment
FROM calls_;
SELECT DISTINCT reason
FROM calls_;
SELECT DISTINCT channel
FROM calls_;
SELECT DISTINCT response_time
FROM calls_;
SELECT DISTINCT call_center
FROM calls_;

--- the cnt & pct from ttl of each of the distinct values we got:

SELECT sentiment, COUNT(*) as count_, 
		ROUND(COUNT(*) *100 / 
		(SELECT COUNT(*)
			FROM calls_), 1) AS pct
FROM calls_
GROUP BY sentiment
ORDER BY pct DESC;


SELECT reason, COUNT(*) as count_, 
ROUND(COUNT(*) *100 / 
	(SELECT COUNT(*) 
	FROM calls_),1) AS pct
FROM calls_
GROUP BY reason
ORDER BY pct DESC;

SELECT channel, COUNT(*) as count_, 
ROUND(COUNT(*) *100 / 
	(SELECT COUNT(*) 
	FROM calls_),1) AS pct
FROM calls_
GROUP BY channel
ORDER BY pct DESC;

SELECT response_time, COUNT(*) as count_, 
ROUND(COUNT(*) *100 / 
	(SELECT COUNT(*) 
	FROM calls_),1) AS pct
FROM calls_
GROUP BY response_time
ORDER BY pct DESC;

SELECT call_center, COUNT(*) as count_, 
ROUND(COUNT(*) *100 / 
	(SELECT COUNT(*) 
	FROM calls_),1) AS pct
FROM calls_
GROUP BY call_center
ORDER BY pct DESC;

SELECT state, COUNT(*) as count_, 
ROUND(COUNT(*) *100 / 
	(SELECT COUNT(*) 
	FROM calls_), 1) AS pct
FROM calls_
GROUP BY state
ORDER BY pct DESC;

--- Day with most calls, using 'DATENAME' function 

SELECT DATENAME(weekday, call_timestamp) as Day_of_call, COUNT(*) as num_of_calls
FROM calls_
GROUP BY DATENAME(weekday, call_timestamp)
ORDER BY num_of_calls DESC;

--- Aggregations :

SELECT MIN(csat_score) as min_score, MAX(csat_score) as max_score, 
ROUND(AVG(csat_score), 1) as avg_score
FROM calls_
WHERE csat_score !=0;

SELECT MIN(call_timestamp) as earliest_date, MAX(call_timestamp) as most_recent
FROM calls_;

SELECT MIN(call_duration_in_minutes) as min_call_duration, MAX(call_duration_in_minutes) as max_call_duration,  AVG(call_duration_in_minutes) as avg_call_duration
FROM calls_;

SELECT call_center, response_time, COUNT(*) as count_
FROM calls_
GROUP BY call_center, response_time
ORDER BY call_center, count_ DESC;

SELECT call_center, AVG(call_duration_in_minutes) as avg_call_duration
FROM calls_
GROUP BY call_center
ORDER BY avg_call_duration DESC;

SELECT channel, AVG(call_duration_in_minutes) as avg_call_duration
FROM calls_
GROUP BY channel
ORDER BY avg_call_duration DESC;

SELECT state, COUNT(*) as state_count
FROM calls_
GROUP BY state
ORDER BY state_count DESC;

SELECT state, reason, COUNT(*) as count_
FROM calls_
GROUP BY state, reason
ORDER BY state, reason, count_ DESC;

SELECT state, sentiment, COUNT(*) as count_
FROM calls_
GROUP BY state, sentiment
ORDER BY state, count_ DESC;

SELECT state, ROUND(AVG(csat_score), 1) as avg_score
FROM calls_
WHERE csat_score !=0
GROUP BY state
ORDER BY avg_score DESC;

SELECT sentiment, AVG(call_duration_in_minutes) as avg_call_dur
FROM calls_
GROUP BY sentiment
ORDER BY avg_call_dur DESC;


SELECT call_timestamp, MAX(call_duration_in_minutes) as max_call_dur
FROM calls_
GROUP BY call_timestamp
ORDER BY MAX(call_duration_in_minutes) DESC;
