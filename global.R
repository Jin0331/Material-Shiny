# INSTALL DEPENDENCIES ----------------------------------------------------
source('dependencies.R')

# SHINYMANAGER ----
set_labels(
  language = "en","Please authenticate" = "WMBIO MATERIAL PAGE")

# RELATED FUNCTION --------------------------------------------------------
PDF_url <- "http://192.168.0.7:18080/PDF/"
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

# DT actionButton
shinyInput <- function(FUN, n, id, ...) {
  # for each of n, create a new input using the FUN function and convert
  # to a character
  vapply(seq_len(n), function(i){
    as.character(FUN(paste0(id, i), ...))
  }, character(1))
  
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
  DT::renderDataTable(DF_NAME, rownames = FALSE, extensions = c('Buttons', "KeyTable"), escape = FALSE,
                      selection=list(mode="single", target="cell"),
                      options = list(iDisplayLength = 15, searchHighlight = TRUE,
                                     keys = TRUE,
                                     buttons = c("colvis",'copy', 'csv'),
                                     dom = "Bfrtip",
                                     scrollX = TRUE, autoWidth = TRUE,
                                     columnDefs = list(list(
                                       className = 'dt-center',
                                       width = '170px', targets = "_all"))))
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

## antibody colname and DF
antibody_colname <- c("No", "WMB_NO", "Antibody", "Cat no.", "Lot no.", "Conc.", "Host", "Species Reactivity",
                      "Application", "사용 Titer", "Blocking Buffer", "단백질 크기(kDa)", "재고량 vial", "입고 날짜",
                      "보관 위치", "관리자(관리팀)", "제조사", "비고" )
antibody <- collection_to_DF(collection_name = "antibody_collection", url = mongoUrl);names(antibody) <- antibody_colname
antibody <- antibody %>% select(-WMB_NO, -No)

## celline colname and DF
celline_colname <- c("WMB_NO", "Cell line", "Tissue", "Organism", "Disease", "Picture", "Chemoresistance status",
                     "Mutation status", "RON Genotype", "IGSF1 Genotype", "P34 Genotype", "Media Condition",
                     "GROWTH PATTERN", "계대비율 및 주기", "구매처", "특이사항", "RON(RT-PCR)", "KRAS(RT)", "BRAF(RT-PCR)",
                     "EGFR(RT-PCR)", "RON(WB)", "BRAF(WB)", "EGFR(WB)", "New1","New2","New3","New4","New5","New6","New7",
                     "New8","New9","New10")
celline <- collection_to_DF(collection_name = "celline_collection", url = mongoUrl);names(celline) <- celline_colname
celline <- celline %>% select(-WMB_NO, -New1:-New10)

## drug colname and DF
drug_colname <- c("WMB_NO", "Name", "제조사", "용량", "Target", "Cat", "구입일",
                  "보관위치", "관리자", "비고", "Data sheet", "New1","New2", "New3", "New4", "New5", "New6")
drug <- collection_to_DF(collection_name = "drug_collection", url = mongoUrl);names(drug) <- drug_colname
drug <- drug %>% select(-WMB_NO, -New1:-New6)

## protein colname and DF
protein_colname <- c("과제명", "WMB_NO", "시약명", "회사명", "Cat no", "Lot no", "남은량", "위치", "Data sheet",
                     "New1","New2", "New3", "New4", "New5", "New6", "New7","New8", "New9", "New10")
protein <- collection_to_DF(collection_name = "protein_collection", url = mongoUrl);names(protein) <- protein_colname
protein <- protein %>% select(-WMB_NO, -New1:-New10)

## si/shRNA colname and DF
shsirna_colname <- c("과제명", "WMB_NO", "Name", "Target Gene", "Species", "Type", "농도", "Sequence", "제조사",
                     "Stock vial 입고일", "Stock vial 재고 수량", "Stock vial 보관 위치", "소분 vial 재고 수량",
                     "위치(냉동고/Box이름)", "관리자", "Data sheet", "여분1","여분2","여분3","여분4","여분5","여분6",
                     "여분7","여분8","여분9","여분10")
shsirna <- collection_to_DF(collection_name = "shsirna_collection", url = mongoUrl);names(shsirna) <- shsirna_colname
shsirna <- shsirna %>% select(-WMB_NO)

# Shiny run with global --------------------------------------------------
source("./ui.R", local = TRUE)  
source("./server.R", local = TRUE)  

options(shiny.port = 8888)
options(shiny.host = "192.168.0.7")
shinyApp(ui, server)


