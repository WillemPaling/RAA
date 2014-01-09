#' ApiGetElements
#'
#' Internal function - Calls the API and gets valid elements for specified params
#'
#' @param report.description JSON report description
#' @param interval.seconds Time to wait between attempts to get the report (defaults to 2 seconds)
#' @param max.attempts Max number of attempts to make to retrieve the report (defaults to 5)
#'
#' @importFrom httr content
#' @importFrom jsonlite toJSON
#'
#' @return list of valid elements
#'
#' @family internal
#'

ApiGetElements <- function(report.description="",reportsuite.id="",interval.seconds=2,max.attempts=5) {
  
  elements.received <- FALSE
  num.tries <- 0

  while(elements.received==FALSE && num.tries < max.attempts){
    num.tries <- num.tries + 1
    json.queue <- PostRequest("Report.GetElements", report.description)

    if(json.queue$status==200) {
      elements.received <- TRUE
      elements.list <- fromJSON(content(json.queue,"text"))
    } else {
      Sys.sleep(interval.seconds)
    }
  }

  # If we are in debug mode, save the output
  if(RAA.Debug==TRUE) {
    print("Saving output as json.queue.getelements.txt")
    sink("json.queue.getelements.txt")
    cat(toJSON(elements.list))
    sink()
    save(json.queue,file="json.queue.getelements.Rda")
  }

  # If we couldn't validate the report, then stop
  if(!elements.received){
    stop("Error: Number of Tries Exceeded")
  }

  return(elements.list)
}