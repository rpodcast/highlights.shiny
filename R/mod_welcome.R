# Module UI
  
#' @title   mod_welcome_ui and mod_welcome_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_welcome
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' @import fullPage
mod_welcome_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    # title page ----
    fullSectionPlot(
      outputId = ns("bg"),
      menu = "intro",
      h1("Highlights of the Shiny Community!"),
      h2("Eric Nantz"),
      h2("Statistician / Podcaster / Shiny Enthusiest"),
      h2("rstudio::conf 2020"),
      br(),
      br()
    ),
    # pageSectionPlot(
    #   outputId = ns("bg"),
    #   menu = "intro",
    #   h1("Highlights of the Shiny Community!"),
    #   h2("Eric Nantz"),
    #   h2("Statistician / Podcaster / Shiny Enthusiest"),
    #   h2("rstudio::conf 2020"),
    #   br(),
    #   br()
    # ),
  )
}
    
# Module Server
    
#' @rdname mod_welcome
#' @export
#' @keywords internal
    
mod_welcome_server <- function(input, output, session){
  ns <- session$ns
  
  output$bg <- renderImage({
    tmpfile <- title_background(sticker_width = 400, 
                                hex_scale_pct_width = 70, 
                                hex_offset_vec = c(1200, 550)) %>%
      image_write(tempfile(fileext='png'), format = 'png')
    
    # Return a list
    list(src = tmpfile, contentType = "image/png")
  })
}
    
## To be copied in the UI
# mod_welcome_ui("welcome_ui_1")
    
## To be copied in the server
# callModule(mod_welcome_server, "welcome_ui_1")
 
