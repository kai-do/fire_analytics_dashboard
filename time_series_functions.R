# function for compiling a list of univariate time series and aggregates from a data frame
df_to_zoos <- function(df, 
                       zoo_name = "", 
                       start_date, 
                       end_date, 
                       aggregate_type = sum, 
                       use_na_approx = TRUE) {
  
  zoo <- list()
  zoo_by_day <- list()
  column_names <- list()
  zoo_by_quarter <- list()
  zoo_by_week <- list()
  zoo_by_month <- list()
  
  i <- 1
  for (i in i:ncol(df)) {
    
    if(use_na_approx) {
      zoo_by_day[[i]] <- na.approx(zoo(df[[i]], seq(from = as.Date(start_date), to = as.Date(end_date), by = 1)))
    } else {
      zoo_by_day[[i]] <- zoo(df[[i]], seq(from = as.Date(start_date), to = as.Date(end_date), by = 1))
    }
    
    dates_for_weeks <- sort(rep(seq(from = as.Date(start_date), to = end_date, by = 7), 7))
    dates_for_weeks <- dates_for_weeks[1:length(index(zoo_by_day[[i]]))]
    
    zoo_by_quarter[[i]] <- aggregate(zoo_by_day[[i]], as.yearqtr, aggregate_type)
    zoo_by_month[[i]] <- aggregate(zoo_by_day[[i]], as.yearmon, aggregate_type)
    zoo_by_week[[i]] <- aggregate(zoo_by_day[[i]], dates_for_weeks, aggregate_type)
    
    column_names[[i]] <- paste0(zoo_name, names(df[i]))
    
    zoo[[i]] <- list(zoo_by_day[[i]], zoo_by_quarter[[i]], zoo_by_month[[i]], zoo_by_week[[i]])
    names(zoo[[i]]) <- c("daily", "quarterly", "monthly", "weekly")
  }
  names(zoo) <- column_names
  
  return(zoo)
}