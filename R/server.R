server <- function(input, output, session) {
  # LOGIN -----
  # MySQL
  # user_df <- tbl(user_con, "user") %>% 
  #   collect() %>% 
  #   mutate(admin = ifelse(admin == 0, FALSE, TRUE)) %>% 
  #   as.data.frame()
  
  # res_auth <- secure_server(
  #   check_credentials = check_credentials(user_df), 
  #   keep_token = TRUE
  # )
  
  res_auth <- secure_server(
    check_credentials = check_credentials("/home/rstudio/Material-Shiny/user_db.sqlite",
                                          passphrase = "passphrase_wihtout_keyring"),
    keep_token = TRUE
  )
  
  # AUTO-REFRESH
  shinyjs::runjs(
    "function reload_page() {
      window.location.reload();
      setTimeout(reload_page, 5000000);
    }
    setTimeout(reload_page, 5000000);
")
  # RENDERMENU ----
  output$side_menu <- renderMenu({
    role <- res_auth$role
    if(role == "A"){
      menu_list <- list(
        menuItem("Home", tabName = "home", icon = icon("home"), selected = T),
        menuItem("Blood", tabName = "blood", icon = icon("tint")),
        menuItem("FF", tabName = "ff", icon = icon("diagnoses")),
        menuItem("FFPE", tabName = "ffpe", icon = icon("ruler")),
        menuItem("PDX", tabName = "pdx", icon = icon("prescription")),
        menuItem("ㅤAntibody", tabName = "antibody_main", icon = icon("yandex-international"),
                 menuSubItem(
                   text = "WB",
                   tabName = "antibody_wb"
                   ),
                 menuSubItem(
                   text = "IHC",
                   tabName = "antibody_ihc"
                 ),
                 menuSubItem(
                   text = "FACS",
                   tabName = "antibody_facs"
                 )),
        menuItem("Cell Line", tabName = "celline_main", icon = icon("virus"),
                 menuSubItem(
                   text = "WB",
                   tabName = "celline_wb"
                 ),
                 menuSubItem(
                   text = "TD",
                   tabName = "celline_td"
                 ),
                 menuSubItem(
                   text = "DD",
                   tabName = "celline_dd"
                 )
                 ),
        menuItem("Commercial Drug", tabName = "drug", icon = icon("capsules")),
        menuItem("Protein", tabName = "protein", icon = icon("share-alt")),
        menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("dna")),
        menuItem("CMC", tabName = "cmc_main", icon = icon("atom"),
                 menuSubItem(
                   text = "시약목록",
                   tabName = "cmc_siyac"
                 ),
                 menuSubItem(
                   text = "Column",
                   tabName = "cmc_column")
                 ),
        menuItem("의약화학센터", tabName = "mc_main", icon = icon("prescription-bottle-alt"),
                 menuSubItem(
                   text = "시약목록",
                   tabName = "mc_siyac"
                 ),
                 menuSubItem(
                   text = "Column",
                   tabName = "mc_column"
                 ))
        # menuItem("Help", tabName = "help", icon = icon("volume-down"))
      )
    } else if(role == "B"){
      menu_list <- list(
        menuItem("Home", tabName = "home", icon = icon("home"), selected = T),
        menuItem("Blood", tabName = "blood", icon = icon("tint")),
        menuItem("FF", tabName = "ff", icon = icon("diagnoses")),
        menuItem("FFPE", tabName = "ffpe", icon = icon("ruler")),
        menuItem("ㅤAntibody", tabName = "antibody_main", icon = icon("yandex-international"),
                 menuSubItem(
                   text = "WB",
                   tabName = "antibody_wb"
                 ),
                 menuSubItem(
                   text = "IHC",
                   tabName = "antibody_ihc"
                 ),
                 menuSubItem(
                   text = "FACS",
                   tabName = "antibody_facs"
                 )),
        menuItem("Cell Line", tabName = "celline_main", icon = icon("virus"),
                 menuSubItem(
                   text = "WB",
                   tabName = "celline_wb"
                 ),
                 menuSubItem(
                   text = "TD",
                   tabName = "celline_td"
                 ),
                 menuSubItem(
                   text = "DD",
                   tabName = "celline_dd"
                 )
        ),
        menuItem("Commercial Drug", tabName = "drug", icon = icon("capsules")),
        menuItem("Protein", tabName = "protein", icon = icon("share-alt")),
        menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("dna")),
        menuItem("CMC", tabName = "cmc_main", icon = icon("atom"),
                 menuSubItem(
                   text = "시약목록",
                   tabName = "cmc_siyac"
                 ),
                 menuSubItem(
                   text = "Column",
                   tabName = "cmc_column")
        ),
        menuItem("의약화학센터", tabName = "mc_main", icon = icon("prescription-bottle-alt"),
                 menuSubItem(
                   text = "시약목록",
                   tabName = "mc_siyac"
                 ),
                 menuSubItem(
                   text = "Column",
                   tabName = "mc_column"
                 ))
        # menuItem("Help", tabName = "help", icon = icon("volume-down"))
      )
    } else {
      menu_list <- list(
        menuItem("Home", tabName = "home", icon = icon("home"), selected = T),
        menuItem("ㅤAntibody", tabName = "antibody_main", icon = icon("yandex-international"),
                 menuSubItem(
                   text = "WB",
                   tabName = "antibody_wb"
                 ),
                 menuSubItem(
                   text = "IHC",
                   tabName = "antibody_ihc"
                 ),
                 menuSubItem(
                   text = "FACS",
                   tabName = "antibody_facs"
                 )),
        menuItem("Cell Line", tabName = "celline_main", icon = icon("virus"),
                 menuSubItem(
                   text = "WB",
                   tabName = "celline_wb"
                 ),
                 menuSubItem(
                   text = "TD",
                   tabName = "celline_td"
                 ),
                 menuSubItem(
                   text = "DD",
                   tabName = "celline_dd"
                 )
        ),
        menuItem("Commercial Drug", tabName = "drug", icon = icon("capsules")),
        menuItem("Protein", tabName = "protein", icon = icon("share-alt")),
        menuItem("shRNA / siRNA", tabName = "shsirna", icon = icon("dna")),
        menuItem("CMC", tabName = "cmc_main", icon = icon("atom"),
                 menuSubItem(
                   text = "시약목록",
                   tabName = "cmc_siyac"
                 ),
                 menuSubItem(
                   text = "Column",
                   tabName = "cmc_column")
        ),
        menuItem("의약화학센터", tabName = "mc_main", icon = icon("prescription-bottle-alt"),
                 menuSubItem(
                   text = "시약목록",
                   tabName = "mc_siyac"
                 ),
                 menuSubItem(
                   text = "Column",
                   tabName = "mc_column"
                 ))
        
        # menuItem("Help", tabName = "help", icon = icon("volume-down"))
      )
    }

    
    sidebarMenu(.list = menu_list)
  })
    
  observeEvent(res_auth$role, {
    if(res_auth$role == "A"){
      output$valuebox1 <- collection_cnt(collection_name = "blood_collection", url = mongoUrl) %>%
        value_func(N = "Blood", tab_name = "blood", row_count = ., icon = icon("tint"), color = "red", role = T)

      output$valuebox2 <- collection_cnt(collection_name = "ff_collection", url = mongoUrl) %>%
        value_func(N = "FF", tab_name = "ff", row_count = ., icon = icon("diagnoses"), color = "orange", role = T)

      output$valuebox3 <- collection_cnt(collection_name = "ffpe_collection", url = mongoUrl) %>%
        value_func(N = "FFPE", tab_name = "ffpe", row_count = ., icon = icon("ruler"), color = "aqua", role = T)

      output$valuebox4 <- collection_cnt(collection_name = "pdx_collection", url = mongoUrl) %>%
        value_func(N = "PDX", tab_name = "pdx", row_count = ., icon = icon("prescription"), color = "purple", role = T)
    
    } else if(res_auth$role == "B"){
      output$valuebox1 <- collection_cnt(collection_name = "blood_collection", url = mongoUrl) %>%
        value_func(N = "Blood", tab_name = "blood", row_count = ., icon = icon("tint"), color = "red", role = T)
      
      output$valuebox2 <- collection_cnt(collection_name = "ff_collection", url = mongoUrl) %>%
        value_func(N = "FF", tab_name = "ff", row_count = ., icon = icon("diagnoses"), color = "orange", role = T)
      
      output$valuebox3 <- collection_cnt(collection_name = "ffpe_collection", url = mongoUrl) %>%
        value_func(N = "FFPE", tab_name = "ffpe", row_count = ., icon = icon("ruler"), color = "aqua", role = T)
      
      output$valuebox4 <- collection_cnt(collection_name = "pdx_collection", url = mongoUrl) %>%
        value_func(N = "PDX", tab_name = "pdx", row_count = ., icon = icon("prescription"), color = "purple")
    } else {
      output$valuebox1 <- collection_cnt(collection_name = "blood_collection", url = mongoUrl) %>%
        value_func(N = "Blood", tab_name = "blood", row_count = ., icon = icon("tint"), color = "red")
      
      output$valuebox2 <- collection_cnt(collection_name = "ff_collection", url = mongoUrl) %>%
        value_func(N = "FF", tab_name = "ff", row_count = ., icon = icon("diagnoses"), color = "orange")
      
      output$valuebox3 <- collection_cnt(collection_name = "ffpe_collection", url = mongoUrl) %>%
        value_func(N = "FFPE", tab_name = "ffpe", row_count = ., icon = icon("ruler"), color = "aqua")
      
      output$valuebox4 <- collection_cnt(collection_name = "pdx_collection", url = mongoUrl) %>%
        value_func(N = "PDX", tab_name = "pdx", row_count = ., icon = icon("prescription"), color = "purple")
      
    }
     
    # material, for all users
    # antibody cnt
    antibody_cnt <- collection_cnt(collection_name = "antibody_wb_collection", url = mongoUrl) +
      collection_cnt(collection_name = "antibody_ihc_collection", url = mongoUrl) +
      collection_cnt(collection_name = "antibody_facs_collection", url = mongoUrl)
    output$valuebox5 <- antibody_cnt %>%
      value_func(N = "Antibody (WB+IHC+FACS)", tab_name = "antibody_wb", row_count = ., icon = icon("yandex-international"), color = "fuchsia", role = T)
    
    # celline cnt
    celline_cnt <- collection_cnt(collection_name = "celline_wb_collection", url = mongoUrl) +
      collection_cnt(collection_name = "celline_td_collection", url = mongoUrl)
    output$valuebox6 <- celline_cnt %>% 
      value_func(N = "Cell Line (WB+TD)", tab_name = "celline_wb", row_count = ., icon = icon("virus"), color = "maroon", role = T)
    
    output$valuebox7 <- collection_cnt(collection_name = "drug_collection", url = mongoUrl) %>%
      value_func(N = "Commercial Drug", tab_name = "drug", row_count = ., icon = icon("capsules"), color = "teal", role = T)
    
    output$valuebox8 <- collection_cnt(collection_name = "protein_collection", url = mongoUrl) %>%
      value_func(N = "Protein", tab_name = "protein",row_count = ., icon = icon("share-alt"), color = "olive", role = T)
    
    output$valuebox9 <- collection_cnt(collection_name = "shsirna_collection", url = mongoUrl) %>%
      value_func(N = "shRNA / siRNA", tab_name = "shsirna", row_count = ., icon = icon("dna"), color = "lime", role = T)
    
    output$valuebox10 <- collection_cnt(collection_name = "cmc_reagent_collection", url = mongoUrl) %>%
      value_func(N = "CMC", tab_name = "cmc_siyac", row_count = ., icon = icon("atom"), color = "navy", role = T)
    
    output$valuebox11 <- collection_cnt(collection_name = "medicalchemistry_reagent_collection", url = mongoUrl) %>%
      value_func(N = "의약화학센터", tab_name = "mc_siyac", row_count = ., icon = icon("prescription-bottle-alt"), color = "black", role = T)
    
  })
  
  # DT ----
  
  # parent / child
  blood_Dat <- child_function(list_df = blood, result_df = blood_result)
  ff_Dat <- child_function_FF(list_df = ff, result_df = ff_result)
  ffpe_Dat <- child_function_FF(list_df = ffpe, result_df = ffpe_result)
  pdx_Dat <- child_function(list_df = pdx, result_df = pdx_result)
  
  # BLOOD DT
  output$blood_dt <- render_DT_child(DF_NAME = blood_Dat)
  
  # FF DT
  output$ff_dt <- render_DT_child(DF_NAME = ff_Dat)
  
  # FFPE DT
  output$ffpe_dt <- render_DT_child(DF_NAME = ffpe_Dat)
  
  # PDX DT
  output$pdx_dt <- render_DT_child(DF_NAME = pdx_Dat)

  # ANTIBODY DT
  output$antibody_wb_dt <- render_DT(antibody_wb)
  output$antibody_ihc_dt <- render_DT(antibody_ihc)
  output$antibody_facs_dt <- render_DT(antibody_facs)
  
  # CELLINE DT
  output$celline_wb_dt <- render_DT(celline_wb)
  output$celline_td_dt <- render_DT(celline_td)
  
  # DRUG DT
  output$drug_dt <- render_DT(drug)
  
  # PROTEIN DT
  output$protein_dt <- render_DT_rowgroup(protein)
  
  # shRNA/siRNA DT
  output$shsirna_dt <- render_DT_rowgroup(shsirna)
  
  # cmc dT
  output$cmc_siyac_dt <- render_DT(cmc_reagent)
  output$cmc_column_dt <- render_DT(cmc_reagent_column)
  
  # 의약화학센터 DT
  output$mc_siyac_dt <- render_DT(mc_reagent)
  output$mc_column_dt <- render_DT(mc_reagent_column)
  
  # TOTAL SEARCH ----
  observeEvent(res_auth$role, {
    if(res_auth$role == "A"){
      updatePickerInput(
        session = session, 
        inputId = "table_picker",
        label = "",
        choices = c("Blood", "FF", "FFPE", "PDX", "Antibody(WB)", "Antibody(IHC)", "Antibody(FACS)", "Cell Line(WB)", 
                    "Cell Line(TD)","Commercial Drug", "Protein", "siRNA/shRNA", "CMC(시약목록)", "CMC(Column)", "의약화학센터(시약목록)",
                    "의약화학센터(Column)"), 
        choicesOpt = list(
          content = c(
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Blood</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>FF</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>FFPE</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>PDX</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(WB)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(IHC)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(FACS)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(WB)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(TD)</div>",
            # "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(DD)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Commercial Drug</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Protein</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>siRNA/shRNA</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>CMC(시약목록)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>CMC(Column)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>의약화학센터(시약목록)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>의약화학센터(Column)</div>"
          )))     
    } else if(res_auth$role == "B"){
      updatePickerInput(
        session = session, 
        inputId = "table_picker",
        label = "",
        choices = c("Blood", "FF", "FFPE", "Antibody(WB)", "Antibody(IHC)", "Antibody(FACS)", "Cell Line(WB)", 
                    "Cell Line(TD)","Commercial Drug", "Protein", "siRNA/shRNA", "CMC(시약목록)", "CMC(Column)", "의약화학센터(시약목록)",
                    "의약화학센터(Column)"), 
        choicesOpt = list(
          content = c(
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Blood</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>FF</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>FFPE</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(WB)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(IHC)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(FACS)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(WB)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(TD)</div>",
            # "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(DD)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Commercial Drug</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Protein</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>siRNA/shRNA</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>CMC(시약목록)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>CMC(Column)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>의약화학센터(시약목록)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>의약화학센터(Column)</div>"
          ))) 
    } else {
      updatePickerInput(
        session = session, 
        inputId = "table_picker",
        label = "",
        choices = c("Antibody(WB)", "Antibody(IHC)", "Antibody(FACS)", "Cell Line(WB)", 
                    "Cell Line(TD)","Commercial Drug", "Protein", "siRNA/shRNA", "CMC(시약목록)", "CMC(Column)", "의약화학센터(시약목록)",
                    "의약화학센터(Column)"), 
        choicesOpt = list(
          content = c(
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(WB)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(IHC)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Antibody(FACS)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(WB)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(TD)</div>",
            # "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Cell Line(DD)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Commercial Drug</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>Protein</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>siRNA/shRNA</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>CMC(시약목록)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>CMC(Column)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>의약화학센터(시약목록)</div>",
            "<div style='color: black;text-align: center;font-size: 18px;font-weight: bold;'>의약화학센터(Column)</div>"
          ))) 
    }
  })
  
  observeEvent(input$table_picker, {
    table_select <- input$table_picker
    switch(table_select,
           `Blood` = {
             choices <- search_keyword(DF = blood, N_vec = c(3,4,6,7))
             updateSelectInput(
               inputId = "search",
               choices = choices
             )
           },
           `FF` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(DF = ff, N_vec = c(3,4,6,7))
             )
           },
           `FFPE` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(DF = ffpe, N_vec = c(3,4,6,7))
             )
           },
           `PDX` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(DF = pdx, N_vec = c(3,4,6,7))
             )
           },
           `Antibody(WB)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(antibody_wb, N_vec = c(2:10))
             )
           },
           `Antibody(IHC)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(antibody_ihc, N_vec = c(2:10))
             )
           },
           `Antibody(FACS)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(antibody_facs, N_vec = c(1:8))
             )
           },
           `Cell Line(WB)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(celline_wb, N_vec = c(1:4,6:14))
             )
           },
           `Cell Line(TD)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(celline_td, N_vec = c(2:11))
             )
           },
           `Commercial Drug` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(drug, N_vec = c(1,2,4,7,8))
             )
           },
           `Protein` = {
             updateSelectInput(
               inputId = "search",
               choices =search_keyword(protein, N_vec = c(1,2,3,4,5,7))
             )
           },
           `siRNA/shRNA` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(shsirna, N_vec = c(1,2,3,4,5,7,8,9,10,11,13))
             )
           },
           `siRNA/shRNA` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(shsirna, N_vec = c(1,2,3,4,5,7,8,9,10,11,13))
             )
           },
           
           `CMC(시약목록)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(cmc_reagent)
             )
           },
           `CMC(Column)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(cmc_reagent_column)
             )
           },
           `의약화학센터(시약목록)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(mc_reagent)
             )
           },
           `의약화학센터(Column)` = {
             updateSelectInput(
               inputId = "search",
               choices = search_keyword(mc_reagent_column)
             )
           }
    )
  }) # oberve
  observeEvent(input$ac_btn, {
    table_select <- input$table_picker
    search_keyword <- input$search

    switch(table_select,
      `Blood` = {
        blood_search <- blood %>% 
          filter_all(., any_vars(. == search_keyword)) %>% 
          child_function(list_df = ., result_df = blood_result)
        output$search_dt <- render_DT_search(blood_search, child = T)
        
        },
      `FF` = {
        ff_search <- ff %>% 
          filter_all(., any_vars(. == search_keyword)) %>% 
          child_function(list_df = ., result_df = ff_result)
        output$search_dt <- render_DT_search(ff_search, child = T)
      },
      `FFPE` = { 
        ffpe_search <- ffpe %>% 
          filter_all(., any_vars(. == search_keyword)) %>% 
          child_function(list_df = ., result_df = ffpe_result)
        output$search_dt <- render_DT_search(ffpe_search, child = T)
      },
      `PDX` = {
        pdx_search <- pdx %>% 
          filter_all(., any_vars(. == search_keyword)) %>% 
          child_function(list_df = ., result_df = pdx_result)
        output$search_dt <- render_DT_search(pdx_search, child = T)
      },
      `Antibody(WB)` = {
        antibody_wb_search <- antibody_wb %>% 
          filter_all(., any_vars(. == search_keyword)) 
        output$search_dt <- render_DT_search(antibody_wb_search)
      },
      `Antibody(IHC)` = {
        antibody_ihc_search <- antibody_ihc %>% 
          filter_all(., any_vars(. == search_keyword)) 
        output$search_dt <- render_DT_search(antibody_ihc_search)
      },
      `Antibody(FACS)` = {
        antibody_facs_search <- antibody_facs %>% 
          filter_all(., any_vars(. == search_keyword)) 
        output$search_dt <- render_DT_search(antibody_facs_search)
      },
      `Cell Line(WB)` = {
        celline_wb_search <- celline_wb %>% 
          filter_all(., any_vars(. == search_keyword)) 
        output$search_dt <- render_DT_search(celline_wb_search)
      },
      `Cell Line(TD)` = {
        celline_td_search <- celline_td %>% 
          filter_all(., any_vars(. == search_keyword)) 
        output$search_dt <- render_DT_search(celline_td_search)
      },
      `Commercial Drug` = {
        drug_search <- drug %>% 
          filter_all(., any_vars(. == search_keyword)) 
        output$search_dt <- render_DT_search(drug_search)
      },
      `Protein` = {
        protein_search <- protein %>% 
          filter_all(., any_vars(. == search_keyword))  
        output$search_dt <- render_DT_search(protein_search)
      },
      `siRNA/shRNA` = {
        shsirna_search <- shsirna %>% 
          filter_all(., any_vars(. == search_keyword))
        output$search_dt <- render_DT_search(shsirna_search)
      },
      `CMC(시약목록)` = {
        cmc_siyac_search <- cmc_reagent %>% 
          filter_all(., any_vars(. == search_keyword))
        output$search_dt <- render_DT_search(cmc_siyac_search)
      },
      `CMC(Column)` = {
        cmc_column_search <- cmc_reagent_column %>% 
          filter_all(., any_vars(. == search_keyword))
        output$search_dt <- render_DT_search(cmc_column_search)
      },
      `의약화학센터(시약목록)` = {
        mc_siyac_search <- mc_reagent %>% 
          filter_all(., any_vars(. == search_keyword))
        output$search_dt <- render_DT_search(mc_siyac_search)
      },
      `의약화학센터(Column)` = {
        mc_column_search <- mc_reagent_column %>% 
          filter_all(., any_vars(. == search_keyword))
        output$search_dt <- render_DT_search(mc_column_search)
      }
    )
  }) # oberveEvent
  observeEvent(input$re_btn, {
    output$search_dt <- NULL
  })
  # LiveCHAT ----
  # chat <- shiny.collections::collection("chat", connection)
  # updateTextInput(session, "username_field",
  #                 value = get_random_username()
  # )
  # 
  # observeEvent(input$send, {
  #   new_message <- list(user = input$username_field,
  #                       text = input$message_field,
  #                       time = Sys.time())
  #   shiny.collections::insert(chat, new_message)
  #   updateTextInput(session, "message_field", value = "")
  # })
  # 
  # output$chatbox <- renderUI({
  #   if (!is_empty(chat$collection)) {
  #     render_msg_divs(chat$collection)
  #   } else {
  #     tags$span("Empty chat")
  #   }
  # })
  

}