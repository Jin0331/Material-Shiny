# INSTALL DEPENDENCIES ----------------------------------------------------
source('dependencies.R')

# SHINYMANAGER ----
set_labels(
  language = "en","Please authenticate" = "WMBIO MATERIAL PAGE")



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


# HELP & INTRO DATA ------------------------------------------------------
steps <- read_csv2("help.csv")
intro <- read_csv2("intro.csv")

# Shiny run with global --------------------------------------------------
source("./ui.R", local = TRUE)  
source("./server.R", local = TRUE)  

options(shiny.port = 8888)
options(shiny.host = "192.168.0.7")
shinyApp(ui, server)


