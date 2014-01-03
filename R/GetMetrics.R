#' GetMetrics
#'
#' Gets valid metrics for current user, valid with optionally specified existing metrics, elements and date granularity
#'
#' @param reportsuite.id report suite id
#' @param metrics list of existing metrics you want to use in combination with an additional metric
#' @param elements list of existing elements you want to use in combination with an additional metric
#' @param date.granularity granularity that you want to combine with an additional metric
#'
#' @return List of valid metrics
#'
#' @export

GetMetrics <- function(reportsuite.id, metrics=c(), elements=c(), date.granularity='') {
  
  print("GetMetrics: @TODO - this is not yet working.")
  report.description <- paste("{ 'reportDescription':{ 'reportSuiteID':'",reportsuite.id,"','existingElements':",toJSON(elements),",'existingMetrics':",toJSON(metrics),",'dateGranularity':'",date.granularity,"'}}",sep="")
  metrics <- ApiGetMetrics(report.description)
  return(metrics) 

}  
