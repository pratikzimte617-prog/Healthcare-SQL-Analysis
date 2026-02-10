-- 1. Identifying Average Wait Times by Department
WITH DeptStats AS (
    SELECT 
        Department,
        AVG(Wait_Time_Minutes) AS AvgWait,
        COUNT(Patient_ID) AS TotalPatients
    FROM ER_Visits
    GROUP BY Department
)
SELECT * FROM DeptStats 
WHERE AvgWait > (SELECT AVG(Wait_Time_Minutes) FROM ER_Visits)
ORDER BY AvgWait DESC;

-- 2. Patient Satisfaction vs. Wait Time (Finding the "Breaking Point")
SELECT 
    CASE 
        WHEN Wait_Time_Minutes <= 30 THEN '0-30 Min'
        WHEN Wait_Time_Minutes <= 60 THEN '31-60 Min'
        ELSE '60+ Min' 
    END AS Wait_Bracket,
    AVG(Satisfaction_Score) AS AvgScore
FROM ER_Visits
GROUP BY 1;
