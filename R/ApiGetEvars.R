#' ApiGetEvars
#'
#' Internal function - Calls the API and gets valid evars for specified params
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of available evars
#'
#' @family internal
#'

ApiGetEvars <- function(report.description="",interval.seconds=2,max.attempts=5) {
  
  evars.received <- FALSE
  num.tries <- 0

  while(evars.received==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    print(report.description)
    json.queue <- PostRequest("ReportSuite.GetEvars", report.description)

    if(json.queue$status==200) {
      evars.received <- TRUE
      evars.list <- fromJSON(content(json.queue,"text"))
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    print("Saving output as json.queue.getevars.txt")
    sink("json.queue.getevars.txt")
    cat(toJSON(evars.list))
    sink()
    save(json.queue,file="json.queue.getevars.Rda")
  }

  # If we couldn't validate the report, then stop
  if(!evars.received){
    stop("Error: Number of Tries Exceeded")
  }

  return(evars.list)
}