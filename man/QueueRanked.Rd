\name{QueueRanked}
\alias{QueueRanked}
\title{QueueRanked}
\usage{
QueueRanked(reportsuite.id, date.from, date.to, metrics, elements, top = 0,
  start = 0, selected = list(), segment.id = "", data.current = FALSE,
  expedite = FALSE)
}
\arguments{
  \item{reportsuite.id}{report suite id}

  \item{date.from}{start date for the report (YYYY-MM-DD)}

  \item{date.to}{end date for the report (YYYY-MM-DD)}

  \item{metrics}{list of metrics to include in the report}

  \item{elements}{list of elements to include in the
  report}

  \item{top}{number of elements to include (top X) - only
  applies to the first element.}

  \item{start}{start row if you do not want to start at #1
  - only applies to the first element.}

  \item{selected}{list of specific items to include in the
  report - e.g. list(page=c("Home","Search","About")). This
  appears to only work for the first element.}

  \item{segment.id}{id of Adobe Analytics segment to
  retrieve the report for}

  \item{anomaly.dection}{set to TRUE to include forecast
  data (only valid for day granularity with small date
  ranges)}

  \item{data.current}{TRUE or FALSE - whether to include
  current data for reports that include today's date}

  \item{expedite}{set to TRUE to expedite the processing of
  this report}
}
\value{
Flat data frame containing datetimes and metric values
}
\description{
Helper function to run a Ranked Report
}

