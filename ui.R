ui <- dashboardPage(
  skin = "midnight",
  scrollToTop = TRUE,
  title = "WMBIO Material",
  
  # HEADER ------------------------------------------------------------------
  options = list(sidebarExpandOnHover = TRUE), 
  dashboardHeader(
    title = span(img(src = "WMB-2.png", height = 35), "WMBIO"),
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
      menuItem("Blood", tabName = "blood", icon = icon("tint"),
               menuSubItem("List", tabName = "blood_list"),
               menuSubItem("Result", tabName = "blood_result")),
      menuItem("FF", tabName = "ff", icon = icon("prescription-bottle"),
               menuSubItem("List", tabName = "ff_list"),
               menuSubItem("Result", tabName = "ff_result")),
      menuItem("FFPE", tabName = "ffpe", icon = icon("flask"),
               menuSubItem("List", tabName = "ffpe_list"),
               menuSubItem("Result", tabName = "ffpe_result")),
      menuItem("PDX", tabName = "pdx", icon = icon("prescription"),
               menuSubItem("List", tabName = "pdx_list"),
               menuSubItem("Result", tabName = "pdx_result")),
      menuItem("Antibody", tabName = "antibody", icon = icon("vial")),
      menuItem("Cell Line", tabName = "celline", icon = icon("virus")),
      menuItem("Commercial Drug", tabName = "drug", icon = icon("capsules")),
      menuItem("Protein", tabName = "protein", icon = icon("share-alt")),
      menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("dna"))
    ),
    
    # condition paner for BLOOD, FF, FFPE, PDX
    conditionalPanel(
      condition = "input.side == 'blood'",
      selectInput("blood_table", "Table Select", 
                  choices = list("List" = 1, "Result" = 2))
    ),
    conditionalPanel(
      condition = "input.side == 'ff'",
      selectInput("ff_table", "Table Select", 
                  choices = list("List" = 1, "Result" = 2))
    ),
    conditionalPanel(
      condition = "input.side == 'ffpe'",
      selectInput("ffpe_table", "Table Select", 
                  choices = list("List" = 1, "Result" = 2))
    ),
    conditionalPanel(
      condition = "input.side == 'pdx'",
      selectInput("pdx_table", "Table Select", 
                  choices = list("List" = 1, "Result" = 2))
    )
    
    
    
    ), 
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
    # MAIN BODY ---------------------------------------------------------------
    tabItems(
      # First tab content
      tabItem(tabName = "home", 
              # fluidRow(
              #   box(
              #     solidHeader = TRUE,
              #     title = "Pipeline",
              #     background = NULL,
              #     width = 6,
              #     status = "danger",
              #     fluidRow(
              #       column(1, 
              #              div(style="display: inline-block; width: 0%;",
              #                  img(src="http://www.wmbio.co/data/plupload/o_1evon0bmg1sc4148hde01djrk6la.png", 
              #                      height=450, width=760)))
              #     )
              #   )
              # ),
              fluidRow( 
                box(title = "Contents",
                    status = "black",
                    solidHeader = TRUE, 
                    icon = icon("window-restore"),
                    width = 12,
                    # VALUEBOX ----
                    valueBoxOutput("valuebox1"), valueBoxOutput("valuebox2"), valueBoxOutput("valuebox3"),
                    valueBoxOutput("valuebox4"), valueBoxOutput("valuebox5"), valueBoxOutput("valuebox6"),
                    valueBoxOutput("valuebox7"), valueBoxOutput("valuebox8"), valueBoxOutput("valuebox9")
                ),
                box(
                  title = "Live Chat :)",
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
                box(
                  title = "✺Notice✺",
                  status = "danger",
                  icon = icon("volume-down"),
                  solidHeader = TRUE,
                  width = 6)
               )
              
      ),
      
      # Second tab content
      tabItem(tabName = "blood_list",
              
              lapply(1:20, box, width = 12, title = "box")
      ),
      tabItem(tabName = "ff",
              h2("FF tab content")
      ),
      tabItem(tabName = "ffpe",
              h2("FFPE tab content")
      ),
      tabItem(tabName = "pdx",
              h2("PDX tab content")
      ),
      tabItem(tabName = "antibody",
              h2("Antibody tab content")
      ),
      tabItem(tabName = "celline",
              h2("Cell Line tab content")
      ),
      tabItem(tabName = "drug",
              h2("Commercial Drug tab content")
      ),
      tabItem(tabName = "protein",
              h2("Protein tab content")
      ),
      tabItem(tabName = "shsirna",
              h2("shRNA / siRNA tab content")
      )
    ) # tabItems END
  )
)
# 
# ui <- secure_app(ui, theme = shinythemes::shinytheme("flatly"),
#                  tags_top = tags$img(
#                    src = "http://www.wmbio.co/images/common/logo.png", width = 240
#                  ),
#                  enable_admin = TRUE)