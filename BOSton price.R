# Install and load necessary packages
if (!requireNamespace("MASS", quietly = TRUE)) {
  install.packages("MASS")
}
if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}

library(MASS)
library(shiny)

# Load Boston dataset
data(Boston)

# Define UI
ui <- fluidPage(
  titlePanel("Boston House Price Prediction"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Select Predictor Variable", choices = names(Boston)),
      sliderInput("deviation", "Select Deviation Threshold:", min = 0, max = 10, value = 2),
      actionButton("updatePlot", "Update Plot")
    ),
    mainPanel(
      plotOutput("scatterPlot"),
      plotOutput("densityPlot"),
      plotOutput("deviationPlot")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Reactive dataset for linear regression
  linear_data <- reactive({
    data.frame(
      Predictor = Boston[[input$variable]],
      Price = Boston$medv
    )
  })
  
  # Linear regression model
  lm_model <- reactive({
    lm(Price ~ Predictor, data = linear_data())
  })
  
  # Render scatter plot
  output$scatterPlot <- renderPlot({
    plot(linear_data(), main = "Scatter Plot",
         xlab = input$variable, ylab = "Price", pch = 19, col = "blue")
    abline(lm_model(), col = "red", lwd = 2)
  })
  
  # Render density plot
  output$densityPlot <- renderPlot({
    density_data <- density(Boston$medv)
    plot(density_data, main = "Density Plot", xlab = "Price")
  })
  
  # Render deviation plot
  output$deviationPlot <- renderPlot({
    deviations <- resid(lm_model())
    plot(deviations, main = "Deviation Plot",
         xlab = "Observation", ylab = "Deviation",
         pch = 19, col = ifelse(abs(deviations) > input$deviation, "red", "blue"))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
