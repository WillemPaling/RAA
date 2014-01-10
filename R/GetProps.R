#' GetProps
#'
#' Gets available report suite props
#'
#' @param reportsuite.ids report suite id (or list of report suite ids)
#'
#' @return List of valid props
#'
#' @export

GetProps <- function(reportsuite.ids) {
  
  request.body <- c()
  request.body$rsid_list <- reportsuite.id

  valid.props <- ApiRequest(body=toJSON(request.body),func.name="ReportSuite.GetProps")

  props.formatted <- data.frame()
  for (i in 1:length(valid.props$rsid) ) {
    valid.props$props[[i]]$report_suite <- valid.props$rsid[[i]]
    if(nrow(props.formatted)==0) {
      props.formatted <- valid.props$props[[i]]
    } else {
      props.formatted <- rbind(props.formatted,valid.props$props[[i]])
    }
  }

  return(props.formatted)

}