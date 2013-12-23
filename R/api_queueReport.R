# api_queueReport
# Internal function
# Calls the API and attempts to queue a report. If we get a 500 error, it tries again.
# The retries are in place to deal with server errors from the beta API endpoint.

api_queueReport <- function(report_description,interval_seconds=2,max_attempts=5) {
  
  report_queued <- FALSE
  num_tries <- 0
  
  while(report_queued==FALSE && num_tries < max_attempts){
    num_tries <- num_tries + 1
    json_queue <- postRequest("Report.Queue", report_description)
    report_queued <- isTRUE(json_queue$status==200)
    if(report_queued==FALSE) {
      Sys.sleep(interval_seconds)
    }
  }
  
  if(json_queue$status == 200) {
    #Convert JSON to list
    queue_resp <- content(json_queue)
  } else {
    queue_resp <- content(json_queue)
    print(paste("ERROR: ",queue_resp$error))
    print(queue_resp$error_description)
    stop()
  }
  
  #If response returns an error, return error message. Else, continue with capturing report ID
  if(!is.numeric(queue_resp$reportID)) {
    stop("Error: Likely a syntax error or missing required argument to QueueReport function")
  } else {
    report_id <- queue_resp$reportID
  }
  
  return(report_id)
  
}