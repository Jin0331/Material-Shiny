# LIST OF REQUIRED PACKAGES -----------------------------------------------

required_packages <- c()

# install missing packages

new.packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

if (length(new.packages)) {
  install.packages(new.packages)
}

rm(new.packages)

library(checkpoint)
checkpoint(snapshotDate ='2020-06-14', checkpointLocation = "/Users/wmbio/Desktop/gitworking/Material-Shiny/")

library(mongolite)
library(AMR)
library(data.table)
library(DT)
library(ggridges)
library(lubridate)
library(plotly)
library(qicharts2)
library(rintrojs)
library(shiny)
library(shinyBS)
library(shinycssloaders)
library(shinydashboard)
library(shinyjs)
library(shinymanager)
library(shinythemes)
library(shinyWidgets)
library(survival)
library(ggpubr)
library(survminer)
library(tidyverse)
library(viridis)
library(zoo)