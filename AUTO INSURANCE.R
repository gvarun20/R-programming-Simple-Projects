library(shiny)
library(shinyjs)
library(ggplot2)
library(dplyr)

# Define UI
ui <- fluidPage(
  titlePanel("Auto Insurance Linear Regression"),
  shinyjs::useShinyjs(),  # Initialize shinyjs
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload CSV File"),
      selectInput("x_var", "Select X Variable", ""),
      selectInput("y_var", "Select Y Variable", ""),
      numericInput("new_value", "Enter New Value for X", value = 0),
      actionButton("run_analysis", "Run Linear Regression"),
      br(),
      textOutput("predicted_value")
    ),
    mainPanel(
      plotOutput("scatterplot"),
      verbatimTextOutput("summary_output")
    )
  )
)

# Define server logic
server <- function(input, output, session) {  # Add session parameter
  auto_insurance <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  observe({
    updateSelectInput(session, "x_var", choices = names(auto_insurance()))
    updateSelectInput(session, "y_var", choices = names(auto_insurance()))
  })
  
  observeEvent(input$run_analysis, {
    req(input$x_var, input$y_var)
    
    x_var <- input$x_var
    y_var <- input$y_var
    
    # Ensure that variable names are consistent
    x_var_cleaned <- make.names(x_var)
    y_var_cleaned <- make.names(y_var)
    
    model <- lm(paste(y_var_cleaned, "~", x_var_cleaned), data = auto_insurance())
    summary_text <- summary(model)
    
    output$scatterplot <- renderPlot({
      ggplot(auto_insurance(), aes_string(x = x_var_cleaned, y = y_var_cleaned)) +
        geom_point() +
        geom_smooth(method = "lm", se = FALSE, color = "blue") +
        labs(title = "Scatterplot with Linear Regression Line")
    })
    
    output$summary_output <- renderPrint({
      summary_text
    })
    
    # Predict new value
    predicted_value <- predict(model, newdata = data.frame(x_var_cleaned = input$new_value))
    output$predicted_value <- renderText({
      paste("Predicted", y_var_cleaned, "value for", x_var_cleaned, " =", round(predicted_value, 2))
    })
  })
}

# Run the Shiny app
shinyApp(ui, server)
