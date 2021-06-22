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
### DT CallBack
## the callback
NestedData <- function(dat, children){
  stopifnot(length(children) == nrow(dat))
  g <- function(d){
    if(is.data.frame(d)){
      purrr::transpose(d)
    }else{
      purrr::transpose(NestedData(d[[1]], children = d$children))
    }
  }
  subdats <- lapply(children, g)
  oplus <- ifelse(lengths(subdats), "&oplus;", "") 
  cbind(" " = oplus, dat, "_details" = I(subdats), 
        stringsAsFactors = FALSE)
}

# df <- data.frame(
#   COUNTRY = c("USA","Japan","USA","France","Italy","Canada","Japan", "Korea"),
#   NAME = c("Mark","Hue","Mary","Jean","Laura","John","Zhan", "NA"),
#   AGE = c(20, 21, 18, 35, 40, 33, 27, NA),
#   DATE_OF_BIRTH = c("1980-05-01","1978-05-04","1983-11-01","1989-05-15","1985-08-08","1978-02-18","1983-09-27", NA)
# )
# 
# children <- lapply(split(df, df$COUNTRY), "[", -1)
# dat0 <- data.frame(COUNTRY = names(children))
# 
# Dat <- NestedData(dat = dat0, children = unname(children))

sample_list <- pdx$`Sample ID`
children_list <- list()
for(sample in sample_list){
  child_temp <- pdx_result %>% filter(`Sample ID` == sample)
  if(nrow(child_temp) == 0){
    children_list[[sample]] <- data.frame()
  } else {
    children_list[[sample]] <- child_temp %>% as.data.frame()
  }
}
Dat <- NestedData(dat = pdx, children = unname(children_list))

## whether to show row names
rowNames = FALSE
colIdx <- as.integer(rowNames)
## the callback
parentRows <- which(Dat[,1] != "")
callback <- JS(
  sprintf("var parentRows = [%s];", toString(parentRows-1)),
  sprintf("var j0 = %d;", colIdx),
  "var nrows = table.rows().count();",
  "for(let i = 0; i < nrows; ++i){",
  "  var $cell = table.cell(i,j0).nodes().to$();",
  "  if(parentRows.indexOf(i) > -1){",
  "    $cell.css({cursor: 'pointer'});",
  "  }else{",
  "    $cell.removeClass('details-control');",
  "  }",
  "}",
  "",
  "// --- make the table header of the nested table --- //",
  "var formatHeader = function(d, childId){",
  "  if(d !== null){",
  "    var html = ", 
  "      '<table class=\"display compact hover\" ' + ",
  "      'style=\"padding-left: 30px;\" id=\"' + childId + ", 
  "      '\"><thead><tr>';",
  "    var data = d[d.length-1] || d._details;",
  "    for(let key in data[0]){",
  "      html += '<th>' + key + '</th>';",
  "    }",
  "    html += '</tr></thead></table>'",
  "    return html;",
  "  } else {",
  "    return '';",
  "  }",
  "};",
  "",
  "// --- row callback to style rows of child tables --- //",
  "var rowCallback = function(row, dat, displayNum, index){",
  "  if($(row).hasClass('odd')){",
  "    $(row).css('background-color', 'papayawhip');",
  "    $(row).hover(function(){",
  "      $(this).css('background-color', '#E6FF99');",
  "    }, function(){",
  "      $(this).css('background-color', 'papayawhip');",
  "    });",
  "  } else {",
  "    $(row).css('background-color', 'lemonchiffon');",
  "    $(row).hover(function(){",
  "      $(this).css('background-color', '#DDFF75');",
  "    }, function(){",
  "      $(this).css('background-color', 'lemonchiffon');",
  "    });",
  "  }",
  "};",
  "",
  "// --- header callback to style header of child tables --- //",
  "var headerCallback = function(thead, data, start, end, display){",
  "  $('th', thead).css({",
  "    'border-top': '3px solid indigo',", 
  "    'color': 'indigo',",
  "    'background-color': '#fadadd'",
  "  });",
  "};",
  "",
  "// --- make the datatable --- //",
  "var formatDatatable = function(d, childId){",
  "  var data = d[d.length-1] || d._details;",
  "  var colNames = Object.keys(data[0]);",
  "  var columns = colNames.map(function(x){",
  "    return {data: x.replace(/\\./g, '\\\\\\.'), title: x};",
  "  });",
  "  var id = 'table#' + childId;",
  "  if(colNames.indexOf('_details') === -1){",
  "    var subtable = $(id).DataTable({",
  "      'data': data,",
  "      'columns': columns,",
  "      'autoWidth': true,",
  "      'deferRender': true,",
  "      'info': false,",
  "      'lengthChange': false,",
  "      'ordering': data.length > 1,",
  "      'order': [],",
  "      'paging': false,",
  "      'scrollX': false,",
  "      'scrollY': false,",
  "      'searching': false,",
  "      'sortClasses': false,",
  "      'rowCallback': rowCallback,",
  "      'headerCallback': headerCallback,",
  "      'columnDefs': [{targets: '_all', className: 'dt-center'}]",
  "    });",
  "  } else {",
  "    var subtable = $(id).DataTable({",
  "      'data': data,",
  "      'columns': columns,",
  "      'autoWidth': true,",
  "      'deferRender': true,",
  "      'info': false,",
  "      'lengthChange': false,",
  "      'ordering': data.length > 1,",
  "      'order': [],",
  "      'paging': false,",
  "      'scrollX': false,",
  "      'scrollY': false,",
  "      'searching': false,",
  "      'sortClasses': false,",
  "      'rowCallback': rowCallback,",
  "      'headerCallback': headerCallback,",
  "      'columnDefs': [", 
  "        {targets: -1, visible: false},", 
  "        {targets: 0, orderable: false, className: 'details-control'},", 
  "        {targets: '_all', className: 'dt-center'}",
  "      ]",
  "    }).column(0).nodes().to$().css({cursor: 'pointer'});",
  "  }",
  "};",
  "",
  "// --- display the child table on click --- //",
  "// array to store id's of already created child tables",
  "var children = [];", 
  "table.on('click', 'td.details-control', function(){",
  "  var tbl = $(this).closest('table'),",
  "      tblId = tbl.attr('id'),",
  "      td = $(this),",
  "      row = $(tbl).DataTable().row(td.closest('tr')),",
  "      rowIdx = row.index();",
  "  if(row.child.isShown()){",
  "    row.child.hide();",
  "    td.html('&oplus;');",
  "  } else {",
  "    var childId = tblId + '-child-' + rowIdx;",
  "    if(children.indexOf(childId) === -1){", 
  "      // this child has not been created yet",
  "      children.push(childId);",
  "      row.child(formatHeader(row.data(), childId)).show();",
  "      td.html('&CircleMinus;');",
  "      formatDatatable(row.data(), childId, rowIdx);",
  "    }else{",
  "      // this child has already been created",
  "      row.child(true);",
  "      td.html('&CircleMinus;');",
  "    }",
  "  }",
  "});")

render_DT <- function(DF_NAME){
  DT::renderDataTable(DF_NAME, rownames = FALSE, extensions = c('Buttons', "KeyTable"), escape = FALSE,
                      selection=list(mode="single", target="cell"),
                      options = list(iDisplayLength = 15, searchHighlight = TRUE,
                                     keys = TRUE,
                                     buttons = c("colvis",'copy', 'csv'),
                                     dom = "Bfrtip",
                                     scrollX = TRUE, autoWidth = T,
                                     columnDefs = list(
                                       list(className = 'dt-center', width = '90px', targets = "_all"))))
}
render_DT_child <- function(DF_NAME){
  DT::renderDataTable(DF_NAME, callback = callback, 
                      rownames = FALSE,
                      extensions = c('Buttons', "KeyTable"),
                      escape = -2,-colIdx-1,
                      selection=list(mode="single", target="cell"),
                      options = list(
                        iDisplayLength = 15, searchHighlight = TRUE,
                        keys = TRUE,
                        buttons = c("colvis",'copy', 'csv'),
                        dom = "Bfrtip",
                        scrollX = TRUE, autoWidth = T,
                        columnDefs = list(
                                       list(className = 'dt-center', width = '90px', targets = "_all"),
                                       list(visible = FALSE, targets = ncol(Dat)-1+colIdx),
                                       list(orderable = FALSE, className = 'details-control', targets = 1)
                                     )))
}


## MAKE DATAFRAME ----
## BLOOD colname and DF 
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
                        "New1", "New2", "New3", "New4", "New5")

blood <- collection_to_DF(collection_name = "blood_collection", url = mongoUrl);names(blood) <- blood_list_colname
blood <- blood %>% select(-WMB_NO, -Treatment_history_Treatment_History1_Responder,
                          -Treatment_history_Treatment_History1_Non_Responder,
                          -New1:-New5)

# PDX colname and Df
## LIST
pdx_list_colname <- c("WMB_NO", "Sample ID", "FF ID", "검체번호", "구입처(국내)", "구입처(해외)", "Ethnicity", 
                      "Tissue", "Disease", "입고형태", "인수자", "입고일자", "보관위치", "Tumor Grade", "Tumor Stage",
                      "기본정보(성별)", "기본정보(나이)", "기본정보(신장)", "기본정보(체중)", "Smoking정보(Status)", 
                      "Smoking정보(Cigarettes/Day)", "Smoking정보(Duration)","Alcohol정보(Status)", "Alcohol정보(Drinks/Day)", 
                      "Alcohol정보(Duration)", "Prior Treatment(Treatment History)", "Drug(Treatment History)", "Drug2",
                      "Histological Description(Diagnosis)", "mouse종류[주차/성별](실험동물)", "구입처(실험동물)",
                      "Chemoresistance status(Characterization)", "Mutation status(Characterization)", 
                      "RON Genotype(Characterization)", "IGSF1 Genotype(Characterization)", "P34 Genotype(Characterization)",
                      "New1","New2","New3","New4","New5","New6","New7", "New8"
                      )
pdx <- collection_to_DF(collection_name = "pdx_collection", url = mongoUrl);names(pdx) <- pdx_list_colname
pdx <- pdx %>% select(-WMB_NO, -Drug2, -New1:-New8)

## RESULT
pdx_result_colname <- c("WMB_NO", "Sample ID", "FF ID", "검체번호", "Tissue site", "Cancer", "Tumor Grade", "Tumor Stage",
                        "Treatment History", "Drug resistant", "이미지(실험관련)", "실험 조직(실험관련)", "Passage(실험관련)",
                        "Media(실험관련)", "이식시점[실험 No.](실험관련)", "투여시점(실험관련)", "이식->투여기간(실험관련)",
                        "특이사항(실험관련)", "실험내용(실험관련)", "실험결과(실험관련)", "수행자(실험관련)")
pdx_result <- collection_to_DF(collection_name = "pdx_result_collection", url = mongoUrl);names(pdx_result) <- pdx_result_colname
pdx_result <- pdx_result %>% select(-WMB_NO)


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


