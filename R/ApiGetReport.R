# ApiGetReport
# Internal function
# Calls the API and attempts to get a previously queued report.
# If report is not available, wait 5 seconds and try again.

ApiGetReport <- function(report.id,interval.seconds=5,max.attempts=120) {
  
  report.ready <- FALSE
  num.tries <- 0
  report.json <- paste('{"reportID":"',report.id,'"}',sep="")
  
  while(report.ready==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    print(paste("Checking report status: attempt #", num.tries,sep=""))
    request.data <- PostRequest("Report.Get",report.json)
    save(request.data,file="request.data.Rda")
    if(request.data$status==200){
      report.data <- fromJSON(content(request.data,"text"))
      report.ready <- !isTRUE(report.data$error=="report_not_ready") 
    }
    if(report.ready==FALSE) {
      print(request.data$status)
      Sys.sleep(interval.seconds)
    }
  }
  
  # If we still don't have a report, return an error. 
  # Else, continue to GetReport.
  if(isTRUE(report.data$error=="report_not_ready")){
    stop("Error: Number of Tries Exceeded")
  }

  report.type <- report.data$report$type
  print(paste("Received ",report.type," report.",sep=""))

  # If we are in debug mode, save the output
  if(AADebug==TRUE) {
    print("Saving output as json.reponse.txt")
    sink("json.response.txt")
    cat(toJSON(report.data))
    sink()
    save(report.data,file="report.data.Rda")
  }

  return(switch(report.type,
    ranked={ParseRanked(report.data)},
    trended={ParseTrended(report.data)},
    pathing={ParsePathing(report.data)},
    fallout={ParseFallout(report.data)},
    overtime={ParseOvertime(report.data)}
  ))

}