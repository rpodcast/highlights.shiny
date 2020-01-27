#' @import shiny
app_server <- function(input, output,session) {
  
  # observer for shinyhelper
  # TODO: Figure out why this doesn't work right now (I think I solved it once before?
  # shinyhelper::observe_helpers(
  #   help_dir = "inst/app/www"
  #   #help_dir = system.file("app", "www", package = "highlights.shiny")
  # )
  
  callModule(mod_welcome_server, "welcome_ui_1")
  callModule(mod_shiny_intro_server, "shiny_intro_ui_1")
  callModule(mod_architecture_server, "architecture_ui_1")
  callModule(mod_ui_ux_server, "ui_ux_ui_1")
}
