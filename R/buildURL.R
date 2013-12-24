# BuildURL
# Build URL string

BuildURL <- function(method){
  #Get endpoint from AA.Credentials position 3
  endpoint <- AA.Credentials[3]
  return(paste(endpoint, "?method=",method, sep=""))
} #End function bracket  