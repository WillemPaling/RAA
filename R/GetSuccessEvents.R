#' GetSuccessEvents
#'
#' Gets available report suite successevents
#'
#' @param reportsuite.ids report suite id (or list of report suite ids)
#'
#' @return List of valid successevents
#'
#' @export

GetSuccessEvents <- function(reportsuite.ids) {

  request.body <- c()
  request.body$rsid_list <- reportsuite.id

  valid.successevents <- ApiRequest(body=toJSON(request.body),func.name="ReportSuite.GetSuccessEvents")

  successevents.formatted <- data.frame()
  for (i in 1:length(valid.successevents$rsid) ) {
    valid.successevents$events[[i]]$report_suite <- valid.successevents$rsid[[i]]
    valid.successevents$events[[i]]$site_title <- valid.successevents$site_title[[i]]
    valid.successevents$events[[i]]$ecommerce_level <- valid.successevents$ecommerce_level[[i]]
    if(nrow(successevents.formatted)==0) {
      successevents.formatted <- valid.successevents$events[[i]]
    } else {
      successevents.formatted <- rbind(successevents.formatted,valid.successevents$events[[i]])
    }
  }

  return(successevents.formatted)

}