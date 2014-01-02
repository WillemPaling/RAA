# Store credentials as character vector for later usage

# @TODO: Update to use OAUTH

utils::globalVariables("RAA.Credentials")

RAA_Auth <- function(key, secret, endpoint.url=""){

  RAA_SetDebug(FALSE)
  RAA.Credentials <<- ""
  
  aa.api<- oauth_endpoint("https://marketing.adobe.com",
                          "https://marketing.adobe.com/authorize",
                          "https://api.omniture.com/token")

  aa.app <- oauth_app("RAA", key, secret)
  aa.cred <- oauth2.0_token(RAA_api, myapp)

  RAA.Credentials <<- c(endpoint.url,aa.cred)

  print(RAA.Credentials)

} #End function bracket