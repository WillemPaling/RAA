# buildURL
# Build URL string

buildURL <- function(method){
  
  #Get endpoint from AACredentials position 3
  endpoint <- AACredentials[3]
  return(paste(endpoint, "?method=",method, sep=""))
}