# extract packages that import shiny and scrape all releases
# produces two tidy data sets

library(dplyr, warn.conflicts = FALSE)
library(purrr)
library(cranly)
library(rvest)
library(polite)
library(janitor)

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

shiny_pkg_list <- shiny_rev_imports

# subset package db with just these shiny-related packages
shiny_rev_db <- package_db %>%
  filter(package %in% shiny_pkg_list)

# see how RStudio is captured in author field
# shiny_rev_db %>%
#   filter(package == "shinydashboard") %>%
#   pull(author)

# create flag for whether RStudio is part of author or not
shiny_rev_db <- shiny_rev_db %>%
  mutate(rstudio_author = map_lgl(author, ~{
    "RStudio" %in% .x
  }))

# grab RStudio-authored package names related to Shiny in some way
#filter(shiny_rev_db, rstudio_author) %>% pull(package)

# prepare a meta dataframe for holding release information
shiny_rev_db <- shiny_rev_db %>%
  filter(!rstudio_author) %>%
  select(package, title, description, author, published)

# begin assembling URLs to scrape all release dates / versions of packages
cran_bow <- bow(
  url = 'https://cran.r-project.org/',
  user_agent = "Eric Nantz <https://r-podcast.org>",  # identify ourselves
  force = TRUE
)

scrape_pkg <- function(pkgname, 
                       bow = cran_bow, 
                       base_url = 'https://cran.r-project.org/src/contrib/Archive',
                       verbose = TRUE) {
  
  # 1. Agree modification of session path with host
  if (verbose) message(glue::glue("{time}: Beginning release scrape for {pkgname}....",
                                  time = Sys.time()))
  
  session <- nod(
    bow = bow,
    path = glue::glue("src/contrib/Archive/{pkgname}")   #paste0("r/", subreddit_name)
  )
  
  # 2. Scrape the page from the new path
  scraped_page <- scrape(session)
  
  # if the page does not exist, it means the package only had one release (the date in the cran db)
  if (is.null(scraped_page)) {
    stop("Package only has 1 release", call. = FALSE)
  }
  
  # 3. Extract from xpath on the altered URL
  node_result <- html_nodes(scraped_page, "table")
  
  # obtain table and perform cleaning
  df <- html_table(node_result[[1]], fill = TRUE) %>%
    clean_names() %>%
    remove_empty(c("rows", "cols")) %>%
    filter(name != "") %>%
    filter(name != "Parent Directory") %>%
    tibble::rownames_to_column(var = "release_number")
  
  # create summary with one row (first release date, number of releases)
  n_releases <- slice(df, n()) %>% pull(release_number) %>% as.integer(.)
  first_release_date <- slice(df, 1L) %>% pull(last_modified)
  last_release_date <- slice(df, n()) %>% pull(last_modified)
  
  res <- tibble::tibble(
    package = pkgname,
    n_releases = n_releases,
    first_release_date = first_release_date,
    last_release_date = last_release_date
  )
  
  return(res)
}

# run function with purrr
# note: this will take quite a bit of time!
safely_scrape_pkg <- purrr::safely(scrape_pkg)

full_res <- purrr::map(shiny_pkg_list, ~safely_scrape_pkg(.x))

saveRDS(full_res, file = "dev/full_res.rds")
saveRDS(shiny_rev_db, file = "dev/shiny_rev_db.rds")

# grab valid results
df_list <- purrr::transpose(full_res)
is_ok <- df_list$error %>% map_lgl(is_null)

# assemble as a dataframe
df <- flatten_df(full_res[is_ok])

# merge with shiny_rev_db 
shiny_rev_db <- shiny_rev_db %>%
  left_join(df, by = "package") %>%
  mutate(first_release_date = as.Date(first_release_date),
         last_release_date = as.Date(last_release_date)) %>%
  mutate(first_release_date = if_else(is.na(first_release_date), published, first_release_date)) %>%
  mutate(last_release_date = if_else(is.na(last_release_date), published, last_release_date)) %>%
  mutate(n_releases = if_else(is.na(n_releases), 1L, n_releases))

