# INSTALL DEPENDENCIES ----------------------------------------------------
source('dependencies.R')

# SHINYMANAGER ----
set_labels(
  language = "en","Please authenticate" = "WMBIO MATERIAL PAGE")

# RELATED FUNCTION --------------------------------------------------------
mongoUrl <- "mongodb://root:sempre813!@192.168.0.6:27017/admin"
collection_to_DF <- function(collection_name, url) {
  m <- mongo(collection = collection_name, 
             db = "material", 
             url = url,
             verbose = TRUE, 
             options = ssl_options())
  m$find() %>% as_tibble() %>% unnest(names_sep = "_") %>% return()
}

collection_cnt <- function(collection_name, url) {
  m <- mongo(collection = collection_name, 
             db = "material", 
             url = url,
             verbose = TRUE, 
             options = ssl_options())
  m$count() %>% return()
}

value_func <<- function(N, tab_name,row_count, icon, color){
  renderInfoBox({
    infoBox(tags$p(N, style = paste0("font-size: 145%; font-weight: bold; color:", color,";")),
      a(tags$p(row_count, style = "font-size: 120%;color: black;"), onclick = paste0("openTab('",tab_name,"')"), href = "#"),
        icon = icon, color = color)
  })
}

# chat db & function 
connection <- shiny.collections::connect()
get_random_username <- function() {
  paste0("User", round(runif(1, 10000, 99999)))
}
render_msg_divs <- function(collection) {
  div(class = "ui very relaxed list",
      collection %>%
        arrange(time) %>%
        by_row(~ div(class = "item",
                     a(class = "header", .$user),
                     div(class = "description", .$text)
        )) %>% {.$.out}
  )
}

render_msg_divs <- function(collection) {
  div(class = "ui very relaxed list",
      collection %>%
        arrange(time) %>%
        by_row(~ div(class = "item",
                     a(class = "header", .$user),
                     div(class = "description", .$text)
        )) %>% {.$.out}
  )
}

# DT COLUMN NAMES
## DT TABLE FUNCTION
render_DT <- function(DF_NAME){
  DT::renderDataTable(DF_NAME, rownames = FALSE,
                      options = list(iDisplayLength = 15, searchHighlight = TRUE,
                                     scrollX = TRUE, autoWidth = TRUE,
                                     columnDefs = list(list(width = '170px', 
                                                            targets = "_all"))))
}

## blood colname and DF
blood_list_colname <- c("WMB_NO", "Sample ID", "FF ID", "검체번호", "구입처(국내)", "구입처(해외)",
                        "Ethnicity", "암종", "입고형태", "인수자", "입고일자", "보관위치", "Cancer",
                        "Tumor Grade", "Tumor Stage", "기본정보(성별)", "기본정보(나이)", "기본정보(신장)",
                        "기본정보(체중)", "Smoking정보(Status)", "Smoking정보(Cigarettes/Day)", "Smoking정보(Duration)",
                        "Alcohol정보(Status)", "Alcohol정보(Drinks/Day)", "Alcohol정보(Duration)", "Prior Treatment",
                        "Erbitux(Responder)", "Erbitux(Non-Responder)", "Treatment_history_Treatment_History1_Responder",
                        "Treatment_history_Treatment_History1_Non_Responder", "Single cell 분리날짜(날짜)", 
                        "Single cell 분리날짜(수행자)", "Cell population(정보)", "Cell population(수행자)",
                        "Cytokine profile(정보)", "Cytokine profile(수행자)","In vitro-coculture with(정보)", 
                        "In vitro-coculture with(수행자)", "Tested drug(정보)", "Tested drug(수행자)", "환자정보",
                        "Blood1", "Blood2", "Blood3", "Blood4", "Blood5")

blood <- collection_to_DF(collection_name = "blood_collection", url = mongoUrl);names(blood) <- blood_list_colname
blood <- blood %>% select(-WMB_NO, -Treatment_history_Treatment_History1_Responder,
                          -Treatment_history_Treatment_History1_Non_Responder,
                          -Blood1, -Blood2, -Blood3, -Blood4, -Blood5)

## antibody colnam and DF
antibody_colname <- c("No", "WMB_NO", "Antibody", "Cat no.", "Lot no.", "Conc.", "Host", "Species Reactivity",
                      "Application", "사용 Titer", "Blocking Buffer", "단백질 크기(kDa)", "재고량 vial", "입고 날짜",
                      "보관 위치", "관리자(관리팀)", "제조사", "비고" )
antibody <- collection_to_DF(collection_name = "antibody_collection", url = mongoUrl);names(antibody) <- antibody_colname
antibody <- antibody %>% select(-WMB_NO, -No)



# Shiny run with global --------------------------------------------------
source("./ui.R", local = TRUE)  
source("./server.R", local = TRUE)  

options(shiny.port = 8888)
options(shiny.host = "192.168.0.7")
shinyApp(ui, server)


