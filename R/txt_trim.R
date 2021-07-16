# install.packages("readxl")
library(readxl)
library(tidyverse)

excel_to_trimTxt <- function(path, sheet_number){
  DF <- read_excel(path = path, sheet = sheet_number)
  rm_DF <- list()
  
  for(index in 1:ncol(DF)){
    print(index)
    col_name <- names(DF[index])
    remove_str <- DF[[index]] 
    
    remove_str <- lapply(X = remove_str, FUN = function(value){
      str_remove_all(string = value, pattern = "[\r\n]")
    }) %>% unlist() %>% as_tibble()
    names(remove_str) <- col_name
    
    rm_DF[[index]] <- remove_str
  }
  rm_DF %>% bind_cols() %>% return()
}

rm_DF <- excel_to_trimTxt(path = "/home/rstudio/material/WMBio-시약목록_CMC팀(2021년)_2021.06.30.xlsx",
                 sheet_number = 1)

rm_DF %>% bind_cols() %>% write_delim("/home/rstudio/material/cmc.txt", 
                                      delim = "\t",
                                      na = " ")
