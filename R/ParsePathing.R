#' ParsePathing
#'
#' Internal Function - Parses a pathing report returned from the API
#'
#' @param report.data jsonlite formatted data frame of report data returned from the API
#'
#' @importFrom plyr ldply
#'
#' @return Formatted data frame
#'
#' @family internal
#'

ParsePathing <- function(report.data) {

  data <- report.data$report$data

  paths.df<-ldply(data$path,.fun=function(row){return(row$name)})
  names(paths.df) <- paste("step.",1:ncol(paths.df),sep="")

  paths.df$count <- as.numeric(data$counts)

  return(paths.df)

}
