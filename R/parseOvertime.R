# parseOvertime - function to convert API output to data frame for an Over Time report from the 1.4 API
# returns a formatted data frame

parseOvertime <- function(report_data) {

  # jsonlite already makes this into a nice data frame for us
  data <- report_data$report$data

  # Create a column of R datetimes
  if('hour' %in% colnames(data)){
    datetime <- strptime(paste(data$year,data$month,data$day,data$hour,sep="-"), "%Y-%m-%d-%H")
  } else {
    datetime <- strptime(paste(data$year,data$month,data$day,sep="-"), "%Y-%m-%d")
  }

  counts_df <- ldply(data$counts)

  metrics <- report_data$report$metrics$id
  names(counts_df) <- metrics #assign names to counts_df

  drops <- c("counts")
  rows_df <- data[,!(names(data) %in% drops)]

  formatted_df <- cbind(datetime,rows_df, counts_df)

  return(formatted_df)

}