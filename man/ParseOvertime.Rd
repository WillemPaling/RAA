\name{ParseOvertime}
\alias{ParseOvertime}
\title{ParseOvertime}
\usage{
ParseOvertime(report.data)
}
\arguments{
  \item{report.data}{jsonlite formatted data frame of
  report data returned from the API}
}
\value{
Formatted data frame
}
\description{
Internal Function - Parses an overtime report returned from
the API
}
\seealso{
Other internal: \code{\link{ApiGetElements}};
\code{\link{ApiGetMetrics}}; \code{\link{ApiGetReport}};
\code{\link{ApiGetSegments}}; \code{\link{ApiQueueReport}};
\code{\link{ApiValidateReport}}; \code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{BuildURL}}; \code{\link{ParseFallout}};
\code{\link{ParsePathing}}; \code{\link{ParseRanked}};
\code{\link{ParseTrended}}; \code{\link{PostRequest}}
}

