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
checkpoint(snapshot_date ="2021-06-14", checkpoint_location = "/Users/wmbio/Google 드라이브/wmbio_data/wmbio_web/")


# LIST OF REQUIRED PACKAGES -----------------------------------------------
library(mongolite)
library(data.table)
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
library(survival)
library(survminer)
library(ggpubr)
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
library(shinyWidgets)
library(survival)
library(ggpubr)
library(survminer)
library(tidyverse)
library(viridis)
library(zoo)