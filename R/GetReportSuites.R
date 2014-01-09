#' GetReportSuites
#'
#' Gets available report suite reportsuites
#'
#' @return List of valid reportsuites
#'
#' @export

GetReportSuites <- function() {
  
  report.description <- c()
  report.description$rsid_list <- reportsuite.id

  reportsuites <- ApiGetReportSuites()

  return(reportsuites$report_suites)

}