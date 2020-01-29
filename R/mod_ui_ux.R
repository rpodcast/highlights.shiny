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
    
    fullSection(
      menu = "ui_ux",
      center = FALSE,
      
      # rinterface ----
      fullSlide(
        div(align = "center", h1("The RinteRface Suite")),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              div(
                align = "center",
                tags$iframe(
                  src = "https://rinterface.com",
                  #src = "https://rpodcast.shinyapps.io/shinylego/", 
                  height = 600, 
                  width = 800,
                  style="-webkit-transform:scale(0.8);-moz-transform-scale(0.8);"
                )
                #p("Visit ", a(href = "https://rinterface.com", "rinterface.com"))
              )
            ),
            fullColumn(
              list_to_li(
                c(
                  "You don't have to be a web developer ninja to give your apps a professional and polished interface",
                  "All functions developed with same paradigm as the default Shiny UI functions",
                  "Even mobile-focused UI is possible with shinyMobile!"
                )
              )
            )
          ),
          #fullRow(
            div(
              align = "center",
              h4(a(href = "https://rinterface.com", "rinterface.com")),
              h4(a(href = "https://shinydevseries.com/ep4", "shinydevseries.com/ep4")),
              h4(a(href = "https://shinydevseries.com/post/bs4dash-demo", "bs4Dash screencast")),
              h4(a(href = "https://rpodcast.shinyapps.io/rsnippets"), "Residual Snippets {shinyMobile} app!")
            )
          #)
        )
      ),
      
      # shinyWidgets ----
      fullSlide(
        div(align = "center", h1("ShinyWidgets")),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              div(
                align = "center", 
                h3("A new spin on many Shiny inputs"),
                h4("Created by ", a(href = "https://dreamrs.fr", "dreamRs "))
              ),
              list_to_li(
                c(
                  "Widgets designed to be intuitive to the end user",
                  "customizable styles to blend in easily with any Shiny UI framework",
                  "Real projects inform development of these utilities",
                  "A gallery built right in the app!"                
                )
              )
            ),
            fullColumn(
              div(
                #align = "center",
                uiOutput(ns("picker_example"))
              )
            )
          )
        ),
        fullContainer(
          fullRow(
            fullColumn(
              h4(a(href = "https://shinydevseries.com/ep7", "shinydevseries.com/ep7")),
              h4(a(href = "http://shinyapps.dreamrs.fr/shinyWidgets/", "shinyapps.dreamrs.fr/shinyWidgets"))
            )
          )
        )
      ),
      
      # shinyjqui ----
      fullSlide(
        div(
          align = "center", 
          h1("Harnessing JQuery with shinyjqui"),
          h4("Simple yet powerful wrappers to JQuery interactions"),
          h5(a(href = "https://shinydevseries.com/ep6", "shinydevseries.com/ep6")),
          h5(a(href = "https://yang-tang.github.io/shinyjqui/index.html", "yang-tang.github.io/shinyjqui"))
        ),
        fullContainer(
          center = FALSE,
          fullRow(
            fullColumn(
              h4("Please resize me!"),
              jqui_resizable(
                div(
                  id = "resize me!",
                  plotOutput(ns("package_chart2"))
                )
              )
            ),
            fullColumn(
              #jqui_draggable(
                div(
                  align = "center",
                  tags$iframe(
                    src = "https://yang-tang.github.io/shinyjqui/index.html",
                    height = 600, 
                    width = 800,
                    style="-webkit-transform:scale(0.8);-moz-transform-scale(0.8);"
                  )
                  #p("Visit ", a(href = "https://rinterface.com", "rinterface.com"))
                )
              #),
            )
          )
        )
      )
      
      # ux workflows ----
      # fullSlide(
      #   div(align = "center", h1("User Experience")),
      #   fullContainer(
      #     center = FALSE,
      #     fullRow(
      #       fullColumn(
      #         numericInput(
      #           ns("exampleInput"),
      #           "Show Feedback When < 0",
      #           value = 3
      #         )
      #       )
      #     )
      #   )
      # )
    )
  )
}
    
# Module Server
    
#' @rdname mod_ui_ux
#' @export
#' @keywords internal
    
mod_ui_ux_server <- function(input, output, session){
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
  
  output$package_chart2 <- renderPlot({
    ggplot(plot_df(), aes(x = first_release_year)) +
      geom_bar()
  })
  
  output$picker_example <- renderUI({
    # create values for picker input
    df <- shiny_rev_db %>%
      select(package, n_releases)
    
    pickerInput(
      ns("picker_select"),
      "Should you click all of these?",
      choices = df$package,
      multiple = TRUE,
      choicesOpt = list(
        subtext = glue::glue("Releases on CRAN: {n}", n = df$n_releases)
      ),
      options = list(
        `actions-box` = TRUE,
        liveSearch = TRUE,
        size = 6
      ),
      width = "80%"
    )
  })
  
  # reactive for number of characters in string
  # text_length <- reactive({
  #   stringr::str_length(input$text_feedback)
  # })
  # 
  # # TODO figure out why it is not working
  # observeEvent(input$exampleInput, {
  #   ns <- session$ns
  #   message("hi")
  #   feedback(
  #     ns("exampleInput"),
  #     condition = input$exampleInput < 0,
  #     text = "I am negative",
  #     color = "#d9534f",
  #     icon = shiny::icon("exclamation-sign", lib="glyphicon")
  #   )
  # })
}
    
## To be copied in the UI
# mod_ui_ux_ui("ui_ux_ui_1")
    
## To be copied in the server
# callModule(mod_ui_ux_server, "ui_ux_ui_1")
 
