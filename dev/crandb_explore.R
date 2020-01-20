devtools::load_all()

library(tidyverse)
library(cranly)
library(cranlogs)
library(rvest)
library(polite)
p_db <- tools::CRAN_package_db()
package_db <- cranly::clean_CRAN_db(p_db)

# grab current "reverse-imports" of shiny
shiny_rev_imports <- package_db %>%
  filter(package == "shiny") %>%
  pull(reverse_imports) %>%
  .[[1]]

# grab current "reverse-suggests" of shiny
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

# begin assembling URLs to scrape all release dates / versions of packages
cran_bow <- bow(
  url = 'https://cran.r-project.org/',
  user_agent = "Eric Nantz <https://r-podcast.org>",  # identify ourselves
  force = TRUE
)

cran_bow

scrape_pkg <- function(pkgname, bow = cran_bow, base_url = 'https://cran.r-project.org/src/contrib/Archive') {
  
  # 1. Agree modification of session path with host
  session <- nod(
    bow = bow,
    path = glue::glue("src/contrib/Archive/{pkgname}")   #paste0("r/", subreddit_name)
  )
  
  # 2. Scrape the page from the new path
  scraped_page <- scrape(session)
  
  # 3. Extract from xpath on the altered URL
  node_result <- html_nodes(scraped_page, "table")
  
  return(node_result)
}

scrape_pkg("shiny")
