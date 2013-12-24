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
                        date.granularity='day', segment.id='', 
                        data.current='',expedite='') {
  
  report.id <- ApiQueueReport(report.description)
  report.data <- ApiGetReport(report.id)

  return(report.data) 

} #End function bracket  
