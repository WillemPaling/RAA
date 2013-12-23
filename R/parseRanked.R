# parseRanked - function to convert API output to data frame for an Over Time report from the 1.4 API
# returns a formatted data frame

parseRanked <- function(report_data) {

  # jsonlite already makes this into a nice data frame for us
  data <- report_data$report$data

  elements <- report_data$report$elements$id
  metrics <- report_data$report$metrics$id

  if(length(elements)==1) {
    # We don't need to traverse down the data structure
    counts_df <- ldply(data$counts)
    names(counts_df) <- metrics #assign names to counts_df

    drops <- c("counts")
    rows_df <- data[,!(names(data) %in% drops)]

    formatted_df <- cbind(rows_df, counts_df)
  } else {
    # We need to work our way down the nested data structure
    formatted_df <- buildInnerBreakdownsRecursively(data,elements,metrics,1,c())
  }

  return(formatted_df)

}