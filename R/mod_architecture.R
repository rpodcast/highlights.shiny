# Module UI
  
#' @title   mod_architecture_ui and mod_architecture_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_architecture
#'
#' @keywords internal
#' @import fullPage
#' @export 
#' @importFrom shiny NS tagList 
mod_architecture_ui <- function(id) {
  ns <- NS(id)
  
  text_style <- "font-weight: bold"
  
  tagList(
    fullSection(
      menu = "dev",
      center = FALSE,
      
      # golem ----
      fullSlide(
        div(align = "center", h1("Enter the Golem!", style = text_style)),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              div(
                align = "center", 
                h3(fontawesome::fa("rocket"), "A new framework for building robust Shiny apps as an R package"),
                h4("Created by ", a(href = "https://thinkr.fr", "Think-R"))
              ),
              list_to_li(
                c(
                  "Scripts guide you with first steps and convenience functions",
                  "Encourages development best practices (especially modules!)",
                  "Streamlines deployment on multiple platforms"
                )
              ),
              div(
                align = "center", 
                h3("To find out more...", style = text_style),
              ),
              h4(fontawesome::fa("calendar"), "See Colin Faye's upcoming talk this Wednesday! (2020-01-29 2:15 PM)"),
              h4("Shiny Developer Series Episode 2:", a(href = "https://shinydevseries.com/ep2", "shinydevseries.com/ep2")),
              h4("Hands-on demonstration of golem:", a(href = "https://shinydevseries.com/post/golem-demo/", "shinydevseries.com/post/golem-demo"))
            ),
            fullColumn(
              div(
                align = "center",
                tags$iframe(
                  src = "https://connect.thinkr.fr/hexmake/",
                  #src = "https://rpodcast.shinyapps.io/shinylego/", 
                  height = 600, 
                  width = 800
                  #style="-webkit-transform:scale(0.5);-moz-transform-scale(0.5);")
                ),
                p("Golem in the wild!", a(href = "https://connect.thinkr.fr/hexmake", "connect.thinkr.fr/hexmake"))
              )
            )
          )
        )
      ),
      
      # tidymodules ----
      fullSlide(
        center = FALSE,
        div(align = "center", h1("Announcing tidymodules!", style = text_style))
        # TODO: polish
        # https://github.com/Novartis/tidymodules
        # https://tidymodules.shinyapps.io/1_simple_addition/
        # see word doc for more info and add table
        # emphasize collaboration and getting involved
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_architecture
#' @export
#' @keywords internal
    
mod_architecture_server <- function(input, output, session){
  ns <- session$ns
}
    
## To be copied in the UI
# mod_architecture_ui("architecture_ui_1")
    
## To be copied in the server
# callModule(mod_architecture_server, "architecture_ui_1")
