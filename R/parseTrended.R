# parseTrended - function to convert API output to data frame for a Trended report from the 1.4 API
# returns a formatted data frame

parseTrended <- function(report_data) {

  # jsonlite already makes this into a nice data frame for us
  data <- report_data$report$data

  elements <- report_data$report$elements$id
  metrics <- report_data$report$metrics$id

  # We need to work our way down the nested data structure
  # We've essentially got a ranked report for each date
  for(i in 1:(nrow(data))) {
    temp <- buildInnerBreakdownsRecursively(data[i,"breakdown"],elements,metrics,1,c())
    temp$date <- data[i,"breakdown"]$name
    formatted_df <- rbind(formatted_df,temp)
  }

  return(formatted_df)

}