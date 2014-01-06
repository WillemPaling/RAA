\name{BuildURL}
\alias{BuildURL}
\title{BuildURL}
\usage{
BuildURL(method)
}
\arguments{
  \item{method}{Adobe Analytics API method}
}
\value{
URL string (concatenation of endpoint, method and access
key)
}
\description{
Internal Function - Builds URL string for Adobe Analytics
API call
}
\seealso{
Other internal: \code{\link{ApiGetElements}};
\code{\link{ApiGetMetrics}}; \code{\link{ApiGetReport}};
\code{\link{ApiQueueReport}};
\code{\link{ApiValidateReport}}; \code{\link{BuildHeader}};
\code{\link{BuildInnerBreakdownsRecursively}};
\code{\link{ParseFallout}}; \code{\link{ParseOvertime}};
\code{\link{ParsePathing}}; \code{\link{ParseRanked}};
\code{\link{ParseTrended}}; \code{\link{PostRequest}}
}

