# you can use keyring package to set database key
# library(keyring)
# key_set("R-shinymanager-key", "sempre813!")

library(shinymanager)

# LOGIN DB INIT
credentials <- data.frame(
  user = c("wmbio"),
  password = c("sempre813!"),
  # password will automatically be hashed
  admin = c(TRUE),
  role = c("A"),
  stringsAsFactors = FALSE
)

# Init the database
create_db(
  credentials_data = credentials,
  sqlite_path = "/Users/wmbio/Desktop/gitworking/Material-Shiny/data/wmbio_users.sqlite", 
  #passphrase = key_get("R-shinymanager-key", "sempre813!")
  passphrase = "passphrase_wihtout_keyring"
)
