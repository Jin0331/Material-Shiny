library(mongolite)
library(tidyverse)

mongoUrl <- "mongodb://root:sempre813!@192.168.0.6:27017/admin"

collection_fun <- function(collection_name, url) {
  m <- mongo(collection = collection_name, 
             db = "material", 
             url = url,
             verbose = TRUE, 
             options = ssl_options()
  )
}

temp <- collection_fun(collection_name = "blood_collection", url = mongoUrl)
temp_tibble <- temp$find() %>% as_tibble() %>% unnest(names_sep = "_")
