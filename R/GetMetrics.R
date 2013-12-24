# GetMetrics - Gets valid metrics for current user, valid with optionally specified existing metrics, elements and date granularity
# Args:
#   reportsuite.id: report suite id
#   metrics: list of existing metrics you want to use in combination with an additional metric
#   elements: list of existing elements you want to use in combination with an additional metric
#   date.granularity: granularity that you want to combine with an additional metric
#
# Returns:
#   List of valid metrics
#

GetMetrics <- function(reportsuite.id, metrics=c(), elements=c(), date.granularity='') {
  
  report.description <- paste("{ 'reportDescription':{ 'reportSuiteID':'",reportsuite.id,"','existingElements':",toJSON(elements),",'existingMetrics':",toJSON(metrics),",'dateGranularity':'",date.granularity,"'}}",sep="")
  print(report.description)
  metrics <- ApiGetMetrics(report.description)
  return(metrics) 

} #End function bracket  
