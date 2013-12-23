# AA_SetDebug
# Sets debug mode to enable debug messages and file output

utils::globalVariables("AADebug")

AA_SetDebug <- function(debug_mode = TRUE){
  
  AADebug <<- debug_mode
  print(paste("DEBUG MODE: ",debug_mode))

} #End function bracket  