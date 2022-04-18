# LIST OF REQUIRED PACKAGES -----------------------------------------------

# required_packages <- c(
#   "checkpoint"
# )

# install missing packages

# new.packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
# 
# if (length(new.packages)) {
#   install.packages(new.packages)
#   devtools::install_github("Appsilon/shiny.collections", force = T)
#   devtools::install_version("htmltools", repos = "http://cran.us.r-project.org", force = T)
#   devtools::install_github("ramnathv/htmlwidgets", force = T)
# }
# 
# rm(new.packages)

# NOT USING checkpoint
# library(checkpoint)
# checkpoint(snapshot_date ="2021-07-19", checkpoint_location = "/home/rstudio/checkpoint/")


# LIST OF REQUIRED PACKAGES -----------------------------------------------
# library(keyring)
library(RMariaDB)
library(jsonlite)
library(devtools)
library(mongolite)
library(data.table)
library(purrrlyr)
library(DT)
library(ggridges)
library(lubridate)
library(qicharts2)
library(rintrojs)
library(tidyverse)
library(shiny)
library(shinyBS)
library(shinyjs)
library(shinyalert)
library(shinymanager)
library(shinyWidgets)
library(shinycssloaders)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)
library(shinycustomloader)
library(shinythemes)
library(dashboardthemes)
devtools::install_github("Appsilon/shiny.collections")
library(shiny.collections)
library(survival)
# library(survminer)
library(AMR)
library(plotly)
# library(ggpubr)
library(viridis)
library(zoo)

