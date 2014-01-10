#' ApiRequest
#'
#' Internal function - Calls the API and gets valid evars for specified params
#'
#' @param report.description JSON report description
#' @param func.name the name of the Adobe Analytics API function that we are calling
#' @param interval.seconds Time to wait between request attempts (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make the request (defaults to 1, this is only increased for GetReport)
#' @param print.attempts if set to TRUE, this will print attempt numbers to the console
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of available evars
#'
#' @family internal
#'

ApiRequest <- function(body="",func.name="",interval.seconds=2,max.attempts=1,print.attempts=FALSE) {
  
  http.response <- PostRequest(func.name, body,interval.seconds=interval.seconds,max.attempts=max.attempts,print.attempts=print.attempts)
  data <- fromJSON(content(http.response,"text"))

  return(data)

}