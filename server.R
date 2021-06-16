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
  # TOTAL SEARCH ----
  observe({
    table_k <- isolate(input$table_select) # don't allow re-evaluation as users type
    keyword_k <- input$keyword
    updateSelectizeInput(session,"keyword",choices=keyword_k,selected=keyword_k)
  })
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
  
  # VALUEBOX_RENDER ----
  output$valuebox1 <- collection_cnt(collection_name = "blood_collection", url = mongoUrl) %>% 
    value_func(N = "Blood", tab_name = "blood_list", row_count = ., icon = icon("tint"), color = "red")
  
  output$valuebox2 <- collection_cnt(collection_name = "ff_collection", url = mongoUrl) %>% 
    value_func(N = "FF", tab_name = "ff_list", row_count = ., icon = icon("prescription-bottle"), color = "orange")
  
  # # 이부분 수정해야됨, FFPE ---
  output$valuebox3 <- collection_cnt(collection_name = "ff_collection", url = mongoUrl) %>%
    value_func(N = "FFPE", tab_name = "ffpe_list", row_count = ., icon = icon("flask"), color = "aqua")

  output$valuebox4 <- collection_cnt(collection_name = "pdx_collection", url = mongoUrl) %>% 
    value_func(N = "PDX", tab_name = "pdx_list", row_count = ., icon = icon("prescription"), color = "purple")
  
  output$valuebox5 <- collection_cnt(collection_name = "antibody_collection", url = mongoUrl) %>% 
    value_func(N = "Antibody", tab_name = "antibody", row_count = ., icon = icon("vial"), color = "fuchsia")
  
  output$valuebox6 <- collection_cnt(collection_name = "celline_collection", url = mongoUrl) %>% 
    value_func(N = "Cell Line", tab_name = "celline",row_count = ., icon = icon("virus"), color = "maroon")
  
  output$valuebox7 <- collection_cnt(collection_name = "drug_collection", url = mongoUrl) %>% 
    value_func(N = "Commercial Drug", tab_name = "drug", row_count = ., icon = icon("capsules"), color = "teal")
  
  output$valuebox8 <- collection_cnt(collection_name = "protein_collection", url = mongoUrl) %>% 
    value_func(N = "Protein", tab_name = "protein",row_count = ., icon = icon("share-alt"), color = "olive")
  
  output$valuebox9 <- collection_cnt(collection_name = "shsirna_collection", url = mongoUrl) %>% 
    value_func(N = "shRNA / siRNA", tab_name = "shsirna", row_count = ., icon = icon("dna"), color = "lime")
  
  # DT ----
  # BLOOOD DT
  output$blood_list_dt <- render_DT(blood)
  
  output$antibody_dt <- render_DT(antibody)
  
  
  # filter 기능 보류
  # observeEvent(input$columns, {
  #   # cols <- input$columns ### <<<<<<<<<<<----- dsadsadzxcasdzxcasd
  #   if("ALL" %in% input$columns){
  #     blood_temp <- blood
  #   } else {
  #     blood_temp <- blood %>% select(input$columns)    
  #   }
  #   
  #   output$blood_list_dt <- render_DT(blood_temp)
  #   # output$blood_list_dt <- reder_DT(blood_temp)
  # })

 
}