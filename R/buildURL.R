# BuildURL - Internal Function - Builds URL string for Adobe Analytics API call
# Args:
#   method: Adobe Analytics API method
#
# Returns:
#   URL string (concatenation of endpoint and method)
#

BuildURL <- function(method){
  #Get endpoint from AA.Credentials position 3
  endpoint <- AA.Credentials[3]
  return(paste(endpoint, "?method=",method, sep=""))
}