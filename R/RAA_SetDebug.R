# RAA_SetDebug
# Sets debug mode to enable debug messages and file output

utils::globalVariables("RAA.Debug")

RAA_SetDebug <- function(debug.mode = TRUE){
  
  RAA.Debug <<- debug.mode
  if(RAA.Debug) {
    print(paste("DEBUG MODE: ",debug.mode))
  }
  
} #End function bracket  