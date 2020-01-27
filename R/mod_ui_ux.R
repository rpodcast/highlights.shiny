# Module UI
  
#' @title   mod_ui_ux_ui and mod_ui_ux_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_ui_ux
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' @import shinyFeedback
#' @import shinyWidgets
#' @import shinyalert
#' @import shinyhelper
#' @import shinyjqui
mod_ui_ux_ui <- function(id){
  ns <- NS(id)
  
  text_style <- "font-weight: bold"
  
  tagList(
    shinyFeedback::useShinyFeedback(),
    fullSection(
      menu = "ui_ux",
      center = FALSE,
      
      # rinterface ----
      fullSlide(
        div(align = "center", h1("The RinteRface Suite", style = text_style)),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              h2("The power of these packages:"),
              list_to_li(
                c(
                  "You don't have to be a web developer ninja to give your apps a professional and polished interface",
                  "All functions developed with same paradigm as the default Shiny UI functions",
                  "Even mobile-focused UI is possible with shinyMobile!",
                  "Add link to shinydev series with David Granjon and screencast on bs4Dash"
                )
              )
            )
          )
        )
      ),
      
      # shinyWidgets ----
      fullSlide(
        div(align = "center", h1("ShinyWidgets", style = text_style)),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              h2("A new take on many kinds of inputs"),
              list_to_li(
                c(
                  "Widgets designed to be intuitive to the end user",
                  "customizable styles to blend in easily with any Shiny UI framework",
                  "Real projects inform development of these utilities",
                  "demo my favorites: The selector with all/none, radios with icons, etc",
                  "Link to shinydeveries episode with Victor & Fanny, as well as their great shinyWidgetss gallery"
                )
              )
            )
          )
        )
      ),
      
      # ux workflows ----
      fullSlide(
        div(align = "center", h1("User Experience", style = text_style)),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              numericInput(
                ns("exampleInput"),
                "Show Feedback When < 0",
                value = 3
              )
            )
          )
        )
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_ui_ux
#' @export
#' @keywords internal
    
mod_ui_ux_server <- function(input, output, session){
  ns <- session$ns
  
  # reactive for number of characters in string
  text_length <- reactive({
    stringr::str_length(input$text_feedback)
  })
  
  # TODO figure out why it is not working
  observeEvent(input$exampleInput, {
    ns <- session$ns
    message("hi")
    feedback(
      ns("exampleInput"),
      condition = input$exampleInput < 0,
      text = "I am negative",
      color = "#d9534f",
      icon = shiny::icon("exclamation-sign", lib="glyphicon")
    )
  })
}
    
## To be copied in the UI
# mod_ui_ux_ui("ui_ux_ui_1")
    
## To be copied in the server
# callModule(mod_ui_ux_server, "ui_ux_ui_1")
 
