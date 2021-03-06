\name{BuildLineItemSegment}
\alias{BuildLineItemSegment}
\title{BuildLineItemSegment}
\usage{
BuildLineItemSegment(element, selected = list())
}
\arguments{
  \item{elements}{list of elements on which to vase the
  segment}

  \item{selected}{named list of element value vectors for
  each element}
}
\value{
segment definition for use with Queue* helper functions
}
\description{
Helper function to build a line item segment for use with
other reports Multiple segments can be combined in a list
}

