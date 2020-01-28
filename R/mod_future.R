# Module UI
  
#' @title   mod_future_ui and mod_future_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_future
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_future_ui <- function(id){
  ns <- NS(id)
  tagList(
    fullSection(
      menu = "future",
      center = FALSE,
      
      # setting the next steps
      fullSlide(
        center = FALSE,
        fullContainer(
          fullRow(
            fullColumn(
              div(align = "center", h1("Searching for more...")),
              h4("Many more excellent packages exist in this growing community"),
              h4("What can we do to make it easier for future Shiny developers to use these ingrediants for their recipes?")
            )
          )
        )
      ),
      
      # existing resources
      fullSlide(
        div(
          align = "center",
          h2("Existing attempts at curation")
        ),
        fullContainer(
          center = TRUE,
          fullRow(
            
            fullColumn(
              div(
                align = "center",
                tags$iframe(src = "https://grabear.github.io/awesome-rshiny", height = 600, width = 700),
                h3(tags$a(href = "https://grabear.github.io/awesome-rshiny", "grabear.github.io/awesome-rshiny"))
              )
            ),
            fullColumn(
              div(
                align = "center",
                tags$iframe(src = "https://shinyapps-recent.appspot.com/recent.html", height = 600, width = 700),
                h3(tags$a(href = "https://shinyapps-recent.appspot.com/recent.html", "shinyapps-recent.appspot.com"))
              )
            )
          )
        )
      ),
      
      # htmlwidgets
      fullSlide(
        div(
          align = "center",
          h2("Inspiration")
        ),
        fullContainer(
          center = TRUE,
          fullRow(
            div(
              align = "center",
              tags$iframe(src = "https://gallery.htmlwidgets.org/", height = 600, width = 1100),
              h3(tags$a(href = "https://gallery.htmlwidgets.org/", "gallery.htmlwidgets.org"))
            )
          )
        )
      ),
      
      # call to action
      
    )
  )
}
    
# Module Server
    
#' @rdname mod_future
#' @export
#' @keywords internal
    
mod_future_server <- function(input, output, session){
  ns <- session$ns
}
    
## To be copied in the UI
# mod_future_ui("future_ui_1")
    
## To be copied in the server
# callModule(mod_future_server, "future_ui_1")
 
