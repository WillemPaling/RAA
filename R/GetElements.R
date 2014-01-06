#' GetElements
#'
#' Gets valid elements for current user, valid with optionally specified existing metrics, elements and date granularity
#'
#' @param reportsuite.id report suite id
#' @param metrics list of existing metrics you want to use in combination with an additional metric
#' @param elements list of existing elements you want to use in combination with an additional metric
#' @param date.granularity granularity that you want to combine with an additional metric
#'
#' @return List of valid elements
#'
#' @export

GetElements <- function(reportsuite.id, metrics=c(), elements=c(), date.granularity='') {
  
  report.description <- c()
  report.description$reportSuiteID <- jsonlite:::as.scalar(reportsuite.id)

  if(length(metrics)>0) { 
    report.description$reportDescription$existingElements <- metrics
  }
  if(length(elements)>0) { 
    report.description$reportDescription$existingElements <- elements
  }
  if(nchar(date.granularity)>0) { 
    report.description$reportDescription$dateGranularity <- jsonlite:::as.scalar(date.granularity) 
  }

  valid.elements <- ApiGetElements(report.description=toJSON(report.description))

  return(valid.elements)

}