#' ApiGetReportSuites
#'
#' Internal function - Calls the API and gets valid reportsuites for specified params
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of valid reportsuites
#'
#' @family internal
#'

ApiGetReportSuites <- function(interval.seconds=2,max.attempts=5) {
  
  reportsuites.received <- FALSE
  num.tries <- 0

  while(reportsuites.received==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("Company.GetReportSuites")

    if(json.queue$status==200) {
      reportsuites.received <- TRUE
      reportsuites.list <- fromJSON(content(json.queue,"text"))
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    print("Saving output as json.queue.getreportsuites.txt")
    sink("json.queue.getreportsuites.txt")
    cat(toJSON(reportsuites.list))
    sink()
    save(json.queue,file="json.queue.getreportsuites.Rda")
  }

  # If we couldn't validate the report, then stop
  if(!reportsuites.received){
    stop("Error: Number of Tries Exceeded")
  }

  return(reportsuites.list)
}