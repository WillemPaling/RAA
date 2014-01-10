#' GetReportSuites
#'
#' Gets available report suite reportsuites
#'
#' @return List of valid reportsuites
#'
#' @export

GetReportSuites <- function() {
  
  request.body <- c()
  request.body$rsid_list <- reportsuite.id

  reportsuites <- ApiRequest(body=toJSON(request.body),func.name="Company.GetReportSuites")

  return(reportsuites$report_suites)

}