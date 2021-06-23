# INSTALL DEPENDENCIES ----------------------------------------------------
source('dependencies.R')
# CUSTOM THEME ----
### creating custom theme object
customTheme <- shinyDashboardThemeDIY(
  
  ### general
  appFontFamily = "Arial"
  ,appFontColor = "rgb(0,0,0)"
  ,primaryFontColor = "rgb(0,0,0)"
  ,infoFontColor = "rgb(0,0,0)"
  ,successFontColor = "rgb(0,0,0)"
  ,warningFontColor = "rgb(0,0,0)"
  ,dangerFontColor = "rgb(0,0,0)"
  ,bodyBackColor = "rgb(248,248,248)"
  
  ### header
  ,logoBackColor = "rgb(23,103,124)"
  
  ,headerButtonBackColor = "rgb(238,238,238)"
  ,headerButtonIconColor = "rgb(75,75,75)"
  ,headerButtonBackColorHover = "rgb(210,210,210)"
  ,headerButtonIconColorHover = "rgb(0,0,0)"
  
  ,headerBackColor = "rgb(238,238,238)"
  ,headerBoxShadowColor = "#aaaaaa"
  ,headerBoxShadowSize = "2px 2px 2px"
  
  ### sidebar
  ,sidebarBackColor = cssGradientThreeColors(
    direction = "down"
    ,colorStart = "rgb(20,97,117)"
    ,colorMiddle = "rgb(56,161,187)"
    ,colorEnd = "rgb(3,22,56)"
    ,colorStartPos = 0
    ,colorMiddlePos = 50
    ,colorEndPos = 100
  )
  ,sidebarPadding = 0
  
  ,sidebarMenuBackColor = "transparent"
  ,sidebarMenuPadding = 0
  ,sidebarMenuBorderRadius = 0
  
  ,sidebarShadowRadius = "3px 5px 5px"
  ,sidebarShadowColor = "#aaaaaa"
  
  ,sidebarUserTextColor = "rgb(255,255,255)"
  
  ,sidebarSearchBackColor = "rgb(55,72,80)"
  ,sidebarSearchIconColor = "rgb(153,153,153)"
  ,sidebarSearchBorderColor = "rgb(55,72,80)"
  
  ,sidebarTabTextColor = "rgb(255,255,255)"
  ,sidebarTabTextSize = 13
  ,sidebarTabBorderStyle = "none none solid none"
  ,sidebarTabBorderColor = "rgb(35,106,135)"
  ,sidebarTabBorderWidth = 1
  
  ,sidebarTabBackColorSelected = cssGradientThreeColors(
    direction = "right"
    ,colorStart = "rgba(44,222,235,1)"
    ,colorMiddle = "rgba(44,222,235,1)"
    ,colorEnd = "rgba(0,255,213,1)"
    ,colorStartPos = 0
    ,colorMiddlePos = 30
    ,colorEndPos = 100
  )
  ,sidebarTabTextColorSelected = "rgb(0,0,0)"
  ,sidebarTabRadiusSelected = "0px 20px 20px 0px"
  
  ,sidebarTabBackColorHover = cssGradientThreeColors(
    direction = "right"
    ,colorStart = "rgba(44,222,235,1)"
    ,colorMiddle = "rgba(44,222,235,1)"
    ,colorEnd = "rgba(0,255,213,1)"
    ,colorStartPos = 0
    ,colorMiddlePos = 30
    ,colorEndPos = 100
  )
  ,sidebarTabTextColorHover = "rgb(50,50,50)"
  ,sidebarTabBorderStyleHover = "none none solid none"
  ,sidebarTabBorderColorHover = "rgb(75,126,151)"
  ,sidebarTabBorderWidthHover = 1
  ,sidebarTabRadiusHover = "0px 20px 20px 0px"
  
  ### boxes
  ,boxBackColor = "rgb(255,255,255)"
  ,boxBorderRadius = 5
  ,boxShadowSize = "0px 1px 1px"
  ,boxShadowColor = "rgba(0,0,0,.1)"
  ,boxTitleSize = 16
  ,boxDefaultColor = "rgb(210,214,220)"
  ,boxPrimaryColor = "rgba(44,222,235,1)"
  ,boxInfoColor = "rgb(210,214,220)"
  ,boxSuccessColor = "rgba(0,255,213,1)"
  ,boxWarningColor = "rgb(244,156,104)"
  ,boxDangerColor = "rgb(255,88,55)"
  
  ,tabBoxTabColor = "rgb(255,255,255)"
  ,tabBoxTabTextSize = 14
  ,tabBoxTabTextColor = "rgb(0,0,0)"
  ,tabBoxTabTextColorSelected = "rgb(0,0,0)"
  ,tabBoxBackColor = "rgb(255,255,255)"
  ,tabBoxHighlightColor = "rgba(44,222,235,1)"
  ,tabBoxBorderRadius = 5
  
  ### inputs
  ,buttonBackColor = "rgb(245,245,245)"
  ,buttonTextColor = "rgb(0,0,0)"
  ,buttonBorderColor = "rgb(200,200,200)"
  ,buttonBorderRadius = 5
  
  ,buttonBackColorHover = "rgb(235,235,235)"
  ,buttonTextColorHover = "rgb(100,100,100)"
  ,buttonBorderColorHover = "rgb(200,200,200)"
  
  ,textboxBackColor = "rgb(255,255,255)"
  ,textboxBorderColor = "rgb(200,200,200)"
  ,textboxBorderRadius = 5
  ,textboxBackColorSelect = "rgb(245,245,245)"
  ,textboxBorderColorSelect = "rgb(200,200,200)"
  
  ### tables
  ,tableBackColor = "rgb(255,255,255)"
  ,tableBorderColor = "rgb(240,240,240)"
  ,tableBorderTopSize = 1
  ,tableBorderRowSize = 1
  
)
# SHINYMANAGER ----
set_labels(
  language = "en","Please authenticate" = "WMBIO MATERIAL PAGE")

# RELATED FUNCTION --------------------------------------------------------
fileUrl <- "http://192.168.0.7:18080/"
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

# DT TABLE FUNCTION ----
### DT CallBack 
## the callback
rowNames <<- FALSE
child_function <- function(list_df, result_df){
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
  sample_list <- list_df$`Sample ID`
  return_list <- list()
  rowNames = FALSE
  
  children_list <- list()
  for(sample in sample_list){
    child_temp <- pdx_result %>% filter(`Sample ID` == sample)
    if(nrow(child_temp) == 0){
      children_list[[sample]] <- data.frame()
    } else {
      children_list[[sample]] <- child_temp %>% as.data.frame()
    }
  }
  Dat <- NestedData(dat = list_df, children = unname(children_list))
  colIdx <- as.integer(rowNames)
  parentRows <- which(Dat[,1] != "")
  
  return_list[[1]] <- Dat
  return_list[[2]] <- parentRows
  return_list[[3]] <- colIdx
  
  return(return_list)
}
callback_function_1 <- function(parentRows, colIdx){
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
    "    $(row).css('background-color', 'white');",
    "    $(row).hover(function(){",
    "      $(this).css('background-color', '#E6FF99');",
    "    }, function(){",
    "      $(this).css('background-color', 'white');",
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
    "// --- make the datatable --- //",  # <----- image popup
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
    "      'select': {style: 'single'},",
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
    "      'select': {style: 'single'},",
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
  return(callback)
}

## the callback_2
registerInputHandler("x.child", function(x, ...) {
  jsonlite::fromJSON(jsonlite::toJSON(x, auto_unbox = TRUE, null = "null"), simplifyDataFrame = FALSE)
}, force = TRUE)
callback_function_2 <- function(){
  callback = JS(
    "var expandColumn = table.column(0).data()[0] === '&oplus;' ? 0 : 1;",
    "table.column(expandColumn).nodes().to$().css({cursor: 'pointer'});",
    "",
    "// send selected columns to Shiny",
    "var tbl = table.table().node();",
    "var tblId = $(tbl).closest('.datatables').attr('id');",
    "table.on('click', 'td:not(:nth-child(' + (expandColumn+1) + '))', function(){",
    "  setTimeout(function(){",
    "    var indexes = table.rows({selected:true}).indexes();",
    "    var indices = Array(indexes.length);",
    "    for(var i = 0; i < indices.length; ++i){",
    "      indices[i] = indexes[i];",
    "    }",
    "    Shiny.setInputValue(tblId + '_rows_selected', indices);",
    "  },0);",
    "});",
    "",
    "// Format the nested table into another table",
    "var format = function(d, childId){",
    "  if (d != null) {",
    "    var html = ", 
    "      '<table class=\"display compact\" id=\"' + childId + '\"><thead><tr>';",
    "    for (var key in d[d.length-1][0]) {",
    "      html += '<th>' + key + '</th>';",
    "    }",
    "    html += '</tr></thead></table>'",
    "    return html;",
    "  } else {",
    "    return '';",
    "  }",
    "};",
    "var rowCallback = function(row, dat, displayNum, index){",
    "  if($(row).hasClass('odd')){",
    "    for(var j=0; j<dat.length; j++){",
    "      $('td:eq('+j+')', row).css('background-color', 'white');",
    "    }",
    "  } else {",
    "    for(var j=0; j<dat.length; j++){",
    "      $('td:eq('+j+')', row).css('background-color', 'lemonchiffon');",
    "    }",
    "  }",
    "};",
    "var headerCallback = function(thead, data, start, end, display){",
    "  $('th', thead).css({",
    "    'border-top': '3px solid indigo',", 
    "    'color': 'indigo',",
    "    'background-color': '#cecece'",
    "  });",
    "};",
    "var format_datatable = function(d, childId){",
    "  var dataset = [];",
    "  var n = d.length - 1;",
    "  for (var i = 0; i < d[n].length; i++) {",
    "    var datarow = $.map(d[n][i], function(value, index){",
    "      return [value];",
    "    });",
    "    dataset.push(datarow);",
    "  }",
    "  var id = 'table#' + childId;",
    "  var subtable = $(id).DataTable({",
    "                   'data': dataset,",
    "                   'autoWidth': true,",
    "                   'deferRender': true,",
    "                   'info': false,",
    "                   'lengthChange': false,",
    "                   'ordering': d[n].length > 1,",
    "                   'paging': false,",
    "                   'scrollX': false,",
    "                   'scrollY': false,",
    "                   'searching': false,",
    "                   'sortClasses': false,",
    "                   'rowCallback': rowCallback,",
    "                   'headerCallback': headerCallback,",
    "                   'select': true,",
    "                   'columnDefs': [{targets: '_all', className: 'dt-center'}]",
    "                 });",
    "};",
    "",
    "var nrows = table.rows().count();",
    "var nullinfo = Array(nrows);",
    "for(var i = 0; i < nrows; ++i){",
    "  nullinfo[i] = {child : 'child-'+i, selected: null};",
    "}",
    "Shiny.setInputValue(tblId + '_children:x.child', nullinfo);",
    "var sendToR = function(){",
    "  var info = [];",
    "  setTimeout(function(){",
    "    for(var i = 0; i < nrows; ++i){",
    "      var childId = 'child-' + i;",
    "      var childtbl = $('#'+childId).DataTable();",
    "      var indexes = childtbl.rows({selected:true}).indexes();",
    "      var indices;",
    "      if(indexes.length > 0){",
    "        indices = Array(indexes.length);",
    "        for(var j = 0; j < indices.length; ++j){",
    "          indices[j] = indexes[j];",
    "        }",
    "      } else {",
    "        indices = null;",
    "      }",
    "      info.push({child: childId, selected: indices});",
    "    }",
    "    Shiny.setInputValue(tblId + '_children:x.child', info);",
    "  }, 0);",
    "}",
    "$('body').on('click', '[id^=child-] td', sendToR);",
    "",
    "table.on('click', 'td.details-control', function () {",
    "  var td = $(this),",
    "      row = table.row(td.closest('tr'));",
    "  if (row.child.isShown()) {",
    "    row.child.hide();",
    "    td.html('&oplus;');",
    "    sendToR();",
    "  } else {",
    "    var childId = 'child-' + row.index();",
    "    row.child(format(row.data(), childId)).show();",
    "    row.child.show();",
    "    td.html('&CircleMinus;');",
    "    format_datatable(row.data(), childId);",
    "  }",
    "});")
  return(callback)
}

## the callback_3
callback_function_3 <- function(){
  callback = JS(  "table.column(1).nodes().to$().css({cursor: 'pointer'});",
                  "var format = function (d) {",
                  "    var result = '<div><table style=\"background-color:#fadadd\">';", 
                  "    for(var key in d[d.length-1]){",
                  "      result += '<tr style=\"background-color:#fadadd\"><td><b>' + key +", 
                  "                '</b>:</td><td>' + d[4][key] + '</td></tr>';",
                  "    }",
                  "    result += '</table></div>';",
                  "    return result;",
                  "}",
                  "table.on('click', 'td.details-control', function(){",
                  "  var td = $(this),",
                  "      row = table.row(td.closest('tr'));",
                  "  if (row.child.isShown()) {",
                  "    row.child.hide();",
                  "    td.html('&oplus;');",
                  "  } else {",
                  "    row.child(format(row.data())).show();",
                  "    td.html('&CircleMinus;');",
                  "  }",
                  "});")
  
  return(callback)
}

render_DT_child <- function(DF_NAME){
  DT::renderDataTable(
    datatable(
      DF_NAME[[1]], 
      # callback = callback_function_1(DF_NAME[[2]], DF_NAME[[3]]), 
      callback = callback_function_2(),
      # callback = callback_function_3(),
      rownames = rowNames, escape = -DF_NAME[[3]]-1,
      selection=list(mode="single", target="cell"),
      options = list(
        fixedColumns = TRUE,
        paging = TRUE,
        searching = TRUE,
        iDisplayLength = 15, 
        scrollX = TRUE,
        scrollY = TRUE,
        dom = "frtip",
        autoWidth = TRUE,
        columnDefs = list(
          list(visible = FALSE, 
               targets = ncol(DF_NAME[[1]])-1+DF_NAME[[3]]),
          list(
            orderable = FALSE, 
            className = "details-control", 
            targets = DF_NAME[[3]]),
          list(
            className = "dt-center", 
            width = '100px',
            targets = "_all"
          )))))
}
render_DT <- function(DF_NAME){
  DT::renderDataTable(DF_NAME, rownames = FALSE, extensions = c('Buttons', "KeyTable", "FixedHeader","FixedColumns", "Scroller"), 
                      escape = FALSE,
                      selection=list(mode="single", target="cell"),
                      options = list(iDisplayLength = 25, searchHighlight = TRUE,
                                     keys = TRUE,
                                     fixedColumns = list(leftColumns = 1),
                                     fixedHeader = TRUE,
                                     buttons = c("colvis",'copy', 'csv'),
                                     dom = "Bfrtip",
                                     scrollX = TRUE, 
                                     deferRender = TRUE,
                                     scrollY = 700,
                                     scroller = TRUE,
                                     autoWidth = T,
                                     columnDefs = list(
                                       list(width = '250px', targets = "_all")
                                       )
                                     )
                      )
}

render_DT_rowgroup <- function(DF_NAME){
  DT::renderDataTable(DF_NAME, rownames = FALSE, extensions = c('Buttons', "KeyTable", "RowGroup", "FixedHeader", "Scroller"), 
                      escape = FALSE,
                      selection=list(mode="single", target="cell"),
                      options = list(iDisplayLength = 25, searchHighlight = TRUE,
                                     keys = TRUE,
                                     fixedHeader = TRUE,
                                     rowGroup = list(dataSrc = 0),
                                     buttons = c("colvis",'copy', 'csv'),
                                     dom = "Bfrtip",
                                     scrollX = TRUE,   
                                     deferRender = TRUE,
                                     scrollY = 700,
                                     scroller = TRUE,
                                     autoWidth = T,
                                     columnDefs = list(
                                       list(width = '250px', targets = "_all")
                                     )
                      )
  )
}


# MAIN DATAFRAME ----
# BLOOD colname and DF 
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
pdx_result <- pdx_result %>% 
  select(-WMB_NO) %>% 
  mutate(`이미지(실험관련)`  = ifelse(`이미지(실험관련)`  == "" | `이미지(실험관련)`  == "-", 
                               `이미지(실험관련)` ,
                               paste0("<a href='", fileUrl, "IMG/pdx/", 
                                      str_remove_all(`이미지(실험관련)` ,pattern = "[[:punct:]]|[[:blank:]]|[.jpg]"), ".JPG'>", "View</a>")))


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
drug <- drug %>% 
  select(-WMB_NO, -New1:-New6) %>% 
  mutate(`Data sheet` = ifelse(str_detect(`Data sheet`, "_PDF"), 
                               str_remove(`Data sheet`, pattern = "_PDF"), `Data sheet`)) %>% 
  mutate(`Data sheet` = ifelse(str_detect(`Data sheet`, pattern = ".html"),
                               paste0("<a href='",`Data sheet`,"'>", "LINK</a>"), 
                               paste0("<a href='", fileUrl, "PDF/drug/",
                                      str_remove_all(`Data sheet`,pattern = "[[:punct:]]|[[:blank:]]"),
                                      ".pdf'>", "PDF</a>")))
                               # paste0('<a href="#" onclick="window.open("', fileUrl, "PDF/drug/",
                               #        str_remove_all(`Data sheet`,pattern = "[[:punct:]]|[[:blank:]]"), ".pdf'" , "'_blank'",
                               #        "'fullscreen=yes');", ' return false;"', "PDF</a")))

## protein colname and DF
protein_colname <- c("과제명", "WMB_NO", "시약명", "회사명", "Cat no", "Lot no", "남은량", "위치", "Data sheet",
                     "New1","New2", "New3", "New4", "New5", "New6", "New7","New8", "New9", "New10")
protein <- collection_to_DF(collection_name = "protein_collection", url = mongoUrl);names(protein) <- protein_colname
protein <- protein %>% 
  select(-WMB_NO, -New1:-New10) %>% 
  mutate(`Data sheet` = ifelse(str_detect(`Data sheet`, pattern = ".html"),
                               paste0("<a href='",`Data sheet`,"'>", "LINK</a>"), 
                               ifelse(`Data sheet` == "" | `Data sheet` == "-",
                                      `Data sheet`,
                                      paste0("<a href='", fileUrl, "PDF/protein/",
                                             str_remove_all(`Data sheet`,pattern = "[[:punct:]]|[[:blank:]]"),
                                             ".pdf'>", "PDF</a>"))
  ))

## si/shRNA colname and DF
shsirna_colname <- c("과제명", "WMB_NO", "Name", "Target Gene", "Species", "Type", "농도", "Sequence", "제조사",
                     "Stock vial 입고일", "Stock vial 재고 수량", "Stock vial 보관 위치", "소분 vial 재고 수량",
                     "위치(냉동고/Box이름)", "관리자", "Data sheet", "여분1","여분2","여분3","여분4","여분5","여분6",
                     "여분7","여분8","여분9","여분10")
shsirna <- collection_to_DF(collection_name = "shsirna_collection", url = mongoUrl);names(shsirna) <- shsirna_colname
shsirna <- shsirna %>% select(-WMB_NO, -여분1:-여분10)

# Shiny run with global --------------------------------------------------
source("./ui.R", local = TRUE)  
source("./server.R", local = TRUE)  

options(shiny.port = 8888)
options(shiny.host = "192.168.0.7")
shinyApp(ui, server)

