narrative_df <- update_dataset(df_name = "narrative_df", 
                               force_update = FALSE,
                               csv = "./csv/narrative_data.csv", 
                               server = "DCP-FIRESQL1PRD", 
                               sql = "./sql/narratives.sql")

unit_responses_df <- update_dataset(df_name = "unit_responses_df", 
                                    force_update = FALSE,
                                    csv = "./csv/unit_responses.csv", 
                                    server = "DCP-FDGAPP1PRD", 
                                    sql = "./sql/unit_responses.sql")

climate_df <- update_dataset(df_name = "climate_df", 
                             force_update = FALSE,
                             csv = "./csv/climate_seasonality.csv", 
                             server = "DCP-FDGAPP1DEV", 
                             sql = "./sql/climate_seasonality.sql")

incident_counts_df <- update_dataset(df_name = "incident_counts_df", 
                                     force_update = FALSE,
                                     csv = "./csv/incident_type_seasonality.csv", 
                                     server = "DCP-FIRESQL1PRD", 
                                     sql = "./sql/incident_type_seasonality.sql")
