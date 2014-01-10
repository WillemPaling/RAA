#' ParseTrended
#'
#' Internal Function - Build generic POST request for Adobe Analytics API
#'
#' @param method Adobe Analytics API method (Report.Queue, Report.Get etc)
#' @param body body of post request, same usage as for HTTR POST()
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 1)
#' @param print.attempts if set to TRUE, this will print attempt numbers to the console
#'
#' @importFrom httr POST
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return HTTR response object
#'
#' @family internal
#'

PostRequest <- function(method,body=NULL,interval.seconds=2,max.attempts=1,print.attempts=FALSE){

  url <- BuildURL(method)

  if(RAA.Debug) {
    print(paste("Requesting URL: ",url))
  }

  result <- FALSE
  num.tries <- 0

  while(result==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    if(print.attempts==TRUE) {
      print(paste("Requesting URL attempt #",num.tries,sep=""))
    }
    if(RAA.Credentials$auth.method=="OAUTH2") {
      response <- POST(url, body=body)
    } else if(RAA.Credentials$auth.method=="legacy") {
      response <- POST(url, add_headers(BuildHeader()), body=body)
    }
    if(response$status==200) {
      result <- TRUE
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  if(!result){
    print(paste("ERROR: max attempts exceeded for",url))
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    filename <- paste("PostRequest_",sub(":","-",Sys.time()),".json",sep="")
    print(paste("DEBUG: saving output as",filename))
    sink(filename)
    cat(toJSON(content(response)))
    sink()
  }

  return(response)
  
}