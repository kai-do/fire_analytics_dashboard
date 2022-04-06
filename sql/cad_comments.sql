SELECT DISTINCT
	CAD.IncidentNumber							AS 'incident_number'
,	CONVERT(NVARCHAR(MAX), CAD.AllComments)		AS 'cad_comments'

FROM [ReportingDW].[dbo].[MV_Incident] CAD

WHERE CAD.AgencyID = 'CF'
AND CAD.IncidentDate > '2018-01-01 00:00:00.000'