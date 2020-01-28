# Module UI
  
#' @title   mod_shiny_intro_ui and mod_shiny_intro_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_shiny_intro
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' @import fullPage
#' @import dplyr
#' @import ggplot2
mod_shiny_intro_ui <- function(id){
  ns <- NS(id)
  

  
  tagList(
    fullSection(
      menu = "discover",
      center = FALSE,
      fullSlide(
        div(align = "center", h1("Shiny Catches On")),
        fullContainer(
          fullRow(
            fullColumn(
              h4("Shiny has enabled many new and innovative workflows across many domains"),
              list_to_li(
                c(
                  "Dynamic and reactive user interface",
                  "Enables your colleagues to discover insights from data without being a master R programmer",
                  "If it can be done in R, you can put a Shiny app in front of it!"
                )
              ),
              rep_br(2),
              h3(glue::glue("{n_packages} packages on CRAN authored outside of RStudio use or extend Shiny!", n_packages = nrow(shiny_rev_db)))
            ),
            fullColumn(
              plotOutput(ns("package_chart"))
            )
          )
        )
      ),
      fullSlide(
        center = TRUE,
        div(align = "center", h1("Keeping up?")),
        p("Clearly the community around Shiny has grown immensely ..."),
        img(src = "https://media.giphy.com/media/9rhNvnUJCEQpa2xCj8/giphy.gif", style="width:1000px;height:800px;"),
        h3("How can we keep up and discover these new packages, apps, and more?")
      ),
      fullSlide(
        center = FALSE,
        div(align = "center", h1("Straight to the source(s)")),
        fullContainer(
          fullRow(
            fullColumn(
              list_to_li(
                c(
                  "Shiny can get you going quickly to make powerful web apps ...",
                  "But you can take your apps to a whole new level by tapping into the powerful packages created by this great community",
                  "I wanted to connect with the authors behind these packages and share these ingrediants for my recipes!"
                )
              )
            ),
            fullColumn(
              #https://media.giphy.com/media/dBNBKXIknaXNtK9lGQ/giphy.gif
              img(src = "https://media.giphy.com/media/dBNBKXIknaXNtK9lGQ/giphy.gif", style="width:600px;height:600px;")
            )
          )
        )
      ),
      fullSlide(
        center = TRUE,
        h1("Shiny Developer Series!"),
        fullContainer(
          fullRow(
            fullColumn(
              tags$iframe(src = "https://shinydevseries.com", height = 700, width = 900),
              h3(tags$a(href = "https://shinydevseries.com", "shinydevseries.com"))
            ),
            fullColumn(
              h3("Partnership with RStudio's very own Curtis Kephart", a(href = "https://twitter.com/EconomiCurtis", "@EconomiCurtis")),
              h3("Let's explore contributions from these brilliant authors and more!")
            )
          )
        )
        
      )
    )
  )
}
    
# Module Server
    
#' @rdname mod_shiny_intro
#' @export
#' @keywords internal
    
mod_shiny_intro_server <- function(input, output, session){
  ns <- session$ns
  
  # plot data frame
  plot_df <- reactive({
    # shiny release date: 2012-12-01
    
    # question 1: number of shiny community packages with first release in each year
    # since Shiny was released (2013-2019)
    
    years_df <- shiny_rev_db %>%
      mutate(first_release_year = lubridate::year(first_release_date)) %>%
      filter(between(first_release_year, 2013, 2019))
    
    return(years_df)
  })
  
  output$package_chart <- renderPlot({
    ggplot(plot_df(), aes(x = first_release_year)) +
      geom_bar()
  })
}
    
## To be copied in the UI
# mod_shiny_intro_ui("shiny_intro_ui_1")
    
## To be copied in the server
# callModule(mod_shiny_intro_server, "shiny_intro_ui_1")
 
