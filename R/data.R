#' Summary data of shiny-related packages on CRAN
#'
#' A dataset containing metadata for packages on CRAN that import `shiny` 
#' but are not authored by RStudio.
#'
#' @format A data frame with the following columns:
#' * `package`: name of package
#' * `title`: Package title
#' * `description`: Package description
#' * `author`: List column of the package author(s)
#' * `published`: Date for when package was last published to CRAN
#' * `n_releases`: Number of releases on CRAN
#' * `first_release_date`: Date when package was first published to CRAN
#' * `last_release_date`: Date when package was last published to CRAN
#' 
#' @note see `data-raw/shiny_rev_db.R` script for how this was generated
"shiny_rev_db"
