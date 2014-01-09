\name{ParseFallout}
\alias{ParseFallout}
\title{ParseFallout}
\usage{
ParseFallout(report.data)
}
\arguments{
  \item{report.data}{jsonlite formatted data frame of
  report data returned from the API}
}
\value{
Formatted data frame
}
\description{
Internal Function - Parses a fallout report returned from
the API
}
\seealso{
Other internal: \code{\link{ApiGetElements}};
\code{\link{ApiGetEvars}}; \code{\link{ApiGetMetrics}};
\code{\link{ApiGetProps}}; \code{\link{ApiGetReport}};
\code{\link{ApiGetSegments}}; \code{\link{ApiQueueReport}};
\code{\link{ApiValidateReport}}; \code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{BuildURL}}; \code{\link{ParseOvertime}};
\code{\link{ParsePathing}}; \code{\link{ParseRanked}};
\code{\link{ParseTrended}}; \code{\link{PostRequest}}
}

