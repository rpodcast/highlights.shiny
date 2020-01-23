#' @import shiny
app_server <- function(input, output,session) {
  
  callModule(mod_welcome_server, "welcome_ui_1")
    
  # output$bg <- renderImage({
  #   tmpfile <- title_background(sticker_width = 400,
  #                               hex_scale_pct_width = 70,
  #                               hex_offset_vec = c(1200, 550)) %>%
  #     image_write(tempfile(fileext='png'), format = 'png')
  # 
  #   # Return a list
  #   list(src = tmpfile, contentType = "image/png")
  # })
}
