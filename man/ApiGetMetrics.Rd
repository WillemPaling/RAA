\name{ApiGetMetrics}
\alias{ApiGetMetrics}
\title{ApiGetMetrics}
\usage{
ApiGetMetrics(report.description = "", reportsuite.id = "",
  interval.seconds = 2, max.attempts = 5)
}
\arguments{
  \item{report.description}{JSON report description}

  \item{interval.seconds}{Time to wait between attempts to
  get the report (defaults to 2 seconds)}

  \item{max.attempts}{Max number of attempts to make to
  retrieve the report (defaults to 5)}
}
\value{
list of valid metrics
}
\description{
Internal function - Calls the API and gets valid metrics
for specified params
}
\seealso{
Other internal: \code{\link{ApiGetElements}};
\code{\link{ApiGetEvars}}; \code{\link{ApiGetProps}};
\code{\link{ApiGetReport}}; \code{\link{ApiGetSegments}};
\code{\link{ApiQueueReport}};
\code{\link{ApiValidateReport}}; \code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{BuildURL}}; \code{\link{ParseFallout}};
\code{\link{ParseOvertime}}; \code{\link{ParsePathing}};
\code{\link{ParseRanked}}; \code{\link{ParseTrended}};
\code{\link{PostRequest}}
}

