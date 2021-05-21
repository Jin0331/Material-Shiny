#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(mongolite)
library(tidyverse)
library(DT)


# Define UI for application that draws a histogram
ui <- basicPage(
    h2("MongoDB test"),
    DT::dataTableOutput("test1"),
    DT::dataTableOutput("test2")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$test1 <- DT::renderDataTable({
        mongoUrl <- "mongodb://root:sempre813!@192.168.0.6:27017/admin"
        colname <- "antibody_collection"
        dbname <- "material"

        con <- mongo(collection = colname, url = mongoUrl, db = dbname)
        Drug_temp <- con$find() %>% as_tibble()
        Drug_temp
    })

}


# ui <- fluidPage(
#     textInput("name", "What's your name?"),
#     textOutput("greeting")
# )
# 
# server <- function(input, output, session) {
#     output$greeting <- renderText({
#         paste0("Hello ", input$name, "!")
#     })
# }

# Run the application 
shinyApp(ui = ui, server = server)
