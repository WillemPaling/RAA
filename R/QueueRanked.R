#' QueueRanked
#'
#' Helper function to run a Ranked Report
#'
#' @param reportsuite.id report suite id
#' @param date.from start date for the report (YYYY-MM-DD)
#' @param date.to end date for the report (YYYY-MM-DD)
#' @param metrics list of metrics to include in the report
#' @param elements list of elements to include in the report
#' @param top number of elements to include (top X) - only applies to the first element.
#' @param start start row if you do not want to start at #1 - only applies to the first element.
#' @param selected list of specific items to include in the report - e.g. list(page=c("Home","Search","About")). 
#' This appears to only work for the first element.
#' @param segment.id id of Adobe Analytics segment to retrieve the report for
#' @param anomaly.dection  set to TRUE to include forecast data (only valid for day granularity with small date ranges)
#' @param data.current TRUE or FALSE - whether to include current data for reports that include today's date
#' @param expedite set to TRUE to expedite the processing of this report
#'
#' @return Flat data frame containing datetimes and metric values
#'
#' @export

QueueRanked <- function(reportsuite.id, date.from, date.to, metrics, elements,
                        top=0,start=0,selected=list(),
                        segment.id='', data.current=FALSE, expedite=FALSE) {

  # build JSON description
  # we have to use jsonlite:::as.scalar to force jsonlist not put strings into single-element arrays
  report.description <- c()
  report.description$reportDescription <- c(data.frame(matrix(ncol=0, nrow=1)))
  report.description$reportDescription$dateFrom <- jsonlite:::as.scalar(date.from)
  report.description$reportDescription$dateTo <- jsonlite:::as.scalar(date.to)
  report.description$reportDescription$reportSuiteID <- jsonlite:::as.scalar(reportsuite.id)
  if(top>0) { 
    report.description$reportDescription$top <- jsonlite:::as.scalar(top) 
  }
  if(start>0) { 
    report.description$reportDescription$start <- jsonlite:::as.scalar(start) 
  }
  if(segment.id!="") { 
    report.description$reportDescription$segment_id <- jsonlite:::as.scalar(segment.id) 
  }
  if(expedite==TRUE) { 
    report.description$reportDescription$expedite <- jsonlite:::as.scalar(expedite)
  }
  report.description$reportDescription$metrics = data.frame(id = metrics)

  if(length(selected)>0) {
    # build up each element with selections
    elements.formatted <- list()
    i <- 0
    for(element in elements) {
      i <- i + 1
      if(length(selected[element])){
        if(i==1) {
          # put in top and startingWith for the first element only
          working.element = list(id = jsonlite:::as.scalar(element), 
                                      top = jsonlite:::as.scalar(top), 
                                      startingWith = jsonlite:::as.scalar(start), 
                                      selected = selected[element][1][[1]])
        } else {
          working.element <- list(id = jsonlite:::as.scalar(element), selected=selected[element][1][[1]])
        }
      }
      if(length(elements.formatted)>0) {
        elements.formatted <- rbind(elements.formatted,working.element)
      } else {
        elements.formatted <- working.element
      }
    }
    report.description$reportDescription$elements <- elements.formatted
  } else {
    # just plug in the elements
    report.description$reportDescription$elements <- data.frame(id = elements)
  }

  report.id <- ApiQueueReport(report.description)
  report.data <- ApiGetReport(report.id)

  return(report.data) 

}  
