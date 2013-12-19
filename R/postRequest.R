# postRequest
# Internal function
# Build generic POST request

postRequest <- function(method,body=NULL){
  return(POST(buildURL(method), add_headers(buildHeader()), body))
}