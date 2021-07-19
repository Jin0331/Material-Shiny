ui <- dashboardPage(
  skin = "black-light",
  # skin = "midnight",
  scrollToTop = TRUE,
  title = "WMB Biobank",
  
  # HEADER ------------------------------------------------------------------
  options = list(sidebarExpandOnHover = TRUE), 
  dashboardHeader(
    title = span(img(src = paste0(fileUrl,"WMB-2.png"), height = 30), "WMBIO",
                 style = "color: #996600; font-weight: bold; font-size: 30px"),
    tags$li(
      a(
        strong("ABOUT WMBIO"),
        height = 70,
        style = "color: #996600;",
        href = "http://www.wmbio.co/kr/about/company.php",
        title = "",
        target = "_blank"
      ),
      class = "dropdown"
    )

  ),
  
  # SIDEBAR -----------------------------------------------------------------
  dashboardSidebar(
    width = 230, 
    collapsed = FALSE,
    sidebarMenu(id = "side", 
                menuItemOutput("side_menu"))
    ), 
  # BODY --------------------------------------------------------------------
  
  dashboardBody(
    useShinyjs(),
    customTheme,
    tags$head( # favicon
      tags$link(rel = "shortcut icon", 
                href = "http://www.wmbio.co/images/main/main_second_logo.png"),
      tags$style(HTML("
                    .selectize-input { 
                      height: 100px;
                      width: 800px;
                      font-size: 15pt;
                      font-weight: bold;
                      
                    }
                    .selectize-dropdown { 
                      font-size: 20px; 
                      height: 1100px;
                      line-height: 20px;
                    }
                    #chatbox {
                      padding: .5em;
                      border: 1px solid #777;
                      height: 300px;
                      overflow-y: scroll;
                    }
                    "
      ))
    ), # chatbox
    tags$script(HTML("
        var openTab = function(tabName){
          $('a', $('.sidebar')).each(function() {
            if(this.getAttribute('data-value') == tabName) {
              this.click()
            };
          });
        }
      ")),
    # MAIN BODY ---------------------------------------------------------------
    tabItems(
      # HOME PAGE ---------------------------------------------------------------
      
      tabItem(tabName = "home", 
              fluidRow(
                align = "center", 
                width = 12,
                HTML("<br>"),
                HTML('<center><img src="http://www.wmbio.co/images/main/main_second_logo.png" width="110"></center>'),
                HTML("<br>"),
                HTML("<br>")
                ),
              box(width = 12,
                  collapsed = TRUE,
                  collapsible = TRUE,
                  title = tags$p("Search", style = "font-size: 150%; font-weight: bold; color: white"),
                  status = "info",
                  solidHeader = TRUE,
                  icon = icon("search"),
                  
                fluidRow(
                  align = "center",
                  ## TOTAL SEARCH UI
                  column(12, 
                         offset = 0,
                         style='padding-left:0px; padding-right:0px; padding-top:5px; padding-bottom:0px',
                         pickerInput(inputId = "table_picker", 
                                     label = "", 
                                     choices = "", 
                                     width = "230", 
                                     inline = FALSE,
                                     options = list( `live-search` = TRUE,
                                                     `actions-box` = TRUE,
                                                     `selectedTextFormat` = TRUE
                                                     ))
                         ),
                  column(12, 
                         offset = 0, 
                         style='padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:20px',
                         selectizeInput(
                           inputId = "search", 
                           choices = NULL,
                           label = "",
                           ),
                         actionButton(inputId = "ac_btn", label = "", icon = icon("check")),
                         actionButton(inputId = "re_btn", label = "", icon = icon("backspace")),
                         
                         ),
                ), # flouidRow end,
                div(shinycustomloader::withLoader(
                  DT::dataTableOutput("search_dt"),
                  type = "image", loader="http://192.168.0.99:18080/loading.gif"), 
                  style = "font-size:100%"
                  )
                ),
              # INFOBOX UI
              box(title = tags$p("Biobank", style = "font-size: 150%; font-weight: bold; color: white"),
                  status = "info",
                  solidHeader = TRUE, 
                  icon = icon("window-restore"),
                  width = 12,
                  collapsible = TRUE,
                  collapsed = FALSE,
                  # VALUEBOX 
                  withLoader(infoBoxOutput("valuebox1"), type = "html", loader = "dnaspin"),
                  infoBoxOutput("valuebox2"), infoBoxOutput("valuebox3"),
                  infoBoxOutput("valuebox4"), infoBoxOutput("valuebox5"), infoBoxOutput("valuebox6"),
                  infoBoxOutput("valuebox7"), infoBoxOutput("valuebox8"), infoBoxOutput("valuebox9"),
                  infoBoxOutput("valuebox10"), infoBoxOutput("valuebox11"), infoBoxOutput("valuebox12")
              ),
      ),
      # TABLE PAGE ----
      # BLOOD UI
      tabItem(tabName = "blood",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Blood", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("tint"),
                           div(DT::dataTableOutput("blood_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "pdx",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("PDX", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("prescription"),
                           div(DT::dataTableOutput("pdx_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "ff",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("FF", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("lungs-virus"),
                           div(DT::dataTableOutput("ff_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "ffpe",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("FFPE", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("ruler"),
                           div(DT::dataTableOutput("ffpe_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "antibody_wb",
              fluidRow(
                column(width = 12,
                       box(title = tags$p("ㅤWB", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("yandex-international"),
                           div(DT::dataTableOutput("antibody_wb_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "antibody_ihc",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("ㅤIHC", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("yandex-international"),
                           div(DT::dataTableOutput("antibody_ihc_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "antibody_facs",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("ㅤFACS", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("yandex-international"),
                           div(DT::dataTableOutput("antibody_facs_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "celline_wb",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Wb", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("virus"),
                           div(DT::dataTableOutput("celline_wb_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "celline_td",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("TD", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("virus"),
                           div(DT::dataTableOutput("celline_td_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "celline_dd",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("DD", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("virus"),
                           div(DT::dataTableOutput("celline_dd_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "drug",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Commercial Drug", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("capsules"),
                           div(DT::dataTableOutput("drug_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "protein",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Protein", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("share-alt"),
                           div(DT::dataTableOutput("protein_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "shsirna",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("shRNA / siRNA", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("dna"),
                           div(DT::dataTableOutput("shsirna_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "cmc_siyac",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("시약목록", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("copy"),
                           div(DT::dataTableOutput("cmc_siyac_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "cmc_column",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Column", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("copy"),
                           div(DT::dataTableOutput("cmc_column_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "mc_siyac",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("시약목록", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("copy"),
                           div(DT::dataTableOutput("mc_siyac_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "mc_column",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Column", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "info",
                           solidHeader = TRUE,
                           icon = icon("copy"),
                           div(DT::dataTableOutput("mc_column_dt"), style = "font-size:105%")
                       )))
      )
      # tabItem(tabName = "help",
      #         ## LIVECHAT UI
      #         box(
      #           title = tags$p("Help", style = "font-size: 150%; font-weight: bold; color: white"),
      #           status = "black",
      #           icon = icon("user-friends"),
      #           solidHeader = TRUE,
      #           width = 12,
      #           div(textInput(
      #             "username_field", "ID", width = "200px")),
      #           uiOutput("chatbox"),
      #           div(style = "display:inline-block; font-size: 150%;",
      #               textInput("message_field", "Message", width = "400px")),
      #           div(style = "display:inline-block; font-size: 150%;",
      #               actionButton("send", "", icon = icon("arrow-alt-circle-up")))
      #         )
      #         )
    ) # tabItems END
  ), # BODY end
  footer = dashboardFooter(
    right = "© 2021 Lee, K.M. / Lee, W.J. / Lee, J.W , Target ID, Target Discovery Institute, Wellmarker Bio. All rights reserved."
  )
  
)

# LOGIN UI ----
ui <- secure_app(ui, enable_admin = TRUE,
                 theme = shinythemes::shinytheme("flatly"),
                 tags_top = tags$img(
                   src = "http://www.wmbio.co/images/main/main_second_logo.png", width = 110
                 ), 
                 language = "en",
                 keep_token = TRUE
                 )