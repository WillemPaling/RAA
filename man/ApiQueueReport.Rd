\name{ApiQueueReport}
\alias{ApiQueueReport}
\title{ApiQueueReport}
\usage{
ApiQueueReport(report.description, interval.seconds = 2, max.attempts = 5)
}
\arguments{
  \item{report.description}{JSON report description}

  \item{interval.seconds}{Time to wait between attempts to
  get the report (defaults to 2 seconds)}

  \item{max.attempts}{Max number of attempts to make to
  retrieve the report (defaults to 5)}
}
\value{
Report id (int)
}
\description{
Internal function - Internal function - Calls the API and
attempts to queue a report. If we get a 500 error, it tries
again. If we get an error, it tries again after
interval.seconds, up to max.attempts times
}
\seealso{
Other internal: \code{\link{ApiGetElements}};
\code{\link{ApiGetEvars}}; \code{\link{ApiGetMetrics}};
\code{\link{ApiGetProps}};
\code{\link{ApiGetReportSuites}};
\code{\link{ApiGetReport}}; \code{\link{ApiGetSegments}};
\code{\link{ApiGetSuccessEvents}};
\code{\link{ApiValidateReport}}; \code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{BuildURL}}; \code{\link{ParseFallout}};
\code{\link{ParseOvertime}}; \code{\link{ParsePathing}};
\code{\link{ParseRanked}}; \code{\link{ParseTrended}};
\code{\link{PostRequest}}
}

