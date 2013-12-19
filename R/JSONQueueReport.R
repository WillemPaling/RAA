# JSONQueueReport
# JSONQueueReport generic interface to Report.Queue
# Primarily used for debugging, data is not returned in a useful structure for use in R

JSONQueueReport <- function(report_description) {
  
  json_queue <- postRequest("Report.Queue", report_description)
  save(json_queue,file="json_queue.Rda")
  
  if(json_queue$status == 200) {
    #Convert JSON to list
    queue_resp <- content(json_queue)
  } else {
    queue_resp <- content(json_queue)
    print(paste("ERROR: ",queue_resp$error))
    print(queue_resp$error_description)
    stop()
  }
  
  #If response returns an error, return error message. Else, continue with
  #capturing report ID
  if(!is.numeric(queue_resp$reportID)) {
    stop("Error: Likely a syntax error or missing required argument to QueueReport function")
  } else {
    report_id <- queue_resp$reportID
  }
  
  report_data <- getReport(report_id)
  
  print("Saving output as json_reponse.txt")
  sink("json_reponse.txt")
  cat(toJSON(report_data))
  sink()
  
  save(report_data,file="report_data.Rda")
  
  return(report_data)
  
} #End function bracket
