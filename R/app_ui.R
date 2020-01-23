#' @import shiny
#' @import fullPage
app_ui <- function() {
  
  sections.color = c(
    "#C3F3EC"
    # "#FE9199",
    # "#FFADB2",
    # "#FFCAB1",
    # "#C3F3EC"
  )
  
  # my_options <- list(
  #   loopBottom = TRUE,
  #   navigation = FALSE,
  #   keyboardScrolling = TRUE
  # )
  
  my_options <- list(
    loopBottom = TRUE,
    navigation = TRUE,
    keyboardScrolling = TRUE,
    sectionsColor = sections.color
  )
  
  tagList(

    # Leave this function for adding external resources
    #golem_add_external_resources(),

    # List the first level UI elements here
    fullPage(
      center = TRUE,
      opts = my_options,
      menu = c(
        "Welcome" = "intro"
        # "Architect" = "dev",
        # "User Interface" = "ui_pkgs",
        # "User Experience" = "ux_pkgs",
        # "The Future" = "shiny_future"
      ),
    
    # pagePiling(
    #   center = TRUE,
    #   sections.color = sections.color,
    #   opts = my_options,
    #   menu = c(
    #     "Welcome" = "intro"
    #     # "Architect" = "dev",
    #     # "User Interface" = "ui_pkgs",
    #     # "User Experience" = "ux_pkgs",
    #     # "The Future" = "shiny_future"
    #   ),

      mod_welcome_ui("welcome_ui_1")
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
