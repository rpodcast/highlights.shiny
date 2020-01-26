#' @import shiny
#' @import fullPage
app_ui <- function() {
  
  sections.color = c(
    "#C3F3EC",
    "#ccf2ff",
    "#ccf2ff",
    "#ccf2ff",
    "#ccf2ff",
    "#ccf2ff"
  )
  
  my_options <- list(
    loopBottom = TRUE,
    navigation = FALSE,
    keyboardScrolling = TRUE,
    sectionsColor = sections.color
  )
  
  tagList(

    # Leave this function for adding external resources
    golem_add_external_resources(),

    # List the first level UI elements here
    fullPage(
      center = FALSE,
      opts = my_options,
      menu = c(
        "Welcome" = "intro",
        "Discovery" = "discover",
        "Architecture" = "dev",
        "UI/UX" = "ui_ux",
        "Extending" = "extend",
        "The Future" = "shiny_future"
      ),
    
      mod_welcome_ui("welcome_ui_1"),
      mod_shiny_intro_ui("shiny_intro_ui_1"),
      mod_architecture_ui("architecture_ui_1"),
      mod_ui_ux_ui("ui_ux_ui_1")
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  # addResourcePath(
  #   'www', system.file('app', 'www', package = 'highlights.shiny')
  # )
 
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
    
    waiter::use_waiter(),
    shinyFeedback::useShinyFeedback()
  )
}
