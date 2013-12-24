# Store credentials as character vector for later usage

# @TODO: Update to use OAUTH

utils::globalVariables("AA.Credentials")

AA_Auth <- function(user.name, shared.secret, endpoint.url=""){
  #Silence visible binding error
  
  AA.Credentials <- ""
  
  error.flag = 0
  if(str_count(user.name, ":") != 1){
    warning("Check User Name. Must have 'username:company' pattern")
    error.flag = error.flag + 1
  }
  if(endpoint.url==""){
    warning("Error: No endpoint URL specified.")
    error.flag = error.flag + 1
  }
  if(nchar(shared.secret) != 32){
    warning("Shared Secret does not have valid number of characters (32)")
    error.flag = error.flag + 1
  }
  
  if(error.flag >0){
    stop("Authentication failed due to errors")
  } else {
    company <- str_split_fixed(user.name, ":", 2)
    #Create SCCredentials object in Global Environment
    AA.Credentials <<- c(user.name, shared.secret)
    #Assign endpoint to 3rd position in credentials
    AA.Credentials[3] <<- endpoint.url
    print("Auth stored: THIS SHOULD USE OAUTH!!")
  }
} #End function bracket  