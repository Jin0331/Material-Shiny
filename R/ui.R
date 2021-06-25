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
  dashboardSidebar(width = 230, collapsed = FALSE,
    sidebarMenu(id = "side", 
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Blood", tabName = "blood", icon = icon("tint")),
      menuItem("FF", tabName = "ff", icon = icon("prescription-bottle")),
      menuItem("FFPE", tabName = "ffpe", icon = icon("flask")),
      menuItem("PDX", tabName = "pdx", icon = icon("prescription")),
      menuItem("Antibody", tabName = "antibody", icon = icon("vial")),
      menuItem("Cell Line", tabName = "celline", icon = icon("virus")),
      menuItem("Commercial Drug", tabName = "drug", icon = icon("capsules")),
      menuItem("Protein", tabName = "protein", icon = icon("share-alt")),
      menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("dna")),
      menuItem("Help", tabName = "help", icon = icon("volume-down"))
    )), 
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
                # HTML("<br>"),
                HTML('<center><img src="http://www.wmbio.co/images/main/main_second_logo.png" width="160"></center>'),
                HTML("<br>"),
                HTML('<center><span style= "font-weight: bold; font-size: 500%;line-height: 1.0em; 
                     color: #996600;font-family: helvetica;"> WMB Biobank </span></center>'),
                HTML("<br><br><br>")
                ),
              # INFOBOX UI
              box(title = tags$p("Material", style = "font-size: 150%; font-weight: bold; color: white"),
                  status = "warning",
                  solidHeader = TRUE, 
                  icon = icon("window-restore"),
                  width = 12,
                  collapsible = TRUE,
                  collapsed = FALSE,
                  # VALUEBOX 
                  infoBoxOutput("valuebox1"), infoBoxOutput("valuebox2"), infoBoxOutput("valuebox3"),
                  infoBoxOutput("valuebox4"), infoBoxOutput("valuebox5"), infoBoxOutput("valuebox6"),
                  infoBoxOutput("valuebox7"), infoBoxOutput("valuebox8"), infoBoxOutput("valuebox9")
              ),
              box(width = 12,
                  collapsed = TRUE,
                  collapsible = TRUE,
                  title = tags$p("Search", style = "font-size: 150%; font-weight: bold; color: white"),
                  status = "warning",
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
                                     choices = c("Blood", "FF", "FFPE", "PDX", "Antibody", "Cell Line", 
                                                 "Commercial Drug", "Protein", "siRNA/shRNA"), 
                                     width = "200", 
                                     inline = T,
                                     options = list( `live-search` = TRUE),
                                     )
                         ),
                  column(12, 
                         offset = 0, 
                         style='padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:20px',
                         selectizeInput(
                           inputId = "search", 
                           choices = NULL,
                           label = "",
                           ),
                         actionButton(inputId = "ac_btn", label = "search"),
                         actionButton(inputId = "re_btn", label = "reset")
                         ),
                ), # flouidRow end,
                div(shinycssloaders::withSpinner(DT::dataTableOutput("search_dt")), style = "font-size:100%")
                  
              ),
              HTML("<br><br>")

        
      ),
      # TABLE PAGE ----
      # BLOOD UI
      tabItem(tabName = "blood",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Blood", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "warning",
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
                           status = "warning",
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
                           status = "warning",
                           solidHeader = TRUE,
                           icon = icon("prescription-bottle"),
                           div(DT::dataTableOutput("ff_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "antibody",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Antibody", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "warning",
                           solidHeader = TRUE,
                           icon = icon("vial"),
                           div(DT::dataTableOutput("antibody_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "celline",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Cell Line", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "warning",
                           solidHeader = TRUE,
                           icon = icon("virus"),
                           div(DT::dataTableOutput("celline_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "drug",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Commercial Drug", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "warning",
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
                           status = "warning",
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
                           status = "warning",
                           solidHeader = TRUE,
                           icon = icon("dna"),
                           div(DT::dataTableOutput("shsirna_dt"), style = "font-size:105%")
                       )))
      ),
      tabItem(tabName = "help",
              ## LIVECHAT UI
              box(
                title = tags$p("Help", style = "font-size: 150%; font-weight: bold; color: white"),
                status = "black",
                icon = icon("user-friends"),
                solidHeader = TRUE,
                width = 12,
                div(textInput(
                  "username_field", "ID", width = "200px")),
                uiOutput("chatbox"),
                div(style = "display:inline-block; font-size: 150%;",
                    textInput("message_field", "Message", width = "400px")),
                div(style = "display:inline-block; font-size: 150%;",
                    actionButton("send", "", icon = icon("arrow-alt-circle-up")))
              )
              )
    ) # tabItems END
  ), # BODY end
  footer = dashboardFooter(
    right = "© 2021 Lee, K.M. / Lee, W.J. / Lee, J.W , Target ID, Target Discovery Institute, Wellmarker Bio. All rights reserved."
  )
  
)

# LOGIN UI ----
# ui <- secure_app(ui, theme = shinythemes::shinytheme("journal"),
#                  tags_top = tags$img(
#                    src = "http://www.wmbio.co/images/main/main_second_logo.png", width = 110
#                  ), enable_admin = TRUE)