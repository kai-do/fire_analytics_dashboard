SELECT
	Date
,	Incident_Type_Code
,	Incident_Type
,	Incident_Type_Category_Code
,	Incident_Type_Category
,	COUNT(Fire_Internal_ID) AS 'Count'
FROM
(
	SELECT
		FF.Incident_ID_Internal								AS 'Fire_Internal_ID'
	,	FDB.Basic_Incident_Number							AS 'Incident_Number'
	,	FDB.Basic_Incident_Date_Time						AS 'Incident_Date_Time'
	,	CONVERT(DATE, Basic_Incident_Date_Time)				AS 'Date'
	,	CONVERT(TIME, Basic_Incident_Date_Time)				AS 'Incident_Time'
	,	Basic_Incident_Type_Code							AS 'Incident_Type_Code'
	,	Basic_Incident_Type_Code_And_Description			AS 'Incident_Type'
	,	CONVERT(INT,LEFT(Basic_Incident_Type_Category, 1))	AS 'Incident_Type_Category_Code'
	,	Basic_Incident_Type_Category						AS 'Incident_Type_Category'
	,	Basic_Incident_Latitude								AS 'Latitude'
	,	Basic_Incident_Longitude							AS 'Longitude'

	FROM [CF_DataMart].[DwFire].[Fact_Fire] FF
		INNER JOIN [CF_DataMart].[DwFire].[Dim_Basic] FDB ON FF.Dim_Basic_FK = FDB.Dim_Basic_PK

	WHERE Basic_Incident_Status IN ('Finalized', 'Ready for QA') AND Basic_Incident_Validity_Score = '100' AND YEAR(Basic_Incident_Date_Time) >= 2018
) A


GROUP BY
	Date
,	Incident_Type_Code
,	Incident_Type
,	Incident_Type_Category_Code
,	Incident_Type_Category

ORDER BY Date ASC