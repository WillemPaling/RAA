\name{GetElements}
\alias{GetElements}
\title{GetElements}
\usage{
GetElements(reportsuite.id, metrics = c(), elements = c(),
  date.granularity = "")
}
\arguments{
  \item{reportsuite.id}{report suite id}

  \item{metrics}{list of existing metrics you want to use
  in combination with an additional metric}

  \item{elements}{list of existing elements you want to use
  in combination with an additional metric}

  \item{date.granularity}{granularity that you want to
  combine with an additional metric}
}
\value{
List of valid elements
}
\description{
Gets valid elements for current user, valid with optionally
specified existing metrics, elements and date granularity
}
