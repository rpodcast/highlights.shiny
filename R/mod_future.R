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
      fullSlide(
        div(
          align = "center",
          h1("How about ... a Shinyverse?")
        ),
        fullContainer(
          center = TRUE,
          fullRow(
            div(
              align = "center",
              h3("Imagine a curated source of the packages and applications built by the Shiny community, for the Shiny community!"),
            )
          ),
          fullRow(
            center = TRUE,
            fullColumn(
              list_to_p(
                c("Interactive gallery with dynamic filtering, searching, and dynamic results",
                  "Each resource has a vignette, article, or example application readily available",
                  "Encourage collaboration and sharing knowledge",
                  "Links to resources created by authors and developers",
                  "Crowd-sourced effort!"
                )
              )
            )
          )
        ),
        div(
          align = "center",
          h1("Let's create a Shinyverse together!")
        )
      ),
      
      # Wrap up
      fullSlide(
        center = TRUE,
        div(
          align = "center",
          h1("Watch this space!"),
          h2("Shiny Developer Series continues in 2020"),
          h2("Estabilish a new platform for a curated Shinyverse")
        ),
        img(src = "https://media.giphy.com/media/K5xgW19wJ5eP6/giphy.gif", style="width:600px;height:400px;"),
        div(
          align = "center",
          h4("Poster app deployed at ", a(href = "https://rpodcast.shinyapps.io/highlights-shiny", "rpodcast.shinyapps.ip/highlights-shiny")),
          h4("Source code available at ", a(href = "https://github.com/rpodcast/highlights.shiny", "github.com/rpodcast/highlights.shiny"))
        )
      )
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
 
