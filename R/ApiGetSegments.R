#' ApiGetSegments
#'
#' Internal function - Calls the API and gets valid segments for specified params
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of available segments
#'
#' @family internal
#'

ApiGetSegments <- function(report.description="",interval.seconds=2,max.attempts=5) {
  
  segments.received <- FALSE
  num.tries <- 0

  while(segments.received==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("ReportSuite.GetSegments", report.description)

    if(json.queue$status==200) {
      segments.received <- TRUE
      segments.list <- fromJSON(content(json.queue,"text"))
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    print("Saving output as json.queue.getsegments.txt")
    sink("json.queue.getsegments.txt")
    cat(toJSON(segments.list))
    sink()
    save(json.queue,file="json.queue.getsegments.Rda")
  }

  # If we couldn't validate the report, then stop
  if(!segments.received){
    stop("Error: Number of Tries Exceeded")
  }

  return(segments.list)
}