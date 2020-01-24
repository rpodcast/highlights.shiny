#' @import shiny
app_server <- function(input, output,session) {
  
  callModule(mod_welcome_server, "welcome_ui_1")
  callModule(mod_shiny_intro_server, "shiny_intro_ui_1")
}
