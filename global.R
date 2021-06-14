

# WELCOME TO RadaR

#RadaR is licensed under the GNU General Public License (GPL) v2.0 (https://github.com/ceefluz/radar/blob/master/LICENSE)

# INSTALL DEPENDENCIES ----------------------------------------------------

source('dependencies.R')
# load all packages
lapply(required_packages, require, character.only = TRUE)

# RELATED FUNCTION --------------------------------------------------------
collection_to_DF <- function(collection_name, url) {
  m <- mongo(collection = collection_name, 
             db = "material", 
             url = url,
             verbose = TRUE, 
             options = ssl_options())
  m$find() %>% as_tibble() %>% unnest(names_sep = "_") %>% return()
}
mongoUrl <- "mongodb://root:sempre813!@192.168.0.6:27017/admin"


# Shiny run with global --------------------------------------------------
source("./ui.R", local = TRUE)  
source("./server.R", local = TRUE)  

shinyApp(ui, server)


