source("packages.R")
source("sql_functions.R")
source("custom_plots.R")

rPackages <- c("tools", "keyring", "odbc", "DBI", "tidyverse", "torch", "purrr", "tm",
               "caret", "readr", "tidytext", "data.table", "randomForest", "rfviz",
               "wordcloud", "RColorBrewer", "wordcloud2", "ggplot2", "viridis", "hrbrthemes", "plotly")
require_packages(rPackages)



### Import Data ###

sql <- "./sql/unit_responses.sql"
server <- "DCP-FDGAPP1PRD"

if (!exists("unit_responses_df")) {
  unit_responses_df <- query_sql(server, sql)
}

incident_types <- sort(unique(unit_responses_df$incident_type))
shifts <- sort(unique(unit_responses_df$shift))
callsigns <- sort(unique(unit_responses_df$callsign))

df <- unit_responses_df %>%
  mutate(dispatch_to_arrival_time_minutes = as.numeric(difftime(unit_responses_df$on_scene_date_time, unit_responses_df$dispatch_date_time, units = "mins"))) %>%
  filter(incident_type_code %in% c("111")) %>%
  filter(callsign %in% c("E1","E2","E17","E11")) %>%
  filter(dispatch_to_arrival_time_minutes >= 0) %>%
  filter(dispatch_to_arrival_time_minutes <= 30)

sample_size <- df %>% group_by(callsign) %>% summarize(num = n())

data <- df

plot <- data %>%
  left_join(sample_size) %>%
  mutate(myaxis = paste0(callsign, "\n", "n=", num)) %>%
  sample_frac(0.5) %>%
  ggplot(aes(x = myaxis, y = dispatch_to_arrival_time_minutes, fill = callsign)) + 
  geom_flat_violin(scale = "count", trim = FALSE, width = 1) + 
  scale_fill_viridis(discrete = TRUE) +
  #stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), geom = "pointrange", position = position_nudge(4.9)) + 
  geom_dotplot(binaxis = "y", dotsize = 0.8, stackdir = "down", binwidth = 0.2, position = position_nudge(-0.025)) + 
  theme_ipsum() +
  theme(
    legend.position = "none"
  ) + 
  ylab("value") +
  xlab("")


ggplotly(plot)

ggplot(df, aes(x = shift, y = dispatch_to_arrival_time_minutes, fill = shift)) +
  geom_boxplot() +
  expand_limits(x = 0, y = 0) +
  scale_fill_brewer(palette="Dark2")

