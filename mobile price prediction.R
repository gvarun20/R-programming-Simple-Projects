install.packages(c("shiny", "randomForest"))
library(shiny)
library(randomForest)

ui <- fluidPage(
  titlePanel("Mobile Price Range Predictor"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload Mobile Data (CSV)"),
      actionButton("trainButton", "Train Model")
    ),
    mainPanel(
      plotOutput("importancePlot"),
      textOutput("modelStatus")
    )
  )
)

server <- function(input, output, session) {
  mobile_data <- reactiveVal(NULL)
  rf_model <- reactiveVal(NULL)
  
  observeEvent(input$file, {
    mobile_data(read.csv(input$file$datapath))
  })
  
  observeEvent(input$trainButton, {
    req(mobile_data())
    rf_model(randomForest(price_range ~ ., data = mobile_data()))
  })
  
  output$importancePlot <- renderPlot({
    req(rf_model())
    importance_plot <- barplot(importance(rf_model())[,"MeanDecreaseGini"], 
                               main = "Variable Importance",
                               names.arg = names(importance(rf_model())[,"MeanDecreaseGini"]),
                               col = "skyblue")
    text(importance_plot, 1, round(importance(rf_model())[,"MeanDecreaseGini"], 2), pos = 3, col = "red")
  })
  
  output$modelStatus <- renderText({
    if (is.null(rf_model())) {
      "Model not trained. Upload data and click 'Train Model'."
    } else {
      "Model trained successfully. You can now explore variable importance."
    }
  })
}

shinyApp(ui = ui, server = server)

