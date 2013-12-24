# parsePathing - function to convert API output to data frame for a Pathing report from the 1.4 API
# returns a formatted data frame

parsePathing <- function(report_data) {

  data <- report_data$report$data

  paths_df<-ldply(data$path,.fun=function(row){return(row$name)})
  names(paths_df) <- paste("step_",1:ncol(paths_df),sep="")

  paths_df$count <- data$counts

  return(paths_df)

}