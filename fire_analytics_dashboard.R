source("packages.R")

rPackages <- c("tools", "keyring", "odbc", "DBI", "tidyverse", "torch", "purrr", "dplyr", 
               "caret", "readr", "tidytext", "data.table", "randomForest", "rfviz",
               "wordcloud", "RColorBrewer", "wordcloud2", "ggplot2", "viridis", "tm",
               "hrbrthemes", "plotly", "shinydashboard", "lubridate", "zoo", "forecast")

require_packages(rPackages)


source("sql_functions.R")
source("time_series_functions.R")
source("custom_plots.R")
source("datasets.R")
source("parameters.R")
source("ui.R")
source("server.R")
  

### Run Shiny Dashboard ###

shinyApp(ui, server)