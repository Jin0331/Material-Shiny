ui <- dashboardPage(
  skin = "black-light",
  # skin = "midnight",
  scrollToTop = TRUE,
  title = "WMBIO Material",
  
  # HEADER ------------------------------------------------------------------
  options = list(sidebarExpandOnHover = TRUE), 
  dashboardHeader(
    title = span(img(src = "WMB.png", height = 30), "WMBIO"),
    #title = span("WMBIO"),
    titleWidth = 250,
    tags$li(
      a(
        strong("ABOUT WMBIO"),
        height = 40,
        href = "http://www.wmbio.co/kr/about/company.php",
        title = "",
        target = "_blank"
      ),
      class = "dropdown"
    )
  ),
  
  # SIDEBAR -----------------------------------------------------------------
  dashboardSidebar(width = 250, collapsed = TRUE,
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
      menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("dna"))
    )), 
  # BODY --------------------------------------------------------------------
  
  dashboardBody(
    useShinyjs(),
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "radar_style.css")
    ),
    tags$style(HTML("
                    #chatbox {
                      padding: .5em;
                      border: 1px solid #777;
                      height: 300px;
                      overflow-y: scroll;
                    }")),
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
                # INFOBOX UI
                box(title = tags$p("Contents", style = "font-size: 130%; font-weight: bold;"),
                    status = "maroon",
                    solidHeader = TRUE, 
                    icon = icon("window-restore"),
                    width = 12,
                    collapsible = TRUE,
                    # VALUEBOX 
                    infoBoxOutput("valuebox1"), infoBoxOutput("valuebox2"), infoBoxOutput("valuebox3"),
                    infoBoxOutput("valuebox4"), infoBoxOutput("valuebox5"), infoBoxOutput("valuebox6"),
                    infoBoxOutput("valuebox7"), infoBoxOutput("valuebox8"), infoBoxOutput("valuebox9"),
                    infoBoxOutput("out1")
                ),
                ## TOTAL SEARCH UI
                box(width = 12,
                    title = tags$p("Total Search", style = "font-size: 130%; font-weight: bold;"),
                    icon = icon("search"),
                  box(title = tags$p("Table / Keywords", style = "font-weight: bold;"),
                      width = 4,
                      collapsible = TRUE,
                      solidHeader = TRUE, 
                      status = "info",
                      selectizeInput(inputId = "table_select", label = NULL, 
                                            choices = c("","Blood", "FF", "FFPE", "PDX", "Antibody",
                                                        "Cell Line", "Commercial Drug", "Protein", "shRNA / siRNA"),
                                            selected = "", options = list(placeholder="Table Select",
                                                                          plugins = list('restore_on_backspace')),
                                            width = "600px"),
                      selectizeInput(inputId = "keyword", label = NULL, multiple = TRUE,
                                            choices = NULL, options = list(placeholder="Keyword", create = TRUE),
                                            width = "600px")
                      ),
                  box(title = tags$p("Summary Table", style = "font-weight: bold;"),
                      width = 8,
                      collapsible = TRUE,
                      solidHeader = TRUE, 
                      status = "info",
                      dataTableOutput("summary_table")
                  
                )),
                ## LIVECHAT UI
                box(   
                  title = tags$p("Live Chat :)", style = "font-size: 130%; font-weight: bold;"),
                  status = "black", 
                  icon = icon("user-friends"),
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  width = 6,
                  div(textInput(
                    "username_field", "ID", width = "200px")),
                  uiOutput("chatbox"),
                  div(style = "display:inline-block",
                      textInput("message_field", "Message", width = "400px")),
                  div(style = "display:inline-block",
                      actionButton("send", "", icon = icon("arrow-alt-circle-up")))
                ),
                # NOTICE UI
                box(
                  title = tags$p("✺Notice✺", style = "font-size: 130%; font-weight: bold;"),
                  status = "orange",
                  icon = icon("volume-down"),
                  solidHeader = TRUE,
                  width = 6)
               )
              
      ),
      # TABLE PAGE ----
      # BLOOD UI
      tabItem(tabName = "blood",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Blood List", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "primary",
                           solidHeader = TRUE,
                           icon = icon("tint"),
                           # selectizeInput(inputId = "columns", label = "Filter", 
                           #                choices = c("ALL", names(blood)),
                           #                selected = NULL, width = "500px", multiple = TRUE),
                           # actionButton(inputId = "filter_run", label = "selected"),
                           div(DT::dataTableOutput("blood_dt"), style = "font-size:70%")
                       )))
      ),
      tabItem(tabName = "antibody",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Antibody", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "primary",
                           solidHeader = TRUE,
                           icon = icon("vial"),
                           div(DT::dataTableOutput("antibody_dt"), style = "font-size:70%")
                       )))
      ),
      tabItem(tabName = "celline",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Cell Line", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "primary",
                           solidHeader = TRUE,
                           icon = icon("virus"),
                           div(DT::dataTableOutput("celline_dt"), style = "font-size:70%")
                       )))
      ),
      tabItem(tabName = "drug",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Commercial Drug", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "primary",
                           solidHeader = TRUE,
                           icon = icon("capsules"),
                           div(DT::dataTableOutput("drug_dt"), style = "font-size:70%")
                       )))
      ),
      tabItem(tabName = "protein",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("Protein", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "primary",
                           solidHeader = TRUE,
                           icon = icon("share-alt"),
                           div(DT::dataTableOutput("protein_dt"), style = "font-size:70%")
                       )))
      ),
      tabItem(tabName = "shsirna",
              fluidRow(
                column(width = 12, 
                       box(title = tags$p("shRNA / siRNA", style = "font-size: 120%; font-weight: bold; color: white"),
                           width = 12,
                           status = "primary",
                           solidHeader = TRUE,
                           icon = icon("dna"),
                           div(DT::dataTableOutput("shsirna_dt"), style = "font-size:70%")
                       )))
      )
    ) # tabItems END
  )
)

# LOGIN UI ----
# ui <- secure_app(ui, theme = shinythemes::shinytheme("flatly"),
#                  tags_top = tags$img(
#                    src = "http://www.wmbio.co/images/common/logo.png", width = 240
#                  ),
#                  enable_admin = TRUE)