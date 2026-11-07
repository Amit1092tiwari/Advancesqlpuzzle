CREATE OR ALTER FUNCTION dbo.FnDateDiffPartsTable(@DateTime1 AS DATETIME2, @DateTime2 AS DATETIME2) 
RETURNS TABLE
/*
#####################################################################################################

Scott Peters
https://advancedsqlpuzzles.com

Refactored to Inline Table-Valued Function (ITVF) for optimizer inlining, parallelism,
and zero tempdb allocation overhead.

-- Test function
SELECT * FROM dbo.FnDateDiffPartsTable('20110619 00:00:00.0000001', '20110619 00:00:00.0000000');

SELECT * FROM dbo.FnDateDiffPartsTable('20171231', '20160101 00:00:00.0000000');

SELECT * FROM dbo.FnDateDiffPartsTable('20170518 00:00:00.0000001','20110619 00:00:00.1110000');

#####################################################################################################
*/
AS
RETURN
(
    WITH cte_Normalized AS
    (
        SELECT
            CASE WHEN @DateTime1 <= @DateTime2 THEN @DateTime1 ELSE @DateTime2 END AS DateTime1_Low,
            CASE WHEN @DateTime1 > @DateTime2 THEN @DateTime1 ELSE @DateTime2 END AS DateTime2_High
    ),
    cte_DateDifference AS
    (
        SELECT
            YearDifference - SubtractionYear AS YearDifference,
            (MonthDifference - SubtractionMonth) % 12 AS MonthDifference,
            DATEDIFF(DAY, DATEADD(mm, MonthDifference - SubtractionMonth, DateTime1), [DateTime2]) - SubtractionDay AS DayDifference,
            CAST(NanoSecondDifference / CAST(3600000000000 AS BIGINT) % 60 AS INT) AS HourDifference,
            CAST(NanoSecondDifference / CAST(60000000000 AS BIGINT) % 60 AS INT) AS MinuteDifference,
            CAST(NanoSecondDifference / 1000000000 % 60 AS INT) AS SecondDifference,
            CAST(NanoSecondDifference % 1000000000 AS BIGINT) AS NanoDifference
        FROM cte_Normalized N
        CROSS APPLY
        (VALUES(N.DateTime1_Low, 
                N.DateTime2_High,
                CAST(N.DateTime1_Low AS TIME), 
                CAST(N.DateTime2_High AS TIME),
                DATEDIFF(yy, N.DateTime1_Low, N.DateTime2_High),
                DATEDIFF(mm, N.DateTime1_Low, N.DateTime2_High),
                DATEDIFF(dd, N.DateTime1_Low, N.DateTime2_High)
        )) AS D(DateTime1, [DateTime2], Time1, Time2, YearDifference, MonthDifference, DateDifference)
        CROSS APPLY
        (VALUES(CASE WHEN DATEADD(yy, YearDifference, DateTime1)  > [DateTime2] THEN 1 ELSE 0 END,
                CASE WHEN DATEADD(mm, MonthDifference, DateTime1) > [DateTime2] THEN 1 ELSE 0 END,
                CASE WHEN DATEADD(dd, DateDifference, DateTime1)  > [DateTime2] THEN 1 ELSE 0 END
        )) AS A1(SubtractionYear, SubtractionMonth, SubtractionDay)
        CROSS APPLY
        (VALUES (CAST(86400000000000 AS BIGINT) * SubtractionDay
            +   (CAST(1000000000 AS BIGINT) * DATEDIFF(ss, '00:00', Time2) + DATEPART(ns, Time2))
            -   (CAST(1000000000 AS BIGINT) * DATEDIFF(ss, '00:00', Time1) + DATEPART(ns, Time1))
        )) AS A2(NanoSecondDifference)
    )
    SELECT
        YearDifference,
        MonthDifference,
        DayDifference,
        HourDifference,
        MinuteDifference,
        SecondDifference,
        NanoDifference
    FROM cte_DateDifference
);
GO
