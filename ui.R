

ui <- dashboardPage(
  skin = "black",
  title = "WMBIO Material",
  
  # HEADER ------------------------------------------------------------------
  
  dashboardHeader(
    # title = span(img(src = "radar.svg", height = 35), "WMBIO Material"),
    title = span("WMBIO Material"),
    titleWidth = 300,
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
  
  dashboardSidebar(
    width = 300,
    introBox(data.step = 3, data.intro = intro$text[3], #  intro tour
             div(class = "inlay", style = "height:15px;width:100%;background-color: #ecf0f5;"),
             sidebarMenu(
               introBox(data.step = 1, data.intro = intro$text[1], # intro tour
                        div(id = "sidebar_button",
                            bsButton(inputId = "confirm", 
                                     label = "START RADAR", 
                                     icon = icon("play-circle"), 
                                     style = "danger")
                        )
               ),
               div(class = "inlay", style = "height:15px;width:100%;background-color: #ecf0f5;"),
               menuItem(
                 "DOWNLOAD SELECTION",
                 tabName = "download",
                 icon = icon("download"),
                 textInput(
                   inputId = "filename",
                   placeholder = "Name download file",
                   label = ""
                 ),
                 div(
                   downloadButton(
                     outputId = "downloadData",
                     label = "Save Antimicrobial/Admission Data",
                     icon = icon("download"),
                     style = "color: black; margin-left: 15px; margin-bottom: 5px;"
                   )
                 ),
                 div(
                   downloadButton(
                     outputId = "downloadMicroData",
                     label = "Save Microbiology Data",
                     icon = icon("download"),
                     style = "color: black; margin-left: 15px; margin-bottom: 5px;"
                   )
                 )
               ),
               br()
               
             )
    )),
  
  
  # BODY --------------------------------------------------------------------
  
  dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet", 
        type = "text/css", 
        href = "radar_style.css")
    ),
    
    useShinyjs(),
    introjsUI(),
    
    # MAIN BODY ---------------------------------------------------------------
    
    fluidRow(
      column(
        width = 12,
        introBox(
          bsButton("blood", 
                   label = "BLOOD", 
                   icon = icon("spinner", class = "spinner-box"), 
                   style = "success"),
          bsButton("ff", 
                   label = "FF", 
                   icon = icon("spinner", class = "spinner-box"), 
                   style = "success"),
          bsButton("pdx", 
                   label = "PDX", 
                   icon("spinner", class = "spinner-box"), 
                   style = "success"),
          bsButton("antibody", 
                   label = "ANTIBODY", 
                   icon("spinner", class = "spinner-box"), 
                   style = "success"),
          bsButton("celline", 
                   label = "Cell Line", 
                   icon("spinner", class = "spinner-box"), 
                   style = "success"),
          bsButton("drug", 
                   label = "DRUG", 
                   icon("spinner", class = "spinner-box"), 
                   style = "success"),
          bsButton("protein", 
                   label = "PROTEIN", 
                   icon("spinner", class = "spinner-box"), 
                   style = "success"),
          bsButton("rna", 
                   label = "shRNA / siRNA", 
                   icon("spinner", class = "spinner-box"), 
                   style = "success"),
          data.step = 2, data.intro = intro$text[2])
      )
    ),
    
    fluid_design("antimicrobials_panel", "box1", "box2", "box3", "box4"),
    fluid_design("diagnostics_panel", "box5", "box6", "box7", "box8"),
    fluid_design("outcome_panel", "box_los1", "box_los2", "box_los3", NULL),
    
    fluidRow(
      div(
        id = "patients_panel", 
        column(
          width = 12,
          introBox(data.step = 4, data.intro = intro$text[4],
                   uiOutput("box_pat")
          )
        ),
        column(
          width = 6,
          uiOutput("box_pat2")
        ),
        column(
          width = 6,
          uiOutput("box_year")
        )
      )
    )
  )
)

ui <- secure_app(ui, theme = shinythemes::shinytheme("flatly"), 
                 tags_top = tags$img(
                   src = "http://www.wmbio.co/images/common/logo.png", width = 240
                 ),
                 enable_admin = TRUE)