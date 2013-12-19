# getReport
# Internal function
# Attempts to get a previously queued report, if report is not available, wait 5 seconds and try again

getReport <- function(report_id,interval_seconds=5,max_attempts=120) {
  report_ready <- FALSE
  num_tries <- 0
  report_json <- paste('{"reportID":"',toJSON(report_id),'"}',sep="")
  while(report_ready==FALSE && num_tries < max_attempts){
    num_tries <- num_tries + 1
    print(paste("Checking report status: attempt #", num_tries,sep=""))
    request_data <- postRequest("Report.Get",report_json)
    save(request_data,file="request_data.Rda")
    report_data <- content(request_data)
    report_ready <- isTRUE(report_data$error=="report_not_ready")
    Sys.sleep(interval_seconds)
  }
  # If we still don't have a report, return an error. 
  # Else, continue to GetReport.
  if(isTRUE(report_data$error=="report_not_ready")){
    stop("Error: Number of Tries Exceeded")
  }

  report_type <- report_data$report$type
  print(paste("Received ",report_type," report.",sep=""))
  return(report_data)
}