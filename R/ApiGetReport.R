# ApiGetReport - Internal function - retrieves specified report from Adobe Analytics API, if it is not available, it tries again after interval.seconds, up to max.attempts times
#
# Args:
#   report.id: Report ID returned from the API by Report.Queue
#   interval.seconds: Time to wait between attempts to get the report (defaults to 5 seconds)
#   max.attempts: Max number of attempts to make to retrieve the report (defaults to 120)
#
# Returns:
#   Formatted data frame containing the report
#

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
  if(AA.Debug==TRUE) {
    print("Saving output as json.reponse.txt")
    sink("json.response.txt")
    cat(toJSON(report.data))
    sink()
    save(report.data,file="report.data.Rda")
  }

  # Check if there is any data to parse
  if(length(report.data$report$data)>0) {
    report.parsed = switch(report.type,
      ranked={ParseRanked(report.data)},
      trended={ParseTrended(report.data)},
      pathing={ParsePathing(report.data)},
      fallout={ParseFallout(report.data)},
      overtime={ParseOvertime(report.data)}
    )
  } else {
    print("Warning: Your report definition returned an empty data set.")
    report.parsed = data.frame()
  }
}