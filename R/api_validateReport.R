# api_validateReport
# Internal function
# Calls the API and attempts to validate a report description.

api_validateReport <- function(report_description,interval_seconds=2,max_attempts=5) {
  
  report_validated <- FALSE
  num_tries <- 0
  
  while(report_validated==FALSE && num_tries < max_attempts){
    num_tries <- num_tries + 1
    json_queue <- postRequest("Report.Validate", report_description)
    queue_resp <- content(json_queue)
    
    # If we are in debug mode, save the output
    if(AADebug==TRUE) {
      print("Saving output as json_queue_validate.txt")
      sink("json_queue_validate.txt")
      cat(toJSON(report_data))
      sink()
      save(json_queue,file="json_queue.Rda")
    }

    report_validated <- (isTRUE(queue_resp$valid) || isTRUE(nchar(queue_resp$error)>0))
    if(report_validated==FALSE) {
      Sys.sleep(interval_seconds)
    }
  }
 
   # If we couldn't validate the report, then stop
  if(!report_validated){
    stop("Error: Number of Tries Exceeded")
  }

  if(isTRUE(queue_resp$valid)) {
    return(TRUE)
  } else {
    print(paste("Invalid Report Description:",queue_resp$error_description))
    return(FALSE)
  }
}