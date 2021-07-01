library(RMariaDB)
library(tidyverse)

# function
create_user <- function(user_con = user_con, user, password, admin, role){
  
  if(length(dbListTables(user_con)) == 0){
    query <- "CREATE TABLE user(
                user VARCHAR(30) NOT NULL,
                password VARCHAR(30) NOT NULL,
                admin int NOT NULL,
                role VARCHAR(30) NOT NULL,
                primary key(user)
    );"
    dbExecute(user_con, query)
  }
  
  # duplicate check
  '%!in%' <- function(x,y)!('%in%'(x,y))
  user_df <- tbl(user_con, "user") %>% collect()
  
  if(user %!in% user_df$user){
    admin <- ifelse(admin == TRUE, 1, 0)
    
    user <- paste0("'", user, "'")
    password <- paste0("'", password, "'")
    role <- paste0("'", role, "'")
    
    query <- paste("INSERT INTO user VALUES(", user, ",", 
                   password, ",", 
                   admin, ",",
                   role,
                   ")")
    dbExecute(user_con, query)
  } else {
    stop('ID is duplicated!!') 
  }
  

}

## main
user_con <- DBI::dbConnect(drv = MariaDB(), host = "192.168.0.90", port = 3306, user = "root", password = "sempre813!",
                           dbname = "material_users")

create_user(user_con = user_con, 
            user = "wmbio",
            password = "sempre813!",
            admin = TRUE,
            role = "A")

