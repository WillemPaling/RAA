# ParsePathing - function to convert API output to data frame for a Pathing report from the 1.4 API
# returns a formatted data frame

ParsePathing <- function(report.data) {

  data <- report.data$report$data

  paths.df<-ldply(data$path,.fun=function(row){return(row$name)})
  names(paths.df) <- paste("step.",1:ncol(paths.df),sep="")

  paths.df$count <- data$counts

  return(paths.df)

}