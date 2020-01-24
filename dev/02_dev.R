# Building a Prod-Ready, Robust Shiny Application.
# 
# Each step is optional. 
# 

# 2. All along your project

## 2.1 Add modules
## 
golem::add_module( name = "welcome" ) # used for title page
golem::add_module( name = "shiny_intro" ) # intro & background

## 2.2 Add dependencies
usethis::use_dev_package("fullPage")
usethis::use_package("cranly", type = "Suggests")
usethis::use_package("cranlogs", type = "Suggests")
usethis::use_package("rvest", type = "Suggests")
usethis::use_package("polite", type = "Suggests")
usethis::use_package("janitor", type = "Suggests")
usethis::use_package("magick")
usethis::use_package("purrr")
usethis::use_package("dplyr")
usethis::use_package("rlang")
usethis::use_package("fs")
usethis::use_package("ggplot2")
usethis::use_package("lubridate")
usethis::use_package("waiter")
usethis::use_pipe()

## 2.3 Add tests

usethis::use_test( "app" )

## 2.4 Add a browser button

golem::browser_button()

## 2.5 Add external files

golem::add_js_file( "script" )
golem::add_js_handler( "handlers" )
golem::add_css_file( "custom" )

# 3. Documentation

## 3.1 Vignette
usethis::use_vignette("highlights.shiny")
devtools::build_vignettes()

## 3.2 Code coverage
## You'll need GitHub there
usethis::use_github()
usethis::use_travis()
usethis::use_appveyor()

# You're now set! 
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
