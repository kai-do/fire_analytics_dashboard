SELECT DISTINCT
	[IncidentNumber]								AS 'incident_number'
,	[CallSign]										AS 'callsign'
,	[Shift]											AS 'shift'
,	[IncidentDate]									AS 'Date'
,	[DispatchTime]									AS 'dispatch_date_time'
,	[EnrouteTime]									AS 'en_route_date_time'
,	[OnSceneTime]									AS 'on_scene_date_time'
,	[ClearTime]										AS 'clear_date_time'
,	[RowNum]										AS 'unit_arrival_order'
,	FDB.Basic_Incident_Type_Code_And_Description	AS 'incident_type'
,	FDB.Basic_Incident_Type_Code					AS 'incident_type_code'

FROM
	[IncidentReportingDataMart].[dbo].[CADUnitResponseTimes] CAD
		INNER JOIN [DCP-FIRESQL1PRD].[CF_DataMart].[DwFire].[Dim_Basic] FDB ON FDB.Basic_Incident_Number = CAD.IncidentNumber