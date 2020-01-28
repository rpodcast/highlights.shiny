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
        div(align = "center", h1("Enter the Golem!")),
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
                h3("To find out more..."),
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
                  height = 500, 
                  width = 700,
                  style="-webkit-transform:scale(0.8);-moz-transform-scale(0.8);"
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
        div(align = "center", h1("Announcing tidymodules!")),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              h4("{tidymodules} builds upon shiny modules using R6 to provide a new object-oriented programming (OOP) approach for module development:"),
              list_to_li(
                c(
                  "Authored by Mustapha Larbaouri & Xiao Ni (Novartis)",
                  "New module interface using input/output ports",
                  "Tidy operators for handling cross-module communication"
                )
              ),
              shiny::tableOutput(ns("tidymodules_features")),
              div(
                align = "center",
                h2("Find out more at ", a(href = "https://bit.ly/tidymodules", "bit.ly/tidymodules")),
                h2("Example app: ", a(href = "https://tidymodules.shinyapps.io/1_simple_addition/", "tidymodules.shinyapps.io/1_simple_addition"))
              )
              
            )
            
          )
        )
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
  
  output$tidymodules_features <- shiny::renderTable({
    df <- tibble::tribble(
      ~Feature, ~tidymodules, ~`conventional modules`,
      "Programming Style", "R6 OOP", "Functional",
      "Namespace Management", "Automatic/generated; Group; ID-based lookup", "User manually defines & matches namespace ID between UI and server",
      "Module Communication", "New input/output port structure inside modules; Connecting ports using tidy operators; Automatic network diagram", "functional parameters passing in callModule()\nChallenging to manage complex applications with many modules",
      "Inheritance", "Class inheritance; Port inheritance for nested modules", "NA",
      "Session management", "Multiple strategies for managing shiny user sessions; Caching of modules", "NA"
    )
    
    as.data.frame(df)
  },
  striped = TRUE,
  type = "html"
  )
}
    
## To be copied in the UI
# mod_architecture_ui("architecture_ui_1")
    
## To be copied in the server
# callModule(mod_architecture_server, "architecture_ui_1")
