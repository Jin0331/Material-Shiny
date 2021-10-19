# INSTALL DEPENDENCIES ----------------------------------------------------
source('dependencies.R')
# connection <- shiny.collections::connect(
#   host = "192.168.0.99"
# ) # chat
fileUrl <- "http://192.168.0.99:18080/"
mongoUrl <- "mongodb://root:sempre813!@192.168.0.99:27017/admin"
# user_con <- DBI::dbConnect(drv = MariaDB(), host = "192.168.0.99", port = 3306, user = "root", password = "sempre813!",
#                            dbname = "material_users")

shiny_host <- "172.17.0.2"
shiny_port <- 3838


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
  ,boxInfoColor = "rgb(189,189,189)"
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
  language = "en","Please authenticate" = "")

# SEARCH FUNCTION ----
select_ui <- function(inputid, choices){
  selectizeInput(inputId = inputid, 
                 label = "", 
                 choices = choices, 
                 multiple = FALSE,
                 selected = NA
  ) %>% 
    return()
}
# search_keyword <- function(DF, N_vec = NULL){ 
#   if(is.null(N_vec)){
#     DF %>% transpose() %>% 
#       unlist() %>% unname() %>% c("", .) %>% unique() %>% 
#       sort(decreasing = F) %>% 
#       return()  
#   } else {
#     DF %>% select_at(N_vec) %>% transpose() %>% 
#       unlist() %>% unname() %>% c("", .) %>% unique() %>% 
#       sort(decreasing = F) %>% 
#       return()
#   }
# }
render_DT_search <- function(DF_NAME, child = F){
  if(child == T) {
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
          iDisplayLength = 5, 
          scrollX = TRUE,
          scrollY = TRUE,
          dom = "tp",
          autoWidth = TRUE,
          paging = TRUE,
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
    
  } else {
    DT::renderDataTable(DF_NAME, rownames = FALSE, extensions = c("KeyTable", "Scroller"), 
                        escape = FALSE,
                        selection=list(mode="single", target="cell"),
                        options = 
                          list(iDisplayLength = 5, 
                               searchHighlight = TRUE,
                               keys = TRUE,
                               dom = "tp",
                               scrollX = TRUE, 
                               deferRender = TRUE,
                               autoWidth = T,
                               paging = TRUE,
                               columnDefs = list(
                                 list(className = "dt-center", width = '150px', targets = "_all")
                               )
                          )
    )
  }
  
}


## INFOBOX FUCNTION ----
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

# PDX 50개 이상일 시 count로 변경
value_func <<- function(N, tab_name,row_count, icon, color, role = F){
  if(role == T){
    renderInfoBox({
      infoBox(
        a(tags$p(N, style = paste0("font-size: 145%; font-weight: bold; color:", color,";")),
          onclick = paste0("openTab('",tab_name,"')"), href = "#"),
        a(tags$p(" ", style = "font-size: 120%;color: black;"),
          onclick = paste0("openTab('",tab_name,"')"), href = "#"),
        icon = icon, color = color)
      # a(tags$p(row_count, style = "font-size: 120%;color: black;"), 
      #   onclick = paste0("openTab('",tab_name,"')"), href = "#"),
      #   icon = icon, color = color)
    })
  } else {
    renderInfoBox({
      infoBox(tags$p(N, style = paste0("font-size: 145%; font-weight: bold; color:", color,";")),
              a(tags$p(" ", style = "font-size: 120%;color: black;")),
              icon = icon, color = color)
    })
  }
}

## chat db & function ----
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

# DT TABLE FUNCTION ----
## DT CallBack 
rowNames <<- FALSE
child_function <- function(list_df, result_df){
  NestedData <- function(dat, children){
    # stopifnot(length(children) == nrow(dat))
    g <- function(d){
      if(is.data.frame(d)){
        purrr::transpose(d)
      }else{
        purrr::transpose(NestedData(d[[1]], children = d$children))
      }
    }
    
    subdats <- lapply(children, g)
    oplus <- ifelse(lengths(subdats), "&oplus;", "&oplus;") 
    cbind("Result" = oplus, dat, "_details" = I(subdats), 
          stringsAsFactors = FALSE)
  }
  sample_list <- list_df$`Sample ID`
  return_list <- list()
  rowNames = FALSE
  
  children_list <- list()
  for(sample in 1:length(sample_list)){
    child_temp <- result_df %>% filter(`Sample ID` == sample_list[sample])
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
child_function_FF <- function(list_df, result_df){
  NestedData <- function(dat, children){
    # stopifnot(length(children) == nrow(dat))
    g <- function(d){
      if(is.data.frame(d)){
        purrr::transpose(d)
      }else{
        purrr::transpose(NestedData(d[[1]], children = d$children))
      }
    }
    
    subdats <- lapply(children, g)
    oplus <- ifelse(lengths(subdats), "&oplus;", "&oplus;") 
    cbind("Result" = oplus, dat, "_details" = I(subdats), 
          stringsAsFactors = FALSE)
  }
  sample_list <- list_df$`FF ID`
  return_list <- list()
  rowNames = FALSE
  
  children_list <- list()
  for(sample in 1:length(sample_list)){
    child_temp <- result_df %>% filter(`FF ID` == sample_list[sample])
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
    "    'background-color': '#e3cd5d'",
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
# DT RENDER
render_DT_child <- function(DF_NAME){
  DT::renderDataTable(
    datatable(
      DF_NAME[[1]], 
      # callback = callback_function_1(DF_NAME[[2]], DF_NAME[[3]]),
      callback = callback_function_2(),
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
                                     fixedHeader = FALSE,
                                     buttons = c("colvis",'copy', 'csv'),
                                     dom = "Bfrtip",
                                     scrollX = TRUE, 
                                     deferRender = TRUE,
                                     scrollY = 700,
                                     scroller = TRUE,
                                     autoWidth = T,
                                     columnDefs = list(
                                       list(className = "dt-center", width = '200px', targets = "_all")
                                     )
                      )
  )
}
render_DT_searchpane <- function(DF_NAME, not_view){
  DT::renderDataTable(DF_NAME, 
                      server = FALSE,
                      escape = FALSE, 
                      rownames = FALSE, 
                      extensions = c("Select", "SearchPanes", "Buttons", "FixedHeader", "Scroller"), 
                      selection = "none",
                      options = list(
                        buttons = list(
                          list(
                            extend = "searchPanes",
                            config = list(
                              dtOpts = list(
                                paging = FALSE
                              )
                            )
                          ),
                          list(extend = "csv"),
                          list(extend = "copy")
                        ),
                        language = list(searchPanes = list(collapse = "Filter Rows")),
                        dom = "Bfrtip",
                        autoWidth = T,
                        iDisplayLength = 25,
                        searchHighlight = TRUE,
                        fixedHeader = FALSE,
                        deferRender = TRUE,
                        scrollY = 700,
                        scroller = TRUE,
                        scrollX = TRUE, 
                        columnDefs = list(
                          list(searchPanes = list(show = FALSE), targets = not_view),
                          # list(searchPanes = list(controls = FALSE), targets = 0:2),
                          list(className = "dt-center", width = '200px', targets = "_all")
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
                                       list(className = "dt-center",width = '250px', targets = "_all")
                                     )
                      )
  )
}
# MAIN DATAFRAME ----
# BLOOD colname and DF 
## LIST
blood_list_colname <- c("WMB_NO", "Sample ID", "FF ID", "검체번호", "구입처(국내)", "구입처(해외)",
                        "Ethnicity", "암종", "입고형태", "인수자", "입고일자", "보관위치", "Cancer",
                        "Tumor Grade", "Tumor Stage", "기본정보(성별)", "기본정보(나이)", "기본정보(신장)",
                        "체중(기본정보)", "Status(Smoking정보)", "Cigarettes/Day(Smoking정보)", "Duration(Smoking정보)",
                        "Status(Alcohol정보)", "Drinks/Day(Alcohol정보)", "Duration(Alcohol정보)", "Prior Treatment(Treatment History)",
                        "Responder(Erbitux)", "Non-Responder(Erbitux)", "Treatment_history_Treatment_History1_Responder",
                        "Treatment_history_Treatment_History1_Non_Responder", "Single cell 분리날짜(날짜)", 
                        "Single cell 분리날짜(수행자)", "Cell population(정보)", "Cell population(수행자)",
                        "Cytokine profile(정보)", "Cytokine profile(수행자)","In vitro-coculture with(정보)", 
                        "In vitro-coculture with(수행자)", "Tested drug(정보)", "Tested drug(수행자)", "환자정보",
                        "New1", "New2", "New3", "New4", "New5")

blood <- collection_to_DF(collection_name = "blood_collection", url = mongoUrl);names(blood) <- blood_list_colname
blood <- blood %>% select(-WMB_NO, -Treatment_history_Treatment_History1_Responder,
                          -Treatment_history_Treatment_History1_Non_Responder,
                          -New1:-New5)

## RESULT
blood_result_colname <- c("WMB_NO", "Sample ID", "검체번호", "실험방법(cell death_assay, Immune cell_analysis, cytokine_analysis, protein_analsys )",
                          "이미지(실험관련)", "Material", "Method", "condition", "실험 내용", "Result", "수행자", "실험 날짜")
blood_result <- collection_to_DF(collection_name = "blood_result_collection", url = mongoUrl);names(blood_result) <- blood_result_colname
blood_result <- blood_result %>% 
  select(-WMB_NO) %>% 
  mutate(`이미지(실험관련)`  = ifelse(`이미지(실험관련)`  == "" | `이미지(실험관련)`  == "-", 
                               `이미지(실험관련)` ,
                               paste0("<a href='", fileUrl, "IMG/blood/", 
                                      str_remove_all(`이미지(실험관련)` ,pattern = "[[:punct:]]|[[:blank:]]|[.jpg]"), ".jpg'>", "View</a>")))

# FF colname and DF
## LIST
ff_list_colname <- c("WMB_NO", "Sample ID", "FF ID", "구입처(국내)", "구입처(해외)", "Ethnicity", "Tissue Site", "Matrix(Tissue type)",
                     "인수자", "입고일자", "Tumor Grade", "Tumor Stage", "Tumor contents(%)", "Tumor size(Cm)", "Tumor Weight(g)", 
                     "소분일자(조직소분)", "소분총개수(조직소분)", "보관위치", "성별(기본정보)", "나이(기본정보)", "신장(기본정보)", 
                     "체중(기본정보)", "Status(Smoking정보)", "Cigarettes/Day(Smoking정보)", "Duration(Smoking정보)","Status(Alcohol정보)", 
                     "Drinks/Day(Alcohol정보)", "Duration(Alcohol정보)", "Date of surgery(수술이력)", "Metastases(수술이력)", 
                     "Prior Treatment(Treatment History)", "Drug Response(Treatment History)",
                     "Histological Description(Diagnosis)", "TNM Staging", "Microsatellite instability(MSI)", "RON(RT-PCR유무)",
                     "KRAS(RT-PCR유무)", "BRAF(RT-PCR유무)", "EGFR(RT-PCR유무)", "IGSF1(RT-PCR유무)", "RT_PCR1", "RT_PCR2", "RT_PCR3",
                     "RT_PCR4", "RT_PCR5", "RT_PCR6", "WB_Experimental1","WB_Experimental2","WB_Experimental3", "WB_Experimental4",
                     "WB_Experimental5", "WB_Experimental6", "New1", "New2","New3","New4","New5","New6","New7")

ff <- collection_to_DF(collection_name = "ff_collection", url = mongoUrl);names(ff) <- ff_list_colname
ff <- ff %>% select(-WMB_NO, -`Sample ID`, -RT_PCR1:-RT_PCR6, -WB_Experimental1:-WB_Experimental6, -New1:-New7)

## RESULT
ff_result_colname <- c("WMB_NO", "Sample ID", "FF ID", "Tissue Site", "Tumor Grade","Tumor Stage", 
                       "Prior Treatment(Treatment History)", "Drug Response(Treatment History)", "RON(RT-PCR결과)", 
                       "KRAS(RT-PCR결과)","BRAF(RT-PCR결과)","EGFR(RT-PCR결과)", "IGSF1(RT-PCR결과)","RT-PCR1(RT-PCR결과)",
                       "RT-PCR2(RT-PCR결과)","RT-PCR3(RT-PCR결과)","RT-PCR4(RT-PCR결과)","RT-PCR5(RT-PCR결과)",
                       "RT-PCR6(RT-PCR결과)","RT-PCR7(RT-PCR결과)","RT-PCR8(RT-PCR결과)","RON(WM실험결과)", "BRAF(WM실험결과)",
                       "EGFR(WM실험결과)", "RT-PCR1(WM실험결과)","RT-PCR2(WM실험결과)", "RT-PCR3(WM실험결과)",
                       "RT-PCR4(WM실험결과)","RT-PCR5(WM실험결과)","RT-PCR6(WM실험결과)","RT-PCR7(WM실험결과)","RT-PCR8(WM실험결과)", 
                       "RT-PCR9(WM실험결과)")
ff_result <- collection_to_DF(collection_name = "ff_result_collection", url = mongoUrl);names(ff_result) <- ff_result_colname
ff_result <- ff_result %>% select(-WMB_NO, -`Sample ID`, -`RT-PCR1(RT-PCR결과)`:-`RT-PCR8(RT-PCR결과)`, -`RT-PCR1(WM실험결과)`:-`RT-PCR9(WM실험결과)`)

## FFPE colname and DF
## LIST
ffpe_list_colname <- c("WMB_NO", "Sample ID", "FF ID", "구입처(국내)", "구입처(해외)", "Ethnicity", "암종", "입고형태", "인수자", "입고일자", "보관위치",
                       "Cancer", "Tumor Grade", "Tumor Stage", "성별(기본정보)", "나이(기본정보)", "신장(기본정보)", 
                       "체중(기본정보)", "Status(Smoking정보)", "Cigarettes/Day(Smoking정보)", "Duration(Smoking정보)","Status(Alcohol정보)", 
                       "Drinks/Day(Alcohol정보)", "Duration(Alcohol정보)","p53(IHC결과)", "p34(IHC결과)","MDM2(IHC결과)", "pRON(IHC결과)", 
                       "RON(IHC결과)", "MSP(IHC결과)","c-myc(IHC결과)", "PD-L1(IHC결과)", "IGSF1(IHC결과)", "New1","New2","New3","New4","New5","New6",
                       "New7", "New8","New9","New10","New11","New12","New13","New14","New15", "New16", "New17","New18","New19","New20","New21")
ffpe <- collection_to_DF(collection_name = "ffpe_collection", url = mongoUrl);names(ffpe) <- ffpe_list_colname
ffpe <- ffpe %>% select(-WMB_NO, -`Sample ID`, -New1:-New21)

## RESULT
ffpe_result_colname <- c("WMB_NO", "Sample ID", "FF ID", "Tissue site", "Cancer","Tumor Grade", "Tumor Stage", "이미지(실험관련)", "Target(실험관련)",
                         "Antibody 농도(실험관련)", "Score(실험관련)", "실험 내용(실험관련)", "실험 결과(실험관련)", "수행자(실험관련")
ffpe_result <- collection_to_DF(collection_name = "ffpe_result_collection", url = mongoUrl);names(ffpe_result) <- ffpe_result_colname
ffpe_result <- ffpe_result %>% select(-WMB_NO, -`Sample ID`) %>% 
  mutate(`이미지(실험관련)`  = ifelse(`이미지(실험관련)`  == "" | `이미지(실험관련)`  == "-", 
                               `이미지(실험관련)` ,
                               paste0("<a href='", fileUrl, "IMG/ffpe/", 
                                      str_remove_all(`이미지(실험관련)` ,pattern = "[[:punct:]]|[[:blank:]]|[.jpg]"), ".jpg'>", "View</a>")))


# PDX colname and Df
## LIST
pdx_list_colname <- c("WMB_NO", "Sample ID", "FF ID", "검체번호", "구입처(국내)", "구입처(해외)", "Ethnicity", 
                      "Tissue", "Disease", "입고형태", "인수자", "입고일자", "보관위치", "Tumor Grade", "Tumor Stage",
                      "성별(기본정보)", "나이(기본정보)", "신장(기본정보)", "체중(기본정보)", "Status(Smoking정보)", 
                      "Cigarettes/Day(Smoking정보)", "Duration(Smoking정보)","Status(Alcohol정보)", "Drinks/Day(Alcohol정보)", 
                      "Duration(Alcohol정보)", "Prior Treatment(Treatment History)", "Drug(Treatment History)", "Drug2",
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

## CHAMPION

pdx_champion_colname <- c("Tissue", "Model", "RON Variant", "p-RON Score", "RON Score", "Patient Treatments - Drug/Drug combination", "PDX Model TGI(%) - Drug/Drug combination",
                          "Tumor status", "Histology", "Diagnosis", "Treatment history", "Ethnicity", "Alias", "Passage")
pdx_champion <- collection_to_DF(collection_name = "pdx_champion_collection", url = mongoUrl);names(pdx_champion) <- pdx_champion_colname


## antibody colname and DF
### wb

# raw
# DP col ->  No.	Antibody	Cat no.	Host	Species Reactivity	Application 	단백질 크기 (kDa)	재고량 vial	보관 위치	제조사	비고
# antibody_wb_colname <- c("No", "Antibody", "Cat no.", "Lot no.", "Conc.", "Host", "Species Reactivity",
#                          "Application", "사용 Titer", "Blocking Buffer", "단백질 크기(kDa)", "재고량 vial", "입고 날짜",
#                          "보관 위치", "관리자(관리팀)", "제조사", "비고", "New1","New2","New3","New4","New5","New6","New7",
#                          "New8")
# antibody_wb <- collection_to_DF(collection_name = "antibody_wb_collection", url = mongoUrl);names(antibody_wb) <- antibody_wb_colname
# antibody_wb <- antibody_wb %>% select(Antibody, `Cat no.`, Host, `Species Reactivity`, Application, `단백질 크기(kDa)`,
#                                       `보관 위치`, 제조사, 비고)

# DP
antibody_wb_colname <- c("No", "Antibody", "Cat no.", "Host", "Species Reactivity", "Application", "단백질 크기(kDa)",
                         "보관 위치", "제조사", "비고", "New1","New2","New3","New4","New5","New6","New7",
                         "New8")
antibody_wb <- collection_to_DF(collection_name = "antibody_wb_collection", url = mongoUrl);names(antibody_wb) <- antibody_wb_colname
antibody_wb <- antibody_wb %>% select(Antibody, `Cat no.`, Host, `Species Reactivity`, Application, `단백질 크기(kDa)`,
                                      `보관 위치`, 제조사, 비고)

### ihc
antibody_ihc_colname <- c("No", "WMB_NO", "Antibody", "Cat no.", "Lot no.", "Conc.", "Host", "Species Reactivity",
                          "Application", "사용 Titer", "Blocking Buffer", "단백질 크기(kDa)", "재고량 vial", "입고 날짜",
                          "보관 위치", "관리자(관리팀)", "제조사", "비고", "New1","New2","New3","New4","New5","New6","New7",
                          "New8")
antibody_ihc <- collection_to_DF(collection_name = "antibody_ihc_collection", url = mongoUrl);names(antibody_ihc) <- antibody_ihc_colname
antibody_ihc <- antibody_ihc %>% select(Antibody, `Cat no.`, Host, `Species Reactivity`, Application, `단백질 크기(kDa)`,
                                        `재고량 vial`, `보관 위치`, 제조사, 비고)

### facs
antibody_facs_colname <- c("Antibody", "Cat no.", "Host", "Species Reactivity", "Application", "보관 위치", "관리자(관리팀)",
                           "제조사", "비고", "New1","New2","New3","New4","New5")
antibody_facs <- collection_to_DF(collection_name = "antibody_facs_collection", url = mongoUrl);names(antibody_facs) <-antibody_facs_colname
antibody_facs <- antibody_facs %>% select(Antibody, `Cat no.`, Host, `Species Reactivity`, Application, `보관 위치`,
                                          제조사, 비고)



## celline colname and DF
# total
celline_wb_colname <- c("WMB_NO", "Cell line", "Tissue", "Organism", "Disease", "Chemoresistance status",
                        "Mutation status", "RON Genotype", "IGSF1 Genotype", "P34 Genotype", "Media Condition",
                        "GROWTH PATTERN", "계대비율 및 주기", "구매처", "특이사항")
celline_wb <- collection_to_DF(collection_name = "celline_wb_collection", url = mongoUrl);names(celline_wb) <- celline_wb_colname
celline_wb <- celline_wb %>% select(-WMB_NO)

# td cell
celline_td_colname <- c("No.", "Tissue", "Cell line", "Organism", "Passage", "Doubling time", "특징", "Media Condition", "GROWTH PATTERN", "구매처", "보유자", 
                        "소속 (팀)", "Picture")
celline_td <- collection_to_DF(collection_name = "celline_td_collection", url = mongoUrl);names(celline_td) <- celline_td_colname
celline_td <- celline_td %>% 
  mutate(Picture = ifelse(Picture == "" | Picture == "-" | Picture == " ",
                          " ", paste0("<a href='", Picture,"'>", "View</a>"))
  ) %>% 
  select(`Cell line`, Tissue, Organism, Passage, `Doubling time`, 특징, `Media Condition`, `GROWTH PATTERN`, 구매처, 보유자, 
         `소속 (팀)`, Picture)

# dd cell
celline_dd_colname <- c("No.", "Cell line", "Tissue","Organism", "Disease", "Media Condition", "GROWTH PATTERN", "구매처","보관")
celline_dd <- collection_to_DF(collection_name = "celline_dd_collection", url = mongoUrl);names(celline_dd) <- celline_dd_colname
celline_dd <- celline_dd %>% select(-`No.`)

## drug colname and DF
drug_colname <- c("WMB_NO", "Name", "제조사", "용량", "Target", "Cat", "구입일",
                  "보관위치", "관리자", "비고", "Data sheet", "New1","New2", "New3", "New4", "New5", "New6")
drug <- collection_to_DF(collection_name = "drug_collection", url = mongoUrl);names(drug) <- drug_colname
drug <- drug %>% 
  select(-WMB_NO, -New1:-New6) %>% 
  mutate(`Data sheet` = ifelse(str_detect(`Data sheet`, pattern = ".html"),
                               paste0("<a href='",`Data sheet`,"'>", "View</a>"), 
                               ifelse(str_detect(`Data sheet`, pattern = "_PDF"), 
                                      paste0("<a href='", fileUrl, "PDF/drug/",
                                             str_remove_all(`Data sheet`,pattern = "[[:punct:]]|[[:blank:]]|PDF"),".pdf'>", "View</a>"),
                                      " ")))


## protein colname and DF
protein_colname <- c("과제명", "WMB_NO", "시약명", "회사명", "Cat no", "남은량", "위치", "Data sheet")
protein <- collection_to_DF(collection_name = "protein_collection", url = mongoUrl);names(protein) <- protein_colname
protein <- protein %>% 
  select(-WMB_NO) %>% 
  mutate(`Data sheet` = ifelse(str_detect(`Data sheet`, pattern = ".html"),
                               paste0("<a href='",`Data sheet`,"'>", "View</a>"), 
                               ifelse(`Data sheet` == "" | `Data sheet` == "-" | `Data sheet` == " ",
                                      " ", paste0("<a href='", fileUrl, "PDF/protein/",
                                                  str_remove_all(`Data sheet`,pattern = "[[:punct:]]|[[:blank:]]"),
                                                  ".pdf'>", "View</a>"))
  ))

## si/shRNA colname and DF
shsirna_colname <- c("과제명", "WMB_NO", "Name", "Target Gene", "Species", "Type", "농도", "Sequence", "제조사",
                     "Stock vial 입고일", "Stock vial 재고 수량", "Stock vial 보관 위치", "소분 vial 재고 수량",
                     "위치(냉동고/Box이름)", "관리자", "여분1","여분2","여분3","여분4","여분5","여분6",
                     "여분7","여분8","여분9","여분10")
shsirna <- collection_to_DF(collection_name = "shsirna_collection", url = mongoUrl);names(shsirna) <- shsirna_colname
shsirna <- shsirna %>% select(-WMB_NO, -`Stock vial 입고일`, -`Stock vial 재고 수량`, -`Stock vial 보관 위치`,
                              -`소분 vial 재고 수량`, -여분1:-여분10)

# CMC 시약목록/column 
cmc_reagent_colname <- c("CAS NO", "제조회사", "prefix", "이름", "CAT NO", "단위", "수량", "보관위치", "입고일자", "MSDS", "비고")
cmc_reagent <- collection_to_DF(collection_name = "cmc_reagent_collection", url = mongoUrl);names(cmc_reagent) <- cmc_reagent_colname

cmc_reagent_column_colname <- c("관리번호", "제조회사", "이름", "CAT NO", "Size", "Pore size", "입고일자", "상태")
cmc_reagent_column <- collection_to_DF(collection_name = "cmc_reagent_column_collection", url = mongoUrl);names(cmc_reagent_column) <- cmc_reagent_column_colname

# 의약화한센터 시약목록/column 
mc_reagent_colname <- c("CAS NO", "제조회사", "prefix", "이름", "CAT NO", "단위", "수량", "보관위치", "입고날짜", "특수건강진단 대상 유해인자", 
                        "유해인자-상태", "비고")
mc_reagent <- collection_to_DF(collection_name = "medicalchemistry_reagent_collection", url = mongoUrl);names(mc_reagent) <- mc_reagent_colname

mc_reagent_column_colname <- c("관리번호", "제조회사", "제품명"," Cat. No.", "Size", "Pore size", "입고일자", "상태")
mc_reagent_column <- collection_to_DF(collection_name = "medicalchemistry_reagent_column_collection", url = mongoUrl);names(mc_reagent_column) <- mc_reagent_column_colname


# Shiny run with global --------------------------------------------------
source("./ui.R", local = TRUE)  
source("./server.R", local = TRUE)  

options(shiny.port = shiny_port)
options(shiny.host = shiny_host)
shinyApp(ui, server)

