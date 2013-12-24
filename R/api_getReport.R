# api_getReport
# Internal function
# Calls the API and attempts to get a previously queued report.
# If report is not available, wait 5 seconds and try again.

api_getReport <- function(report_id,interval_seconds=5,max_attempts=120) {
  
  report_ready <- FALSE
  num_tries <- 0
  report_json <- paste('{"reportID":"',report_id,'"}',sep="")
  
  while(report_ready==FALSE && num_tries < max_attempts){
    num_tries <- num_tries + 1
    print(paste("Checking report status: attempt #", num_tries,sep=""))
    request_data <- postRequest("Report.Get",report_json)
    save(request_data,file="request_data.Rda")
    if(request_data$status==200){
      report_data <- fromJSON(content(request_data,"text"))
      report_ready <- !isTRUE(report_data$error=="report_not_ready") 
    }
    if(report_ready==FALSE) {
      print(request_data$status)
      Sys.sleep(interval_seconds)
    }
  }
  
  # If we still don't have a report, return an error. 
  # Else, continue to GetReport.
  if(isTRUE(report_data$error=="report_not_ready")){
    stop("Error: Number of Tries Exceeded")
  }

  report_type <- report_data$report$type
  print(paste("Received ",report_type," report.",sep=""))

  # If we are in debug mode, save the output
  if(AADebug==TRUE) {
    print("Saving output as json_reponse.txt")
    sink("json_response.txt")
    cat(toJSON(report_data))
    sink()
    save(report_data,file="report_data.Rda")
  }

  return(switch(report_type,
    ranked={parseRanked(report_data)},
    trended={parseTrended(report_data)},
    pathing={parsePathing(report_data)},
    fallout={parseFallout(report_data)},
    overtime={parseOvertime(report_data)}
  ))

}