IF SCHEMA_ID('demo') IS NULL
    EXEC('CREATE SCHEMA demo;');
GO
--------------------------------------------------------
--------------------------------------------------------
IF TYPE_ID('demo.CustomersTableType') IS NULL
    CREATE TYPE demo.CustomersTableType AS TABLE(
        [CustomerName] [varchar](100) NOT NULL);
GO
--------------------------------------------------------
--------------------------------------------------------
IF OBJECT_ID('demo.Customers', 'U') IS NULL
CREATE TABLE demo.Customers
(
    InsertDate DATETIME2(3) NOT NULL CONSTRAINT DF_Customers_InsertDate DEFAULT SYSDATETIME(),
    CustomerName VARCHAR(100) NULL
);
GO
--------------------------------------------------------
--------------------------------------------------------
IF OBJECT_ID('demo.CustomersMetadata', 'U') IS NULL
CREATE TABLE demo.CustomersMetadata
(
    InsertDate DATETIME2(3) NOT NULL CONSTRAINT DF_CustomersMetadata_InsertDate DEFAULT SYSDATETIME(),
    CustomerName VARCHAR(100) NULL,
    File_ItemName VARCHAR(260) NULL,
    File_ItemType VARCHAR(50) NULL,
    File_Size BIGINT NULL,
    File_LastModified DATETIME2(3) NULL,
    File_ContentMD5 VARCHAR(32) NULL,
    File_Structure VARCHAR(1000) NULL,
    File_ColumnCount INT NULL,
    File_Exists BIT NULL,
    System_DataFactoryName VARCHAR(128) NULL,
    System_PipelineName VARCHAR(260) NULL,
    System_PipelineRunId VARCHAR(36) NULL,
    System_PipelineTriggerType VARCHAR(50) NULL,
    System_PipelineTriggerId VARCHAR(100) NULL,
    System_PipelineTriggerName VARCHAR(260) NULL,
    System_PipelineTriggerTime VARCHAR(50) NULL,
    System_PipelineGroupID VARCHAR(100) NULL,
    System_PipelineTriggeredByPipelineName VARCHAR(260) NULL,
    System_PipelineTriggerByPipelineRundId VARCHAR(36) NULL
);
GO
--------------------------------------------------------
--------------------------------------------------------
CREATE OR ALTER PROCEDURE demo.SpInsertCustomersTable
    @pCustomersTableType demo.CustomersTableType READONLY,
    @pInsertDate DATETIME2(3) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @pInsertDate IS NULL 
        SET @pInsertDate = SYSDATETIME();

    INSERT INTO demo.Customers (InsertDate, CustomerName)
    SELECT @pInsertDate, CustomerName 
    FROM @pCustomersTableType;
END;
GO
--------------------------------------------------------
--------------------------------------------------------
CREATE OR ALTER PROCEDURE demo.SpInsertCustomersMetadata
    @pCustomersTableType demo.CustomersTableType READONLY,
    @pFile_ItemName VARCHAR(260) = NULL,
    @pFile_ItemType VARCHAR(50) = NULL,
    @pFile_Size BIGINT = NULL,
    @pFile_LastModified DATETIME2(3) = NULL,
    @pFile_ContentMD5 VARCHAR(32) = NULL,
    @pFile_Structure VARCHAR(1000) = NULL,
    @pFile_ColumnCount INT = NULL,
    @pFile_Exists BIT = NULL,
    @pSystem_DataFactoryName VARCHAR(128) = NULL,
    @pSystem_PipelineName VARCHAR(260) = NULL,
    @pSystem_PipelineRunId VARCHAR(36) = NULL,
    @pSystem_PipelineTriggerType VARCHAR(50) = NULL,
    @pSystem_PipelineTriggerId VARCHAR(100) = NULL,
    @pSystem_PipelineTriggerName VARCHAR(260) = NULL,
    @pSystem_PipelineTriggerTime VARCHAR(50) = NULL,
    @pSystem_PipelineGroupID VARCHAR(100) = NULL,
    @pSystem_PipelineTriggeredByPipelineName VARCHAR(260) = NULL,
    @pSystem_PipelineTriggerByPipelineRundId VARCHAR(36) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO demo.CustomersMetadata
    (
        CustomerName,
        File_ItemName,
        File_ItemType,
        File_Size,
        File_LastModified,
        File_ContentMD5,
        File_Structure,
        File_ColumnCount,
        File_Exists,
        System_DataFactoryName,
        System_PipelineName,
        System_PipelineRunId,
        System_PipelineTriggerType,
        System_PipelineTriggerId,
        System_PipelineTriggerName,
        System_PipelineTriggerTime,
        System_PipelineGroupID,
        System_PipelineTriggeredByPipelineName,
        System_PipelineTriggerByPipelineRundId
    )
    SELECT
        CustomerName,
        @pFile_ItemName,
        @pFile_ItemType,
        @pFile_Size,
        @pFile_LastModified,
        @pFile_ContentMD5,
        @pFile_Structure,
        @pFile_ColumnCount,
        @pFile_Exists,
        @pSystem_DataFactoryName,
        @pSystem_PipelineName,
        @pSystem_PipelineRunId,
        @pSystem_PipelineTriggerType,
        @pSystem_PipelineTriggerId,
        @pSystem_PipelineTriggerName,
        @pSystem_PipelineTriggerTime,
        @pSystem_PipelineGroupID,
        @pSystem_PipelineTriggeredByPipelineName,
        @pSystem_PipelineTriggerByPipelineRundId
    FROM @pCustomersTableType;
END;
GO
