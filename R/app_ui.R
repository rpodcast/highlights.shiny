#' @import shiny
#' @import fullPage
app_ui <- function() {
  
  my_options <- list(
    loopBottom = TRUE,
    navigation = TRUE,
    keyboardScrolling = TRUE
  )
  
  sections.color = c(
    "#C3F3EC",
    "#FE9199",
    "#FFADB2",
    "#FFCAB1",
    "#C3F3EC"
  )
  
  
  tagList(
    # Leave this function for adding external resources
    #golem_add_external_resources(),
    
    # List the first level UI elements here 
    pagePiling(
      center = TRUE,
      sections.color = sections.color,
      opts = my_options,
      menu = c(
        "History" = "intro",
        "Architect" = "dev",
        "User Interface" = "ui_pkgs",
        "User Experience" = "ux_pkgs",
        "The Future" = "shiny_future"
      ),
      
      pageTheme("aqua"),
      
      pageSection(
        menu = "intro",
        h1("Highlights of the Shiny Community!"),
        h2("Eric Nantz"),
        h2("Statistician / Podcaster / Shiny Enthusiest"),
        h2("rstudio::conf 2020"),
        br(),
        br(),
        pageContainer(
          pageRow(
            pageButtonTo(tags$p(fontawesome::fa("car", height = 12, fill = "forestgreen"), "Hello"), section = "intro")
          )
        )
      )
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  # addResourcePath(
  #   'www', system.file('app', 'www', package = 'hightlights.shiny')
  # )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
