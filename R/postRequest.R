# PostRequest
# Internal function
# Build generic POST request

PostRequest <- function(method,body=NULL){
  return(POST(BuildURL(method), add_headers(BuildHeader()), body))
}