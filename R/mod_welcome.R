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
  
  text_style <- "color:#000000; font-weight: bold"
  contact_style <- "color:#000000; font-weight: bold"
  tagList(
    
    # title page ----
    fullSectionPlot(
      outputId = ns("bg"),
      menu = "intro",
      center = TRUE,
      h1("Reaping the Benefits of the Shiny Community", style = text_style),
      h2("(and how you can help!)"),
      rep_br(1),
      #h1("Highlights from the ", shiny::img(src = system.file("app", "www", "img", "shiny.png", package = "highlights.shiny"), alt = ""), "Community!"),
      h2("Eric Nantz", style = contact_style),
      h2("Statistician / Podcaster / ", fontawesome::fa("r-project", fill = "stellblue"), "Enthusiast", style = contact_style),
      rep_br(2),
      h2("rstudio::conf 2020", style = contact_style),
      rep_br(7),
      h2(fontawesome::fa("twitter"), a(href = "https://twitter.com/thercast", "@thercast"), style = "font-weight: bold"),
      h2(fontawesome::fa("microphone"), a(href = "https://r-podcast.org", "r-podcast.org"), style = "font-weight: bold"),
      h2(fontawesome::fa("tv"), a(href = "https://shinydevseries.com", "shinydevseries.com"), style = "font-weight: bold"),
      h2(fontawesome::fa("github"), a(href = "https://github.com/rpodcast", "github.com/rpodcast"), style = "font-weight: bold"),
      
      
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
  
  # establish waiter
  w <- waiter::Waiter$new(id = ns("bg"))
  
  output$bg <- renderImage({
    w$show()
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
 
