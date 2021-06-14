# INSTALL DEPENDENCIES ----------------------------------------------------
source('dependencies.R')

# load all packages
lapply(required_packages, require, character.only = TRUE)

# SHINYMANAGER ----
lang <- shinymanager:::language$new()
lang$add(
  "Please authenticate" = "WMBIO MATERIAL PAGE"
)

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

# FLUID DESIGN FUNCTION ---------------------------------------------------

fluid_design <- function(id, w, x, y, z) {
  fluidRow(
    div(
      id = id,
      column(
        width = 6,
        uiOutput(w),
        uiOutput(y)
      ),
      column(
        width = 6,
        uiOutput(x),
        uiOutput(z)
      )
    )
  )
}

# Shiny run with global --------------------------------------------------
source("./ui.R", local = TRUE)  
source("./server.R", local = TRUE)  

shinyApp(ui, server, options = list(host = "0.0.0.0", port = "8888"))


