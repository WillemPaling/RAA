\name{ApiGetReport}
\alias{ApiGetReport}
\title{ApiGetReport}
\usage{
ApiGetReport(report.id, interval.seconds = 5, max.attempts = 120)
}
\arguments{
  \item{report.id}{Report ID returned from the API by
  Report.Queue}

  \item{interval.seconds}{Time to wait between attempts to
  get the report (defaults to 5 seconds)}

  \item{max.attempts}{Max number of attempts to make to
  retrieve the report (defaults to 120)}
}
\value{
Formatted data frame containing the report
}
\description{
Internal function - retrieves specified report from Adobe
Analytics API, if it is not available, it tries again after
interval.seconds, up to max.attempts times
}
\seealso{
Other internal: \code{\link{ApiGetMetrics}};
\code{\link{ApiQueueReport}};
\code{\link{ApiValidateReport}}; \code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{BuildURL}}; \code{\link{ParseFallout}};
\code{\link{ParseOvertime}}; \code{\link{ParsePathing}};
\code{\link{ParseRanked}}; \code{\link{ParseTrended}};
\code{\link{PostRequest}}
}

