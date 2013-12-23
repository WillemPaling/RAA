# QueueReport
# QueueReport is the generic reporting interface for the 1.4 API
# 
# The API detects the report type based on the combination of metrics, elements and dateGranularity

QueueReport <- function(reportSuiteID, dateFrom, dateTo, metrics, elements, 
                        dateGranularity='', segmentId='',inlineSegment='',anomalyDetection='', 
                        currentData='',expedite='') {
  
  report_id <- api_queueReport(report_description)
  report_data <- api_getReport(report_id)

  return(report_data) 

} #End function bracket  
