\name{PostRequest}
\alias{PostRequest}
\title{ParseTrended}
\usage{
PostRequest(method, body = NULL)
}
\arguments{
  \item{method}{Adobe Analytics API method (Report.Queue,
  Report.Get etc)}

  \item{body}{body of post request, same usage as for HTTR
  POST()}
}
\value{
HTTR response object
}
\description{
Internal Function - Build generic POST request for Adobe
Analytics API
}
\seealso{
Other internal: \code{\link{ApiGetElements}};
\code{\link{ApiGetMetrics}}; \code{\link{ApiGetReport}};
\code{\link{ApiQueueReport}};
\code{\link{ApiValidateReport}}; \code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{BuildURL}}; \code{\link{ParseFallout}};
\code{\link{ParseOvertime}}; \code{\link{ParsePathing}};
\code{\link{ParseRanked}}; \code{\link{ParseTrended}}
}

