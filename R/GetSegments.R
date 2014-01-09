#' GetSegments
#'
#' Gets available report suite segments
#'
#' @param reportsuite.ids report suite id (or list of report suite ids)
#'
#' @return List of valid segments
#'
#' @export

GetSegments <- function(reportsuite.ids) {
  
  report.description <- c()
  report.description$rsid_list <- reportsuite.id

  valid.segments <- ApiGetSegments(report.description=toJSON(report.description))

  for (i in 1:length(valid.segments$rsid) ) {
    valid.segments$segments[[i]]$report_suite <- valid.segments$rsid[[i]]
  }

  return(valid.segments$segments)

}