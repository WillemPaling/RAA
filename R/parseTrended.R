# ParseTrended - function to convert API output to data frame for a Trended report from the 1.4 API
# returns a formatted data frame

ParseTrended <- function(report.data) {

  # jsonlite already makes this into a nice data frame for us
  data <- report.data$report$data

  elements <- report.data$report$elements$id
  metrics <- report.data$report$metrics$id

  formatted.df <- data.frame()

  # We need to work our way down the nested data structure
  # We've essentially got a ranked report for each date
  for(i in 1:(nrow(data))) {

    temp <- BuildInnerBreakdownsRecursively(data[i,"breakdown"][[1]],elements,metrics,1,c())

    # build out the date columns and bind them to the left of the data frame
    date.df <- data.frame(matrix(NA, nrow = nrow(temp), ncol = 5))
    names(date.df) <- c("name","datetime","year","month","day")
    date.df$name <- data[i,]$name
    date.df$year <- data[i,]$year
    date.df$month <- data[i,]$month
    date.df$day <- data[i,]$day
    if('hour' %in% colnames(data[i,])){
      date.df$datetime <- strptime(paste(data[i,]$year,data[i,]$month,data[i,]$day,data[i,]$hour,sep="-"), "%Y-%m-%d-%H")
      date.df$hour <- data[i,]$hour
    } else {
      date.df$datetime <- strptime(paste(data[i,]$year,data[i,]$month,data[i,]$day,sep="-"), "%Y-%m-%d")
    }
    temp <- cbind(date.df,temp)

    if(nrow(formatted.df)>0) {
        formatted.df <- rbind(formatted.df,temp)
      } else {
        formatted.df <- temp
      }
  }

  return(formatted.df)

}