#' ApiGetMetrics
#'
#' Internal function - Calls the API and gets valid metrics for specified params
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of valid metrics
#'
#' @family internal
#'

ApiGetMetrics <- function(report.description="",reportsuite.id="",interval.seconds=2,max.attempts=5) {
  
  metrics.received <- FALSE
  num.tries <- 0

  while(metrics.received==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("Report.GetMetrics", report.description)

    if(json.queue$status==200) {
      metrics.received <- TRUE
      metrics.list <- fromJSON(content(json.queue,"text"))
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    print("Saving output as json.queue.getmetrics.txt")
    sink("json.queue.getmetrics.txt")
    cat(toJSON(metrics.list))
    sink()
    save(json.queue,file="json.queue.getmetrics.Rda")
  }

  # If we couldn't validate the report, then stop
  if(!metrics.received){
    stop("Error: Number of Tries Exceeded")
  }

  return(metrics.list)
}