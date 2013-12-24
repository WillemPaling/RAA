# ParseFallout - Internal Function - Parses a fallout report returned from the API
# Args:
#   report.data: jsonlite formatted data frame of report data returned from the API
#
# Returns:
#   Formatted data frame
#


ParseFallout <- function(report.data) {

  # jsonlite puts this into a useful format
  # so just leave it as is
  data <- report.data$report$data
  return(data)

}