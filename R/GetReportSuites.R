#' GetReportSuites
#'
#' Gets available report suite reportsuites
#'
#' @return List of valid reportsuites
#'
#' @export

GetReportSuites <- function() {

  reportsuites <- ApiRequest(func.name="Company.GetReportSuites")

  return(reportsuites$report_suites)

}