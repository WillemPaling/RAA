#' ParseTrended
#'
#' Internal Function - Build generic POST request for Adobe Analytics API
#'
#' @param method Adobe Analytics API method (Report.Queue, Report.Get etc)
#' @param body body of post request, same usage as for HTTR POST()
#'
#' @imports httr POST
#' @imports httr add_headers
#'
#' @return HTTR response object

PostRequest <- function(method,body=NULL){

  url <- BuildURL(method)
  if(RAA.Debug) {
    print(paste("Requesting URL: ",url))
  }
  if(RAA.Credentials$auth.method=="OAUTH2") {
    return(POST(BuildURL(method), body=body))
  } else if(RAA.Credentials$auth.method=="legacy") {
    return(POST(BuildURL(method), add_headers(BuildHeader()), body=body))
  }
  
}