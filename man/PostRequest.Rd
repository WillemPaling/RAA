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

