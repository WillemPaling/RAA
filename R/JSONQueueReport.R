# JsonQueueReport
# JsonQueueReport generic interface to Report.Queue
# Primarily used for debugging, data is not returned in a useful structure for use in R

JsonQueueReport <- function(report.description) {

  if(ApiValidateReport(report.description)) {
    report.id <- ApiQueueReport(report.description)
    report.data <- ApiGetReport(report.id)
    return(report.data)
  } else {
    print("ERROR: Invalid report description.")
  }
  
} #End function bracket