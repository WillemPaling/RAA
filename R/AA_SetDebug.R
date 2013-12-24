# AA_SetDebug
# Sets debug mode to enable debug messages and file output

utils::globalVariables("AA.Debug")

AA_SetDebug <- function(debug.mode = TRUE){
  
  AA.Debug <<- debug.mode
  print(paste("DEBUG MODE: ",debug.mode))

} #End function bracket  