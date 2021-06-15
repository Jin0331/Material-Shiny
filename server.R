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
  
  # AUTO-REFRESH
  shinyjs::runjs(
    "function reload_page() {
      window.location.reload();
      setTimeout(reload_page, 500000);
    }
    setTimeout(reload_page, 500000);
")
  
  # LiveCHAT ----
  chat <- shiny.collections::collection("chat", connection)
  updateTextInput(session, "username_field",
                  value = get_random_username()
  )
  
  observeEvent(input$send, {
    new_message <- list(user = input$username_field,
                        text = input$message_field,
                        time = Sys.time())
    shiny.collections::insert(chat, new_message)
    updateTextInput(session, "message_field", value = "")
  })
  
  output$chatbox <- renderUI({
    if (!is_empty(chat$collection)) {
      render_msg_divs(chat$collection)
    } else {
      tags$span("Empty chat")
    }
  })
  
  # INFOBOX_RENDER ----
  output$valuebox1 <- collection_cnt(collection_name = "blood_collection", url = mongoUrl) %>% 
    value_func(N = "Blood", row_count = ., icon = icon("tint"), color = "red")
  
  output$valuebox2 <- collection_cnt(collection_name = "ff_collection", url = mongoUrl) %>% 
    value_func(N = "FF", row_count = ., icon = icon("prescription-bottle"), color = "yellow")
  
  # # 이부분 수정해야됨, FFPE ---
  output$valuebox3 <- collection_cnt(collection_name = "ff_collection", url = mongoUrl) %>%
    value_func(N = "FFPE", row_count = ., icon = icon("flask"), color = "aqua")

  output$valuebox4 <- collection_cnt(collection_name = "pdx_collection", url = mongoUrl) %>% 
    value_func(N = "PDX", row_count = ., icon = icon("prescription"), color = "purple")
  
  output$valuebox5 <- collection_cnt(collection_name = "antibody_collection", url = mongoUrl) %>% 
    value_func(N = "Antibody", row_count = ., icon = icon("vial"), color = "fuchsia")
  
  output$valuebox6 <- collection_cnt(collection_name = "celline_collection", url = mongoUrl) %>% 
    value_func(N = "Cell Line", row_count = ., icon = icon("virus"), color = "maroon")
  
  output$valuebox7 <- collection_cnt(collection_name = "drug_collection", url = mongoUrl) %>% 
    value_func(N = "Commercial Drug", row_count = ., icon = icon("capsules"), color = "teal")
  
  output$valuebox8 <- collection_cnt(collection_name = "protein_collection", url = mongoUrl) %>% 
    value_func(N = "Protein", row_count = ., icon = icon("share-alt"), color = "olive")
  
  output$valuebox9 <- collection_cnt(collection_name = "shsirna_collection", url = mongoUrl) %>% 
    value_func(N = "shRNA / siRNA", row_count = ., icon = icon("dna"), color = "lime")
  
  
  # DT ----
  output$test1 <- DT::renderDataTable({
    colname <- "blood_collection"
    Antibody <- collection_to_DF(collection_name = colname, url = mongoUrl)
    Antibody
  })
 
}