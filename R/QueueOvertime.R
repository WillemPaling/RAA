# QueueOvertime - Runs an OverTime Report
# Args:
#   reportsuite.id: report suite id
#   date.from: start date for the report (YYYY-MM-DD)
#   date.to: end date for the report (YYYY-MM-DD)
#   metrics: list of metrics to include in the report
#   date.granularity: time granularity of the report (year/month/week/day/hour), default to 'day'
#   segment.id: id of Adobe Analytics segment to retrieve the report for
#   data.current: TRUE or FALSE - whether to include current data for reports that include today's date
#   expedite: set to TRUE to expedite the processing of this report
#
# Returns:
#   Flat data frame containing datetimes and metric values
#

QueueOvertime <- function(reportsuite.id, date.from, date.to, metrics,
                        date.granularity='day', segment.id='', anomaly.detection='',
                        data.current='',expedite='') {
  
  # build JSON description
  report.description <- c()
  report.description$reportDescription <- c(data.frame(matrix(ncol=0, nrow=1)))
  report.description$reportDescription$dateFrom <- date.from
  report.description$reportDescription$dateTo <- date.from
  report.description$reportDescription$reportSuiteID <- reportsuite.id
  report.description$reportDescription$dateGranularity <- date.granularity
  report.description$reportDescription$segment_id <- segment.id
  report.description$reportDescription$anomalyDetection <- anomaly.detection
  report.description$reportDescription$currentData <- data.current
  report.description$reportDescription$expedite <- expedite
  report.description$reportDescription$metrics = list(data.frame(id = metrics))

  print(cat(toJSON(report.description)))
  print("THIS METHOD NEEDS WORK!!! JSON NOT IN THE RIGHT FORMAT!")

  #report.id <- ApiQueueReport(report.description)
  #report.data <- ApiGetReport(report.id)

  #return(report.data) 

} #End function bracket  
