\name{PostRequest}
\alias{PostRequest}
\title{ParseTrended}
\usage{
PostRequest(method, body = NULL, interval.seconds = 2, max.attempts = 1,
  print.attempts = FALSE)
}
\arguments{
  \item{method}{Adobe Analytics API method (Report.Queue,
  Report.Get etc)}

  \item{body}{body of post request, same usage as for HTTR
  POST()}

  \item{interval.seconds}{Time to wait between attempts to
  get the report (defaults to 2 seconds)}

  \item{max.attempts}{Max number of attempts to make to
  retrieve the report (defaults to 1)}

  \item{print.attempts}{if set to TRUE, this will print
  attempt numbers to the console}
}
\value{
HTTR response object
}
\description{
Internal Function - Build generic POST request for Adobe
Analytics API
}
\seealso{
Other internal: \code{\link{ApiRequest}};
\code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{BuildURL}}; \code{\link{ParseFallout}};
\code{\link{ParseOvertime}}; \code{\link{ParsePathing}};
\code{\link{ParseRanked}}; \code{\link{ParseTrended}}
}

