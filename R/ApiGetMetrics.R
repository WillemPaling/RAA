#' ApiGetMetrics
#'
#' Internal function - Calls the API and gets valid metrics for specified params
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @imports httr content
#' @imports jsonlite toJSON
#'
#' @return list of valid metrics

ApiGetMetrics <- function(report.description,interval.seconds=2,max.attempts=5) {
  
  report.validated <- FALSE
  num.tries <- 0
  
  while(report.validated==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("Report.GetMetrics", report.description)
    queue.resp <- content(json.queue)
    
    # If we are in debug mode, save the output
    if(RAA.Debug==TRUE) {
      print("Saving output as json.queue.getmetrics.txt")
      sink("json.queue.getmetrics.txt")
      cat(toJSON(queue.resp))
      sink()
      save(json.queue,file="json.queue.getmetrics.Rda")
    }

    report.validated <- (isTRUE(queue.resp$valid) || isTRUE(nchar(queue.resp$error)>0))
    if(report.validated==FALSE) {
      Sys.sleep(interval.seconds)
    }
  }
 
   # If we couldn't validate the report, then stop
  if(!report.validated){
    stop("Error: Number of Tries Exceeded")
  }

  if(isTRUE(queue.resp$valid)) {
    return(TRUE)
  } else {
    print(queue.resp$error_description)
    return(FALSE)
  }
}