# LIST OF REQUIRED PACKAGES -----------------------------------------------

required_packages <- c(
  "checkpoint"
)

# install missing packages

new.packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

if (length(new.packages)) {
  install.packages(new.packages)
  devtools::install_github("Appsilon/shiny.collections")
  devtools::install_version("htmltools", version = "0.3.6", repos = "http://cran.us.r-project.org")
  devtools::install_github("ramnathv/htmlwidgets#351")
}

rm(new.packages)

library(checkpoint)
checkpoint(snapshot_date ="2021-07-01", checkpoint_location = "/Users/wmbio/")


# LIST OF REQUIRED PACKAGES -----------------------------------------------
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
library(survminer)
library(AMR)
library(plotly)
library(ggpubr)
library(viridis)
library(zoo)