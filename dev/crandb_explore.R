devtools::load_all()

library(tidyverse)
library(cranly)
library(cranlogs)
p_db <- tools::CRAN_package_db()
package_db <- cranly::clean_CRAN_db(p_db)

# grab current "reverse-imports" of shiny
shiny_rev_imports <- package_db %>%
  filter(package == "shiny") %>%
  pull(reverse_imports) %>%
  .[[1]]


shiny_rev_suggests <- package_db %>%
  filter(package == "shiny") %>%
  pull(reverse_suggests) %>%
  .[[1]]



# subset package db with just these shiny-related packages
shiny_rev_db <- package_db %>%
  filter(package %in% c(shiny_rev_imports, shiny_rev_suggests))

# see how RStudio is captured in author field
shiny_rev_db %>%
  filter(package == "shinydashboard") %>%
  pull(author)

# create flag for whether RStudio is part of author or not
shiny_rev_db <- shiny_rev_db %>%
  mutate(rstudio_author = map_lgl(author, ~{
    "RStudio" %in% .x
  }))

# grab RStudio-authored package names related to Shiny in some way
filter(shiny_rev_db, rstudio_author) %>% pull(package)
