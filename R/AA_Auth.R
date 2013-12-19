#Store credentials as character vector for later usage

# @TODO: Update to use OAUTH

utils::globalVariables("AACredentials")

AA_Auth <- function(user_name, shared_secret, endpoint_url=""){
  #Silence visible binding error
  
  AACredentials <- ""
  
  error_flag = 0
  if(str_count(user_name, ":") != 1){
    warning("Check User Name. Must have 'username:company' pattern")
    error_flag = error_flag + 1
  }
  if(endpoint_url==""){
    warning("Error: No endpoint URL specified.")
    error_flag = error_flag + 1
  }
  if(nchar(shared_secret) != 32){
    warning("Shared Secret does not have valid number of characters (32)")
    error_flag = error_flag + 1
  }
  
  if(error_flag >0){
    stop("Authentication failed due to errors")
  } else {
    company <- str_split_fixed(user_name, ":", 2)
    #Create SCCredentials object in Global Environment
    AACredentials <<- c(user_name, shared_secret)
    #Assign endpoint to 3rd position in credentials
    AACredentials[3] <<- endpoint_url
    print("Auth stored: THIS SHOULD USE OAUTH!!")
  }
} #End function bracket  