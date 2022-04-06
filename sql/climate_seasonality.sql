SELECT
	[Date]
,	[Sunrise]
,	[Sunset]
,	[Min_AltimeterSetting]
,	[Avg_AltimeterSetting]
,	[Max_AltimeterSetting]
,	[Min_DewPointTemperature]
,	[Avg_DewPointTemperature]
,	[Max_DewPointTemperature]
,	[Min_DryBulbTemperature]
,	[Avg_DryBulbTemperature]
,	[Max_DryBulbTemperature]
,	[Min_Precipitation]
,	[Avg_Precipitation]
,	[Max_Precipitation]
,	[Min_PressureChange]
,	[Avg_PressureChange]
,	[Max_PressureChange]
,	[Min_PressureTendency]
,	[Avg_PressureTendency]
,	[Max_PressureTendency]
,	[Min_RelativeHumidity]
,	[Avg_RelativeHumidity]
,	[Max_RelativeHumidity]
,	[Min_SeaLevelPressure]
,	[Avg_SeaLevelPressure]
,	[Max_SeaLevelPressure]
,	[Min_StationPressure]
,	[Avg_StationPressure]
,	[Max_StationPressure]
,	[Min_Visibility]
,	[Avg_Visibility]
,	[Max_Visibility]
,	[Min_WetBulbTemperature]
,	[Avg_WetBulbTemperature]
,	[Max_WetBulbTemperature]
,	[Min_WindGustSpeed]
,	[Avg_WindGustSpeed]
,	[Max_WindGustSpeed]
,	[Min_WindSpeed]
,	[Avg_WindSpeed]
,	[Max_WindSpeed]

FROM [CountyStatistics].[dbo].[ClimateDailyAverages]

--WHERE [Date] BETWEEN ? AND ?

ORDER BY
	Date