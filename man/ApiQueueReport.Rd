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

