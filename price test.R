# Install and load necessary packages
if (!requireNamespace("randomForest", quietly = TRUE)) {
  install.packages("randomForest")
}
if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}

library(randomForest)
library(shiny)

# Load the mobile phone dataset (you can replace this with your actual dataset)
# Assume the dataset has features like RAM, Internal Memory, etc., and a Price Range column
# Here, I'm using a sample dataset from the randomForest package for illustration
data(mobile)

# Define UI
ui <- fluidPage(
  titlePanel("Mobile Price Range Prediction"),
  sidebarLayout(
    sidebarPanel(
      selectInput("feature1", "Select Feature 1", choices = colnames(mobile)),
      selectInput("feature2", "Select Feature 2", choices = colnames(mobile)),
      actionButton("trainButton", "Train Model")
    ),
    mainPanel(
      plotOutput("scatterPlot"),
      textOutput("modelInfo")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Reactive dataset for classification
  classify_data <- reactive({
    data.frame(
      Feature1 = mobile[[input$feature1]],
      Feature2 = mobile[[input$feature2]],
      PriceRange = as.factor(mobile$price_range)
    )
  })
  
  # Random Forest model
  rf_model <- reactive({
    randomForest(PriceRange ~ Feature1 + Feature2, data = classify_data())
  })
  
  # Render scatter plot
  output$scatterPlot <- renderPlot({
    plot(classify_data(), main = "Scatter Plot",
         xlab = input$feature1, ylab = input$feature2, pch = 19, col = classify_data()$PriceRange)
  })
  
  # Display model information
  output$modelInfo <- renderText({
    if (input$trainButton > 0) {
      paste("Random Forest Model Info:", summary(rf_model()))
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
