#' RAA_Auth
#'
#' Authorise and store credentials for the Adobe Analytics API
#'
#' @param key client id from your app in the Adobe Marketing cloud Dev Center OR if you are using auth.method='legacy', then this is the API username (username:company)
#' @param secret secret from your app in the Adobe Marketing cloud Dev Center OR if you are using auth.method='legacy', then this is the API shared secret
#' @param endpoint.url your Adobe Analytics API endpoint
#' @param token.file if you would like to save your OAUTH token and other auth details for use in 
#' future sessions, specify a file here. The method checks for the existence of the file and uses that if available.
#' @param auth.method defaults to OAUTH2, can be set to 'legacy' to use the older () username:company and shared secret method.
#'
#' @imports httr oauth_app
#' @imports httr oauth_endpoint
#' @imports httr oauth2.0_token
#'
#' @export

RAA_Auth <- function(key, secret, endpoint.url="", token.file="", auth.method="OAUTH2"){

  RAA.Credentials <<- ""

  if(auth.method=="OAUTH2") {
    token.required = TRUE

    if(nchar(token.file)) {
      if(file.exists(token.file)) {
        load(token.file)
        RAA.Credentials <<- RAA.storedcredentials
        #@TODO: check if token has expired, and whether the endpoint matches before deciding
        token.required = FALSE
      }
    }
    
    if(token.required) {
      aa.api<- oauth_endpoint("https://marketing.adobe.com",
                            "https://marketing.adobe.com/authorize",
                            "https://api.omniture.com/token")

      aa.app <- oauth_app("RAA", key, secret)
      aa.cred <- oauth2.0_token(aa.api, aa.app, scope="ReportSuite Report")

      RAA.Credentials <<- list(endpoint.url=endpoint.url,auth.method=auth.method,aa.cred)

      if(nchar(token.file)) {
        RAA.storedcredentials <- RAA.Credentials
        save(RAA.storedcredentials,file=token.file)
      }
    }
  } else if (auth.method=="legacy") {

    error.flag = 0
    if(str_count(key, ":") != 1){
      warning("Check User Name. Must have 'username:company' pattern")
      error.flag = error.flag + 1
    }
    if(endpoint.url==""){
      warning("Error: No endpoint URL specified.")
      error.flag = error.flag + 1
    }
    if(nchar(secret) != 32){
      warning("Shared Secret does not have valid number of characters (32)")
      error.flag = error.flag + 1
    }
    
    if(error.flag >0){
      stop("Authentication failed due to errors")
    } else {
      company <- str_split_fixed(key, ":", 2)
      #Create SCCredentials object in Global Environment
      RAA.Credentials <<- list(key=key,secret=secret,auth.method=auth.method,endpoint.url=endpoint.url)
      save(RAA.Credentials,file="~/RAA.Credentials")
      #Assign endpoint to 3rd position in credentials
      print("Legacy Auth Stored: This method is deprecated. If possible, use OAUTH.")
    }

  }

}