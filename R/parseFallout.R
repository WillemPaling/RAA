# parseFallout - function to convert API output to data frame for a Pathing report from the 1.4 API
# returns a formatted data frame

parseFallout <- function(report_data) {

  # jsonlite puts this into a useful format
  # so just leave it as is
  data <- report_data$report$data
  return(data)

}