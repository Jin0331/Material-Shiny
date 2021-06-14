server <- function(input, output, session) {
  output$test1 <- DT::renderDataTable({
    colname <- "blood_collection"
    
    Antibody <- collection_to_DF(collection_name = colname, url = mongoUrl)
    Antibody
  })
 
}