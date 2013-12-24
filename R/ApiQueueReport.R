# ApiQueueReport
# Internal function
# Calls the API and attempts to queue a report. If we get a 500 error, it tries again.
# The retries are in place to deal with server errors from the beta API endpoint.

ApiQueueReport <- function(report.description,interval.seconds=2,max.attempts=5) {
  
  report.queued <- FALSE
  num.tries <- 0
  
  while(report.queued==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("Report.Queue", report.description)
    report.queued <- isTRUE(json.queue$status==200)
    if(report.queued==FALSE) {
      Sys.sleep(interval.seconds)
    }
  }
  
  if(json.queue$status == 200) {
    #Convert JSON to list
    queue.resp <- content(json.queue)
  } else {
    queue.resp <- content(json.queue)
    print(paste("ERROR: ",queue.resp$error))
    print(queue.resp$error_description)
    stop()
  }
  
  #If response returns an error, return error message. Else, continue with capturing report ID
  if(!is.numeric(queue.resp$reportID)) {
    stop("Error: Likely a syntax error or missing required argument to QueueReport function")
  } else {
    report.id <- queue.resp$reportID
  }
  
  return(report.id)
  
}