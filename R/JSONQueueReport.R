# JSONQueueReport
# JSONQueueReport generic interface to Report.Queue
# Primarily used for debugging, data is not returned in a useful structure for use in R

JSONQueueReport <- function(report_description) {

  if(api_validateReport(report_description)) {
    report_id <- api_queueReport(report_description)
    report_data <- api_getReport(report_id)
    return(report_data)
  } else {
    print("ERROR: Invalid report description.")
  }
  
} #End function bracket