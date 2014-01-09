#' ApiGetProps
#'
#' Internal function - Calls the API and gets valid props for specified params
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of available props
#'
#' @family internal
#'

ApiGetProps <- function(report.description="",interval.seconds=2,max.attempts=5) {
  
  props.received <- FALSE
  num.tries <- 0

  while(props.received==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("ReportSuite.GetProps", report.description)

    if(json.queue$status==200) {
      props.received <- TRUE
      props.list <- fromJSON(content(json.queue,"text"))
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    print("Saving output as json.queue.getprops.txt")
    sink("json.queue.getprops.txt")
    cat(toJSON(props.list))
    sink()
    save(json.queue,file="json.queue.getprops.Rda")
  }

  # If we couldn't validate the report, then stop
  if(!props.received){
    stop("Error: Number of Tries Exceeded")
  }

  return(props.list)
}