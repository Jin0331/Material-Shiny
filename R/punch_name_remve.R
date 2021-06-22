library(tidyverse)

setwd("~/Desktop/gitworking/Material-Shiny/www/IMG/")
# setwd("~/Desktop/gitworking/Material-Shiny/www/PDF/")

lapply(X = list.files(recursive = T), FUN = function(file_name){
  file_name_split <- file_name %>% strsplit(split = "\\.") %>% unlist()
  
  file_rename_var <- file_name_split[1] %>% 
    str_remove_all(pattern = "[[:punct:]]|[[:blank:]]") %>% 
    paste0(., ".", file_pdf_split[2])
  
  file.rename(from = file_name, to = file_rename_var)
})


  
