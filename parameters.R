start_date <- "2018-02-01"
end_date <- "2021-12-31"

incident_types <- colnames(incident_counts_df[-1])
climate_types <- colnames(climate_df[4:ncol(climate_df)])

min_date <- max(c(min(incident_counts_df$Date), min(climate_df$Date)))
max_date <- min(c(max(incident_counts_df$Date), max(climate_df$Date)))

zoo_label <- "label"

dataset_names <- c("incident_counts_df","climate_df", "unit_responses_df")
aggregate_types <- c("mean","sum")

incident_types <- sort(unique(unit_responses_df$incident_type))
shifts <- sort(unique(unit_responses_df$shift))
callsigns <- sort(unique(unit_responses_df$callsign))