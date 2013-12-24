# JsonQueueReport - Internal Function - Generic interface to validate, queue and retrieve a report from the API
# Args:
#   report.description: JSON report description
#
# Returns:
#   Formatted data frame
#

JsonQueueReport <- function(report.description) {

  if(ApiValidateReport(report.description)) {
    report.id <- ApiQueueReport(report.description)
    report.data <- ApiGetReport(report.id)
    return(report.data)
  } else {
    print("ERROR: Invalid report description.")
  }
  
}