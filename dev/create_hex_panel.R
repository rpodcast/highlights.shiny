# arrange hex stickers in a new pattern
# source: https://www.mitchelloharawild.com/blog/hexwall/
library(magick)
library(purrr)
library(dplyr)

sticker_files <- fs::dir_ls("inst/app/www/img", glob = "*.png")

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

#stickers[["bs4Dash.png"]]

sticker_row_size <- 5
# Calculate row sizes
sticker_col_size <- ceiling(length(stickers)/(sticker_row_size-0.5))
row_lens <- rep(c(sticker_row_size,sticker_row_size-1), length.out=sticker_col_size)
row_lens[length(row_lens)] <- row_lens[length(row_lens)]  - (length(stickers) - sum(row_lens))

sticker_rows <- map2(row_lens, cumsum(row_lens),
                     ~ seq(.y-.x+1, by = 1, length.out = .x)) %>%
  map(~ stickers[.x] %>%
        invoke(c, .) %>%
        image_append)

#sticker_rows[[1]]



brightness <- 250
saturation <- 140
hue <- 100

bg_image <- image_read("inst/app/www/img/blueprint.jpg") %>%
  image_modulate(brightness = brightness,
                 saturation = saturation,
                 hue = hue) %>%
  image_blur(radius = 10, sigma = 5)

bg_image

# Add stickers to canvas
bg_color <- "aqua"
bg_color <- "white"

canvas <- image_blank(width = sticker_row_size*sticker_width, 
                      height = sticker_height + (sticker_col_size-1)*sticker_height/1.33526,
                      color = bg_color)

accumulate2(sticker_rows, seq_along(sticker_rows),
        ~paste0("+", ((..3-1)%%2)*sticker_width/2,
                "+", round((..3-1)*sticker_height/1.33526)),
        .init = bg_image)

hex_panel <- reduce2(sticker_rows, seq_along(sticker_rows), 
        ~image_composite(
          image = ..1, 
          composite_image = ..2,
          offset = paste0("+", ((..3-1)%%2)*sticker_width/2,
                          "+", round((..3-1)*sticker_height/1.33526))
        ),
        .init = bg_image)

hex_panel2 <- accumulate2(sticker_rows, seq_along(sticker_rows), 
                     ~image_composite(
                       image = ..1, 
                       composite_image = ..2,
                       offset = paste0("+", ((..3-1)%%2)*sticker_width/2,
                                       "+", round((..3-1)*sticker_height/1.33526))
                     ),
                     .init = bg_image)

# was .init = canvas
hex_panel2[[6]]
hex_panel

image_write(hex_panel, path = "inst/app/www/source_img/hex_panel.png", format = "png")

# use https://www4.lunapic.com/editor/ to remove the white portions of the background 
# and re-export
