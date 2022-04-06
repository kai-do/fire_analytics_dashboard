ui <- dashboardPage(
  
  dashboardHeader(title = "ImageTrend Reports"),
  
  dashboardSidebar(
    fluidRow(
      column(12,
             selectInput(
               "dataset_select",
               "Dataset",
               choices = dataset_names,
               selected = NULL,
               multiple = FALSE,
               selectize = TRUE,
               width = NULL,
               size = NULL
             )
      )
    ),
    fluidRow(
      column(12,
             dateRangeInput(
               "date_range",
               "Date Range",
               start = min_date,
               end = max_date,               
               min = min_date,
               max = max_date,
               format = "mm/dd/yy",
               separator = " - "
             )
      )
    ),
    sidebarMenu(
      menuItem("Table", tabName = "table"),
      menuItem("Time Series Plot", tabName = "basic_ts_plot")
      #,
      #menuItem("Unit Response Times", tabName = "unit_reponse_times_plot")
    )
  ),
  
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "table",
              h2("Table"),
              fluidRow(
                column(12,
                       selectInput(
                         "variables",
                         "Select Variables",
                         choices = NULL,
                         selected = NULL,
                         multiple = TRUE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )
                )
              ),
              fluidRow(
                column(12,
                       hr(),
                       DT::dataTableOutput("table"),
                       style = "height: auto; overflow-y: scroll; overflow-x: scroll;"
                )
              )
      ),
      tabItem(tabName = "basic_ts_plot",
              h2("Time Series Plot"),
              fluidRow(
                column(3,
                       selectInput(
                         "time_series_variable",
                         "Select Variable",
                         choices = NULL,
                         selected = NULL,
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )
                ),
                column(3,
                       selectInput(
                         "plot_type",
                         "Time Series Plot Type",
                         choices = c("Standard","Seasonal","Seasonal Polar","Seasonal Subseries"),
                         selected = NULL,
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )
                )
              ),
              fluidRow(
                column(3,
                       selectInput(
                         "time_series_aggregate",
                         "Time Aggregate",
                         choices = NULL,
                         selected = NULL,
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )
                ),
                column(3,
                       selectInput(
                         "time_series_aggregate_type",
                         "Aggregate Function",
                         choices = aggregate_types,
                         selected = NULL,
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )
                )
              ),
              fluidRow(
                column(12,
                       hr(),
                       plotOutput("time_series_plot")
                )
              ),
              fluidRow(
                column(12,
                       hr(),
                       DT::dataTableOutput("aggregate_table"),
                       style = "height: auto; overflow-y: scroll; overflow-x: scroll;"
                )
              )
              #,
              #fluidRow(
              #  column(12,
              #         hr(),
              #         plotOutput("aggregate_plot")
              #  )
              #)
      )
      #,
      #tabItem(tabName = "unit_reponse_times_plot",
      #        h2("Unit Reponse Times"),
      #        fluidRow(
      #          column(3,
      #                 selectInput(
      #                   "time_series_variable",
      #                   "Select Variable",
      #                   choices = NULL,
      #                   selected = NULL,
      #                   multiple = FALSE,
      #                   selectize = TRUE,
      #                   width = NULL,
      #                   size = NULL
      #                 )
      #          ),
      #          column(3,
      #                 selectInput(
      #                   "plot_type",
      #                   "Time Series Plot Type",
      #                   choices = c("Standard","Seasonal","Seasonal Polar","Seasonal Subseries"),
      #                   selected = NULL,
      #                   multiple = FALSE,
      #                   selectize = TRUE,
      #                   width = NULL,
      #                   size = NULL
      #                 )
      #          )
      #        ),
      #        fluidRow(
      #          column(3,
      #                 selectInput(
      #                   "time_series_aggregate",
      #                   "Time Aggregate",
      #                   choices = NULL,
      #                   selected = NULL,
      #                   multiple = FALSE,
      #                   selectize = TRUE,
      #                   width = NULL,
      #                   size = NULL
      #                 )
      #          ),
      #          column(3,
      #                 selectInput(
      #                   "time_series_aggregate_type",
      #                   "Aggregate Function",
      #                   choices = aggregate_types,
      #                   selected = NULL,
      #                   multiple = FALSE,
      #                   selectize = TRUE,
      #                   width = NULL,
      #                   size = NULL
      #                 )
      #          )
      #        ),
      #        fluidRow(
      #          column(12,
      #                 hr(),
      #                 plotOutput("time_series_plot")
      #          )
      #        ),
      #        fluidRow(
      #          column(12,
      #                 hr(),
      #                 DT::dataTableOutput("aggregate_table"),
      #                 style = "height: auto; overflow-y: scroll; overflow-x: scroll;"
      #          )
      #        )
      #        #,
      #        #fluidRow(
      #        #  column(12,
      #        #         hr(),
      #        #         plotOutput("aggregate_plot")
      #        #  )
      #        #)
      #)
    )
  )
)