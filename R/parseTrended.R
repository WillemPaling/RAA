# parseTrended - function to convert API output to data frame for a Trended report from the 1.4 API
# returns a formatted data frame

parseTrended <- function(report_data) {

  # jsonlite already makes this into a nice data frame for us
  data <- report_data$report$data

  elements <- report_data$report$elements$id
  metrics <- report_data$report$metrics$id

  formatted_df <- data.frame()

  # We need to work our way down the nested data structure
  # We've essentially got a ranked report for each date
  for(i in 1:(nrow(data))) {

    temp <- buildInnerBreakdownsRecursively(data[i,"breakdown"][[1]],elements,metrics,1,c())

    # build out the date columns and bind them to the left of the data frame
    date_df <- data.frame(matrix(NA, nrow = nrow(temp), ncol = 5))
    names(date_df) <- c("name","datetime","year","month","day")
    date_df$name <- data[i,]$name
    date_df$year <- data[i,]$year
    date_df$month <- data[i,]$month
    date_df$day <- data[i,]$day
    if('hour' %in% colnames(data[i,])){
      date_df$datetime <- strptime(paste(data[i,]$year,data[i,]$month,data[i,]$day,data[i,]$hour,sep="-"), "%Y-%m-%d-%H")
      date_df$hour <- data[i,]$hour
    } else {
      date_df$datetime <- strptime(paste(data[i,]$year,data[i,]$month,data[i,]$day,sep="-"), "%Y-%m-%d")
    }
    temp <- cbind(date_df,temp)

    if(nrow(formatted_df)>0) {
        formatted_df <- rbind(formatted_df,temp)
      } else {
        formatted_df <- temp
      }
  }

  return(formatted_df)

}