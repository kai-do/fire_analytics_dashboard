server <- function(input, output, session) {
  
  dataset_reactive <- reactive({
    if (input$dataset_select == "incident_counts_df") {
      df <- incident_counts_df
    } else if (input$dataset_select == "climate_df") {
      df <- climate_df
    }
  })
  
  filtered_dataset_reactive <- reactive({
    df <- dataset_reactive() %>%
      filter(Date >= input$date_range[1] & Date <= input$date_range[2]) %>%
      select(input$variables)
  })
  
  observeEvent(dataset_reactive(), {
    updateSelectInput(session = session, inputId = "variables", choices = colnames(dataset_reactive()))
    updateSelectInput(session = session, inputId = "time_series_variable", choices = colnames(dataset_reactive()))
  })
  
  zoo_reactive <- reactive({
    df <- dataset_reactive() %>%
      filter(Date >= input$date_range[1] & Date <= input$date_range[2]) %>%
      select(input$time_series_variable)
    
    na.approx(zoo(df, seq(from = as.Date(input$date_range[1]), to = as.Date(input$date_range[2]), by = 1)))
  })
  
  zoo_aggregate_reactive <- reactive({
    if (input$time_series_aggregate == "Daily") {
      zoo_reactive()
    } else if (input$time_series_aggregate == "Weekly") {
      dates_for_weeks <- sort(rep(seq(from = as.Date(input$date_range[1]), to = input$date_range[2], by = 7), 7))
      dates_for_weeks <- dates_for_weeks[1:length(index(zoo_reactive()))]
      aggregate(zoo_reactive(), dates_for_weeks, input$time_series_aggregate_type)
    } else if (input$time_series_aggregate == "Monthly") {
      aggregate(zoo_reactive(), as.yearmon, input$time_series_aggregate_type)
    } else if (input$time_series_aggregate == "Quarterly") {
      aggregate(zoo_reactive(), as.yearqtr, input$time_series_aggregate_type)
    }
  })
  
  aggregate_reactive <- reactive({
    df <- dataset_reactive()
    var <- input$time_series_variable
    df %>%
      filter(Date >= input$date_range[1] & Date <= input$date_range[2]) %>%
      mutate(Month = month(df$Date)) %>%
      group_by(Month) %>%
      select(Month, input$time_series_variable) %>%
      summarize(mean = mean(input$time_series_variable), 
                sd = sd(input$time_series_variable), 
                min = min(input$time_series_variable), 
                max = max(input$time_series_variable)
                #,
                #sum = sum(var)
      )
  })
  
  observe({
    tsa <- input$plot_type
    if(tsa == "Standard") {
      updateSelectInput(session = session, inputId = "time_series_aggregate", choices = c("Daily","Weekly","Monthly","Quarterly"))
    } else {
      updateSelectInput(session = session, inputId = "time_series_aggregate", choices = c("Monthly","Quarterly"))
    }
  })
  
  output$zoo_table <- DT::renderDataTable({
    req(input$date_range)
    req(input$dataset_select)
    req(input$time_series_variable)
    as.data.frame(zoo_reactive())
  })  
  
  output$table <- DT::renderDataTable({
    req(input$date_range)
    req(input$dataset_select)
    req(input$variables)
    as.data.frame(filtered_dataset_reactive())
  })  
  
  output$aggregate_table <- DT::renderDataTable({
    req(input$date_range)
    req(input$dataset_select)
    req(input$time_series_variable)
    req(input$time_series_aggregate)
    req(input$time_series_aggregate_type)
    as.data.frame(aggregate_reactive())
  })
  
  output$aggregate_plot <- DT::renderDataTable({
    req(input$date_range)
    req(input$dataset_select)
    req(input$time_series_variable)
    req(input$time_series_aggregate)
    req(input$time_series_aggregate_type)
    ggplot(as.data.frame(aggregate_reactive()))
  })
  
  output$time_series_plot <- renderPlot({
    req(input$date_range)
    req(input$dataset_select)
    req(input$time_series_variable)
    req(input$time_series_aggregate)
    req(input$time_series_aggregate_type)
    req(input$plot_type)
    if (input$plot_type == "Standard") {
      autoplot(zoo_aggregate_reactive())
      #ggtitle(paste0(zoo_label, " - Summed by Quarter")) +
      #+ xlab("Year") +
      #ylab("Count")
    } else if (input$plot_type == "Seasonal") {
      ggseasonplot(as.ts(zoo_aggregate_reactive()), year.labels = TRUE, year.labels.left = TRUE)
      #+ xlab("Month") +
      #ggtitle(paste0("Seasonal Plot - ", zoo_label))
    } else if (input$plot_type == "Seasonal Polar") {
      ggseasonplot(as.ts(zoo_aggregate_reactive()), polar = TRUE)
      #+ xlab("Month") +
      #ylab("Count") +
      #ggtitle(paste0("Polar Seasonal Plot - ", zoo_label))
    } else if (input$plot_type == "Seasonal Subseries") {
      ggsubseriesplot(as.ts(zoo_aggregate_reactive()))
      #+ xlab("Month") +
      #ylab("Sum (Month)") +
      #ggtitle(paste0("Seasonal Subseries Plot - ", zoo_label))
    }
  })
}