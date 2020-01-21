library(tidyverse)
library(lubridate)
full_res <- readRDS("dev/full_res.rds")


# grab valid results
df_list <- purrr::transpose(full_res)
is_ok <- df_list$error %>% map_lgl(is_null)

# assemble as a dataframe
df <- full_res[is_ok] %>%
  flatten_df

# merge with shiny_rev_db 
shiny_rev_db <- readRDS("dev/shiny_rev_db.rds")

shiny_rev_db <- shiny_rev_db %>%
  left_join(df, by = "package") %>%
  mutate(first_release_date = as.Date(first_release_date),
         last_release_date = as.Date(last_release_date)) %>%
  mutate(first_release_date = if_else(is.na(first_release_date), published, first_release_date)) %>%
  mutate(last_release_date = if_else(is.na(last_release_date), published, last_release_date)) %>%
  mutate(n_releases = if_else(is.na(n_releases), 1L, n_releases))

# shiny release date: 2012-12-01

# question 1: number of shiny community packages with first release in each year
# since Shiny was released (2013-2019)

years_df <- shiny_rev_db %>%
  mutate(first_release_year = year(first_release_date)) %>%
  filter(between(first_release_year, 2013, 2019))

# plot to explore
ggplot(years_df, aes(x = first_release_year)) +
  geom_bar()

