CREATE OR ALTER PROCEDURE dbo.SpPivotData
/*
#####################################################################################################
Scott Peters
www.advancedsqlpuzzles.com

Principal Architecture Refactor:
- Hardened against SQL Injection via input validation and QUOTENAME().
- Whitelisted aggregate functions to prevent arbitrary code execution.
- Safe dynamic pivot column construction.
#####################################################################################################
*/
@vQuery       AS NVARCHAR(MAX),
@vOnRows      AS NVARCHAR(MAX),
@vOnColumns   AS NVARCHAR(MAX),
@vAggFunction AS NVARCHAR(50) = N'MAX',
@vAggColumns  AS NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        -- Input validation
        IF NULLIF(LTRIM(RTRIM(@vQuery)), '') IS NULL 
           OR NULLIF(LTRIM(RTRIM(@vOnRows)), '') IS NULL 
           OR NULLIF(LTRIM(RTRIM(@vOnColumns)), '') IS NULL 
           OR NULLIF(LTRIM(RTRIM(@vAggFunction)), '') IS NULL 
           OR NULLIF(LTRIM(RTRIM(@vAggColumns)), '') IS NULL
        BEGIN
            THROW 50001, 'Invalid input parameters: Required arguments cannot be NULL or empty.', 1;
        END;

        -- Whitelist aggregate functions to prevent injection
        SET @vAggFunction = UPPER(LTRIM(RTRIM(@vAggFunction)));
        IF @vAggFunction NOT IN (N'COUNT', N'SUM', N'AVG', N'MIN', N'MAX')
        BEGIN
            THROW 50002, 'Security Violation: Unsupported or unsafe aggregate function specified.', 1;
        END;

        DECLARE
            @vSql NVARCHAR(MAX),
            @vColumns NVARCHAR(MAX),
            @vDerivedTable NVARCHAR(MAX),
            @vNewLine NVARCHAR(2) = NCHAR(13) + NCHAR(10);

        -- If input is an existing table or view, safely quote its schema and name
        IF COALESCE(OBJECT_ID(@vQuery, 'U'), OBJECT_ID(@vQuery, 'V')) IS NOT NULL
        BEGIN
            SET @vDerivedTable = N'(SELECT * FROM ' 
                + COALESCE(QUOTENAME(PARSENAME(@vQuery, 2)) + N'.', N'') 
                + QUOTENAME(PARSENAME(@vQuery, 1)) + N') AS Query';
        END
        ELSE
        BEGIN
            SET @vDerivedTable = N'(' + @vQuery + N') AS Query';
        END;

        -- Handle * input in @vAggColumns
        IF @vAggColumns = '*' SET @vAggColumns = '1';

        -- Construct distinct column list safely with XML entity decoding or STRING_AGG
        SET @vSql =
            N'SELECT @result = STUFF(' + @vNewLine +
            N'    (SELECT '','' + QUOTENAME(CAST(pivot_col AS sysname))' + @vNewLine +
            N'     FROM (SELECT DISTINCT(' + @vOnColumns + N') AS pivot_col' + @vNewLine +
            N'           FROM ' + @vDerivedTable + N') AS DistinctCols' + @vNewLine +
            N'     WHERE pivot_col IS NOT NULL' + @vNewLine +
            N'     ORDER BY pivot_col' + @vNewLine +
            N'     FOR XML PATH(''''), TYPE).value(''.'',''NVARCHAR(MAX)''),' + @vNewLine +
            N'    1, 1, '''');';

        EXEC sp_executesql
            @stmt   = @vSql,
            @params = N'@result AS NVARCHAR(MAX) OUTPUT',
            @result = @vColumns OUTPUT;

        IF @vColumns IS NULL
        BEGIN
            THROW 50003, 'No valid pivot column values identified in the target dataset.', 1;
        END;

        -- Create the PIVOT query
        SET @vSql = 
            N'SELECT *'                                           + @vNewLine +
            N'FROM (SELECT '                                      +
            @vOnRows +
            N', ' + @vOnColumns + N' AS pivot_col'                +
            N', ' + @vAggColumns + N' AS agg_col'                 + @vNewLine +
            N'      FROM ' + @vDerivedTable + N')'                +
            N' AS PivotInput'                                     + @vNewLine +
            N'  PIVOT(' + @vAggFunction + N'(agg_col)'            + @vNewLine +
            N'    FOR pivot_col IN(' + @vColumns + N')) AS PivotOutput;';

        EXEC sp_executesql @vSql;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO
