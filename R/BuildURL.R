#' BuildURL
#'
#' Internal Function - Builds URL string for Adobe Analytics API call
#'
#' @param method Adobe Analytics API method
#'
#' @return URL string (concatenation of endpoint, method and access key)
#'
#' @family internal
#'

BuildURL <- function(method){
  #Get endpoint from RAA.Credentials position 3
  endpoint <- RAA.Credentials$endpoint
  if(RAA.Credentials$auth.method=="OAUTH2") {
    return(paste(endpoint, "?method=",method,"&access_token=",RAA.Credentials$access_token, sep=""))
  } else if(RAA.Credentials$auth.method=="legacy") {
    return(paste(endpoint, "?method=",method, sep=""))
  }

}