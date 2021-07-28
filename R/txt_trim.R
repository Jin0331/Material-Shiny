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
      str_replace_all(string = value, pattern = "[\r\n]", replacement = " ")
    }) %>% unlist() %>% as_tibble()
    names(remove_str) <- col_name
    
    rm_DF[[index]] <- remove_str
  }
  rm_DF %>% bind_cols() %>% return()
}

rm_DF <- excel_to_trimTxt(path = "../../Desktop/210722_과제파이프라인회의_S1 Follow up_DD 연구소_PDX Model 정보(별첨자료)_이진우수정.xlsx",
                          sheet_number = 1) %>% lapply(X = ., FUN = function(value){
                            str_replace_all(string = value, pattern = "^\\-$", replacement = "")
                          }) %>% as_tibble()

rm_DF %>% bind_cols() %>% write_delim("pdx_champion.txt", 
                                      delim = "\t",
                                      col_names = F,
                                      na = " ")