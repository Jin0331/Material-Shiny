library(tidyverse)
file_rename <- function(path){
  setwd(path)
  
    lapply(X = list.files(recursive = T), FUN = function(file_name){
      file_name_split <- file_name %>% strsplit(split = "\\.") %>% unlist()
      
      file_rename_var <- file_name_split[1] %>% 
        str_remove_all(pattern = "[[:punct:]]|[[:blank:]]") %>% 
        paste0(., ".", tolower(file_name_split[2]))
      
      file.rename(from = file_name, to = file_rename_var)
    })
}


file_rename(path = "../pdf_img/")
