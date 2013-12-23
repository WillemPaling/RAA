# parseOvertime - function to convert API output to data frame for an Over Time report from the 1.4 API
# returns a formatted data frame

parseOvertime <- function(report_data) {

  data <- report_data$report$data

  rows <- lapply(data, "[", c("name", "year", "month", "day", "hour")) #Just the breakdowns @TODO - this probably needs to detect if hour exists?

  rows_df <- ldply(rows, quickdf) #breakdowns as DF
  rows_df <- cbind(rows_df, segment=segment_requested) #add segment to df

  counts <- lapply(data, "[[", "counts") # Just the "counts" column
  counts_df <- ldply(counts, quickdf) # counts as DF
  names(counts_df) <- metrics #assign names to counts_df

  formatted_df <- cbind(rows_df, counts_df)
  formatted_df$date <- lapply(formatted_df$name,parseDateStr)

  return(formatted_df) #append rows info with counts if not anomaly parsing

}