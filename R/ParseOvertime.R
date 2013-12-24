# ParseOvertime - Internal Function - Parses an overtime report returned from the API
# Args:
#   report.data: jsonlite formatted data frame of report data returned from the API
#
# Returns:
#   Formatted data frame
#

ParseOvertime <- function(report.data) {

  # jsonlite already makes this into a nice data frame for us
  data <- report.data$report$data

  # Create a column of R datetimes
  if('hour' %in% colnames(data)){
    datetime <- strptime(paste(data$year,data$month,data$day,data$hour,sep="-"), "%Y-%m-%d-%H")
  } else {
    datetime <- strptime(paste(data$year,data$month,data$day,sep="-"), "%Y-%m-%d")
  }

  counts.df <- ldply(data$counts)

  metrics <- report.data$report$metrics$id
  names(counts.df) <- metrics #assign names to counts.df

  drops <- c("counts")
  rows.df <- data[,!(names(data) %in% drops)]

  formatted.df <- cbind(datetime,rows.df, counts.df)

  return(formatted.df)

}
