#' Create background for title page
#'
#' @param hex_path directory for where hex png files are stored
#' @param background_file image file for background of slide. 
#'   If NULL, no background image file will be used.
#' @param sticker_width width of each sticker (in pixels)
#' @param sticker_row_size number of rows for the stickers. Default is 5.
#' @param brightness brightness of background supplied to `magick::image_modulate`
#' @param saturation saturation of background supplied to `magick::image_modulate`
#' @param hue hue of background supplied to `magick::image_modulate`
#' @param radius radius of background blur supplied to `magick::image_blur`
#' @param sigma sigma of background blur supplied to `image_blur`
#'
#' @return image produced by `magick::image_composite`
#' @export
#' @import magick
#' @import dplyr
#' @importFrom rlang invoke
#' @importFrom purrr map map2 reduce2 accumulate2 map_lgl set_names map_dbl
title_background <- function(hex_path = system.file("app", "www", "img", package = "highlights.shiny"),
                             background_path = system.file("app", "www", "source_img", package = "highlights.shiny"),
                             background_file = "sky.jpg",
                             sticker_width = 200,
                             sticker_row_size = 4,
                             hex_scale_pct_width = 50,
                             hex_scale_pct_height = NULL,
                             hex_offset_vec = c(500, 200),
                             background_scale_pct_width = 100,
                             background_scale_pct_height = NULL,
                             background_offset_vec = c(100, 300),
                             brightness = 400,
                             saturation = 200,
                             hue = 100,
                             radius = 10,
                             sigma = 5,
                             canvas_color = "white") {
  
  #sticker_files <- fs::dir_ls(hex_path, glob = "*.png")
  sticker_files <- fs::dir_ls(hex_path)
  
  # create random order of stickers
  set.seed(8675309)
  sticker_files <- sample(sticker_files)
  
  sticker_names <- fs::path_file(sticker_files)
  
  stickers <- sticker_files %>%
    map(., function(path) {
      switch(tools::file_ext(path),
             svg = image_read_svg(path),
             pdf = image_read_pdf(path),
             image_read(path))
    }) %>%
    map(image_transparent, "white") %>%
    map(image_trim) %>%
    set_names(sticker_names)
  
  # Desired sticker resolution in pixels
  #sticker_width <- 121
  sticker_width <- 200
  
  # Scale all stickers to the desired pixel width
  stickers <- stickers %>%
    map(image_scale, sticker_width)
  
  # Identify low resolution stickers
  stickers %>%
    map_lgl(~ with(image_info(.x),
                   width < (sticker_width-1)/2 && format != "svg")
    )
  
  # Identify incorrect shapes / proportions (tolerance of +-2 height)
  stickers %>%
    map_lgl(~ with(image_info(.x),
                   height < (median(height)-2) | height > (median(height) + 2))
    )
  
  # Extract correct sticker height (this could also be calculated directly from width)
  sticker_height <- stickers %>%
    map(image_info) %>%
    map_dbl("height") %>%
    median
  
  # Coerce sticker dimensions
  stickers <- stickers %>%
    map(image_resize, paste0(sticker_width, "x", sticker_height, "!"))
  
  # Calculate row sizes
  sticker_col_size <- ceiling(length(stickers)/(sticker_row_size-0.5))
  row_lens <- rep(c(sticker_row_size,sticker_row_size-1), length.out=sticker_col_size)
  row_lens[length(row_lens)] <- row_lens[length(row_lens)]  - (length(stickers) - sum(row_lens))
  
  sticker_rows <- map2(row_lens, cumsum(row_lens),
                       ~ seq(.y-.x+1, by = 1, length.out = .x)) %>%
    map(~ stickers[.x] %>%
          invoke(c, .) %>%
          image_append)
  
  #canvas_color <- "white"
  bg_image <- image_blank(width = 1920, height = 1280, color = canvas_color)
  # if (!is.null(background_file)) {
  #   bg_path <- fs::path(hex_path, background_file)
  #   bg_image <- image_read(bg_path) %>%
  #     image_modulate(brightness = brightness,
  #                    saturation = saturation,
  #                    hue = hue) %>%
  #     image_blur(radius = radius, sigma = sigma)
  #   bg_image
  # } else {
  #   bg_image <- image_blank(width = 1920, height = 1280, color = bg_color)
  # }
  # 
  
  #bg_image
  
  # Add stickers to canvas
  #bg_color <- "aqua"
  
  #bg_color <- "none"
  
  canvas <- image_blank(width = sticker_row_size*sticker_width, 
                        height = sticker_height + (sticker_col_size-1)*sticker_height/1.33526,
                        color = "white")
  
  # accumulate2(sticker_rows, seq_along(sticker_rows),
  #             ~paste0("+", ((..3-1)%%2)*sticker_width/2,
  #                     "+", round((..3-1)*sticker_height/1.33526)),
  #             .init = bg_image)
  
  hex_panel <- reduce2(sticker_rows, seq_along(sticker_rows), 
                       ~image_composite(
                         image = ..1, 
                         composite_image = ..2,
                         offset = paste0("+", ((..3-1)%%2)*sticker_width/2,
                                         "+", round((..3-1)*sticker_height/1.33526))
                       ),
                       .init = canvas)
  
  # add to white blank image
  final_res <- image_composite(bg_image, 
                               image_scale(hex_panel, geometry_size_percent(width = hex_scale_pct_width, height = hex_scale_pct_height)), 
                               offset = geometry_point(hex_offset_vec[1], hex_offset_vec[2]))
  
  # if background image supplied, add that too
  if (!is.null(background_file)) {
    bg_path <- fs::path(background_path, background_file)
    bg_image2 <- image_read(bg_path) %>%
      image_resize("1920x1280")
      # image_modulate(brightness = brightness,
      #                saturation = saturation,
      #                hue = hue)
      # image_blur(radius = radius, sigma = sigma)
    #bg_image2
    
    
    # final_res <- image_composite(final_res, 
    #                              image_scale(bg_image2, geometry_size_percent(width = background_scale_pct_width, height = background_scale_pct_height)), 
    #                              offset = geometry_point(background_offset_vec[1], background_offset_vec[2]))
    # 
    # add to white blank image
    final_res <- image_composite(bg_image2, 
                                 image_scale(hex_panel, geometry_size_percent(width = hex_scale_pct_width, height = hex_scale_pct_height)), 
                                 offset = geometry_point(hex_offset_vec[1], hex_offset_vec[2]))
  } else {
    # add to white blank image
    final_res <- image_composite(bg_image, 
                                 image_scale(hex_panel, geometry_size_percent(width = hex_scale_pct_width, height = hex_scale_pct_height)), 
                                 offset = geometry_point(hex_offset_vec[1], hex_offset_vec[2]))
  }
  
  return(final_res)
}
