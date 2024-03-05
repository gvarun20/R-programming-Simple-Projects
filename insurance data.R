# Install and load required packages if not already installed
if (!require("shiny")) install.packages("shiny")
if (!require("shinythemes")) install.packages("shinythemes")

library(shiny)
library(shinythemes)
library(readr)
library(dplyr)
library(ggplot2)
library(lmtest)

# Define the UI
ui <- fluidPage(
  theme = shinytheme("flatly"),
  
  # App title
  titlePanel("Linear Regression App for Insurance Dataset"),
  
  # Sidebar layout with input and output
  sidebarLayout(
    sidebarPanel(
      # Upload button for CSV file
      fileInput("file", "Choose CSV File",
                accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
      
      # Select input for dependent variable (y)
      selectInput("y_variable", "Select Dependent Variable (Y):", ""),
      
      # Select input for independent variables (X)
      selectInput("x_variables", "Select Independent Variables (X):", ""),
      
      # Action button to trigger regression analysis
      actionButton("run_regression", "Run Regression Analysis")
    ),
    
    # Main panel for displaying output
    mainPanel(
      # Output for displaying regression results
      verbatimTextOutput("regression_output"),
      
      # Plot for regression line
      plotOutput("regression_plot")
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  
  # Reactive values to store data
  data <- reactiveValues(
    df = NULL
  )
  
  # Load data from uploaded CSV file
  observeEvent(input$file, {
    data$df <- read.csv(input$file$datapath)
    
    # Update selectInput choices based on loaded dataset
    updateSelectInput(session, "y_variable", choices = names(data$df), selected = names(data$df)[1])
    updateSelectInput(session, "x_variables", choices = names(data$df), selected = names(data$df)[-1])
  })
  
  # Perform linear regression and display results
  observeEvent(input$run_regression, {
    # Check if data is loaded
    if (!is.null(data$df)) {
      # Extract selected variables
      y_var <- input$y_variable
      x_vars <- input$x_variables
      
      # Create formula for linear regression
      formula <- as.formula(paste(y_var, "~", paste(x_vars, collapse = "+")))
      
      # Run linear regression
      lm_model <- lm(formula, data = data$df)
      
      # Display regression results
      output$regression_output <- renderPrint({
        summary(lm_model)
      })
      
      # Plot regression line
      output$regression_plot <- renderPlot({
        ggplot(data$df, aes_string(x = x_vars, y = y_var)) +
          geom_point() +
          geom_smooth(method = "lm", se = FALSE, color = "blue") +
          labs(title = "Linear Regression Plot", x = x_vars, y = y_var)
      })
    }
  })
}

# Run the Shiny app
shinyApp(ui, server)
