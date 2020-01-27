library(shiny)
library(shinyFeedback)

hello_ui <- function(id) {
  ns <- NS(id)
  tagList(
    numericInput(
      ns("exampleInput"),
      "Show Feedback When < 0",
      value = 2
    )
  )
  
}

hello_server <- function(input, output, session) {
  observeEvent(input$exampleInput, {
    ns <- session$ns
    feedback(
      ns("exampleInput"),
      condition = input$exampleInput < 0,
      text = "I am negative",
      color = "#d9534f",
      icon = shiny::icon("exclamation-sign", lib="glyphicon")
    )
  })
}

ui <- fluidPage(
  useShinyFeedback(),
  hello_ui("hello")
  
)

server <- function(input, output, session) {
  callModule(hello_server, "hello")
  
}

shinyApp(ui, server)
