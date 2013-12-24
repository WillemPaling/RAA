# ApiValidateReport - Internal function - Calls the API and attempts to validate a report description.
#
# Args:
#   report.description: JSON report description
#   interval.seconds: Time to wait between attempts to get the report (defaults to 2 seconds)
#   max.attempts: Max number of attempts to make to retrieve the report (defaults to 5)
#
# Returns:
#   TRUE/FALSE depending on whether the report is valid or not
#

ApiValidateReport <- function(report.description,interval.seconds=2,max.attempts=5) {
  
  report.validated <- FALSE
  num.tries <- 0
  
  while(report.validated==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("Report.Validate", report.description)
    queue.resp <- content(json.queue)
    
    # If we are in debug mode, save the output
    if(AADebug==TRUE) {
      print("Saving output as json.queue.validate.txt")
      sink("json.queue.validate.txt")
      cat(toJSON(queue.resp))
      sink()
      save(json.queue,file="json.queue.Rda")
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