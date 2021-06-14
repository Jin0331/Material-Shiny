ui <- dashboardPage(
  skin = "yellow",
  title = "WMBIO Material",
  
  # HEADER ------------------------------------------------------------------
  
  dashboardHeader(
    title = span(img(src = "radar.svg", height = 35), "WMBIO"),
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
  
  dashboardSidebar(width = 250,
    sidebarMenu(id = "side", 
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Blood", tabName = "blood", icon = icon("elementor")),
      menuItem("FF", tabName = "ff", icon = icon("elementor")),
      menuItem("FFPE", tabName = "ffpe", icon = icon("elementor")),
      menuItem("PDX", tabName = "pdx", icon = icon("elementor")),
      menuItem("Antibody", tabName = "antibody", icon = icon("elementor")),
      menuItem("Cell Line", tabName = "celline", icon = icon("elementor")),
      menuItem("Commercial Drug", tabName = "drug", icon = icon("elementor")),
      menuItem("Protein", tabName = "protein", icon = icon("elementor")),
      menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("elementor"))
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
    tags$head(
      tags$link(
        rel = "stylesheet", 
        type = "text/css", 
        href = "radar_style.css")
    ),
    # MAIN BODY ---------------------------------------------------------------
    tabItems(
      # First tab content
      tabItem(tabName = "home", 
              fluidRow(), 
              fluidRow( 
                valueBox(10 * 2, "Blood",icon = icon("tint"), color = "red"),
                valueBox(10 * 2, "FF",icon = icon("prescription-bottle"), color = "yellow"),
                valueBox(10 * 2, "FFPE",icon = icon("flask"), color = "aqua"),
                valueBox(10 * 2, "PDX",icon = icon("prescription"), color = "purple"),
                valueBox(10 * 2, "Antibody",icon = icon("vial"), color = "fuchsia"),
                valueBox(10 * 2, "Cell Line",icon = icon("eye-dropper"), color = "maroon"),
                valueBox(10 * 2, "Commercial Drug",icon = icon("capsules"), color = "teal"),
                valueBox(10 * 2, "Protein",icon = icon("hubspot"), color = "olive"),
                valueBox(10 * 2, "shRNA / siRNA",icon = icon("dna"), color = "lime")
                )
              
              
      ),
      
      # Second tab content
      tabItem(tabName = "blood",
              h2("Blood tab content")
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
    )
  )
)

ui <- secure_app(ui, theme = shinythemes::shinytheme("flatly"),
                 tags_top = tags$img(
                   src = "http://www.wmbio.co/images/common/logo.png", width = 240
                 ),
                 enable_admin = TRUE)