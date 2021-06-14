ui <- dashboardPage(
  skin = "yellow",
  title = "WMBIO Material",
  
  # HEADER ------------------------------------------------------------------
  
  dashboardHeader(
    # title = span(img(src = "radar.svg", height = 35), "WMBIO Material"),
    title = span("WMBIO Material"),
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
    sidebarMenu(
      menuItem("Dashboard", tabName = "home", icon = icon("dashboard")),
      menuItem("Blood", tabName = "blood", icon = icon("dashboard")),
      menuItem("FF", tabName = "ff", icon = icon("dashboard")),
      menuItem("FFPE", tabName = "ffpe", icon = icon("dashboard")),
      menuItem("PDX", tabName = "pdx", icon = icon("dashboard")),
      menuItem("Antibody", tabName = "antibody", icon = icon("dashboard")),
      menuItem("Cell Line", tabName = "celline", icon = icon("dashboard")),
      menuItem("Commercial Drug", tabName = "drug", icon = icon("dashboard")),
      menuItem("Protein", tabName = "protein", icon = icon("dashboard")),
      menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("dashboard"))
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
    
    # MAIN BODY ---------------------------------------------------------------

  )
)

# ui <- secure_app(ui, theme = shinythemes::shinytheme("flatly"), 
#                  tags_top = tags$img(
#                    src = "http://www.wmbio.co/images/common/logo.png", width = 240
#                  ),
#                  enable_admin = TRUE)