#' ApiGetSuccessEvents
#'
#' Internal function - Calls the API and gets valid successevents
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of available successevents
#'
#' @family internal
#'

ApiGetSuccessEvents <- function(report.description="",interval.seconds=2,max.attempts=5) {
  
  successevents.received <- FALSE
  num.tries <- 0

  while(successevents.received==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("ReportSuite.GetSuccessEvents", report.description)

    if(json.queue$status==200) {
      successevents.received <- TRUE
      successevents.list <- fromJSON(content(json.queue,"text"))
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    print("Saving output as json.queue.getsuccessevents.txt")
    sink("json.queue.getsuccessevents.txt")
    cat(toJSON(successevents.list))
    sink()
    save(json.queue,file="json.queue.getsuccessevents.Rda")
  }

  # If we couldn't validate the report, then stop
  if(!successevents.received){
    stop("Error: Number of Tries Exceeded")
  }

  return(successevents.list)
}