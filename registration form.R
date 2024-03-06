# Define the UI
ui <- fluidPage(
  titlePanel("Registration Form"),
  sidebarLayout(
    sidebarPanel(
      textInput("firstName", "First Name:"),
      textInput("lastName", "Last Name:"),
      textInput("email", "Email:"),
      passwordInput("password", "Password:"),
      passwordInput("confirmPassword", "Confirm Password:"),
      actionButton("submitBtn", "Submit")
    ),
    mainPanel(
      verbatimTextOutput("registrationOutput")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  registration_data <- reactiveValues()
  
  observeEvent(input$submitBtn, {
    if (input$password != input$confirmPassword) {
      registration_data$error <- "Passwords do not match."
    } else {
      registration_data$first_name <- input$firstName
      registration_data$last_name <- input$lastName
      registration_data$email <- input$email
      registration_data$error <- NULL
      registration_data$submitted <- TRUE
    }
  })
  
  output$registrationOutput <- renderPrint({
    if (!is.null(registration_data$error)) {
      return(registration_data$error)
    } else if (registration_data$submitted) {
      return(list(
        "First Name" = registration_data$first_name,
        "Last Name" = registration_data$last_name,
        "Email" = registration_data$email
      ))
    }
  })
}

# Run the application
shinyApp(ui, server)