# PostRequest - Internal function - Build generic POST request for Adobe Analytics API
#
# Args:
#   method: Adobe Analytics API method (Report.Queue, Report.Get etc)
#   body: body of post request, same usage as for HTTR POST()
#
# Returns:
#   HTTR response object
#

PostRequest <- function(method,body=NULL){
  return(POST(BuildURL(method), add_headers(BuildHeader()), body))
}
