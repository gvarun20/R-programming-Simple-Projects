library(shiny)
library(DT)
library(ggplot2)
library(randomForest)

# Example dataset
set.seed(42)
mobile_data <- data.frame(
  RAM = sample(c(2, 4, 8, 16), 100, replace = TRUE),
  InternalMemory = sample(c(16, 32, 64, 128, 256), 100, replace = TRUE),
  PriceRange = as.factor(sample(1:5, 100, replace = TRUE))
)

# Define UI
ui <- fluidPage(
  titlePanel("Mobile Price Range Prediction"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Select Feature", choices = names(mobile_data)[1:2]),
      actionButton("updatePlot", "Update Plot")
    ),
    mainPanel(
      plotOutput("scatterPlot"),
      plotOutput("importancePlot")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Reactive dataset for random forest
  rf_data <- reactive({
    data.frame(
      Feature = mobile_data[[input$variable]],
      PriceRange = mobile_data$PriceRange
    )
  })
  
  # Random forest model
  rf_model <- reactive({
    randomForest(PriceRange ~ Feature, data = rf_data(), ntree = 100)
  })
  
  # Render scatter plot
  output$scatterPlot <- renderPlot({
    plot(rf_data(), main = "Scatter Plot",
         xlab = input$variable, ylab = "Price Range", pch = 19, col = "blue")
  })
  
  # Render importance plot
  output$importancePlot <- renderPlot({
    importance_data <- as.data.frame(importance(rf_model()))
    barplot(importance_data[, 1], main = "Variable Importance",
            names.arg = rownames(importance_data), col = "skyblue")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
