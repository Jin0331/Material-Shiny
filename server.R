server <- function(input, output, session) {
  # LOGIN -----
  # check_credentials directly on sqlite db
  res_auth <- secure_server(
    check_credentials = check_credentials(
      "/Users/wmbio/Desktop/gitworking/Material-Shiny/data/user_db.sqlite",
      #passphrase = key_get("R-shinymanager-key", "sempre813!")
      passphrase = "passphrase_wihtout_keyring"
    )
  )
  
  # SERVER ----
  output$test1 <- DT::renderDataTable({
    colname <- "blood_collection"
    
    Antibody <- collection_to_DF(collection_name = colname, url = mongoUrl)
    Antibody
  })
 
}