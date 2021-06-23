# LIST OF REQUIRED PACKAGES -----------------------------------------------

required_packages <- c(
  "checkpoint"
)

# install missing packages

new.packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

if (length(new.packages)) {
  install.packages(new.packages)
}

rm(new.packages)

library(checkpoint)
checkpoint(snapshot_date ="2021-06-21", checkpoint_location = "/Users/wmbio/")


# LIST OF REQUIRED PACKAGES -----------------------------------------------
library(jsonlite)
library(reactable)
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
library(shiny.collections)
library(survival)
library(survminer)
library(AMR)
library(plotly)
library(ggpubr)
library(viridis)
library(zoo)