RAA
===============

##### Pronounced _RAAAH!_ Like a ferocious lion.

R client library for the Adobe Analytics 1.4 API, currently in beta, but due out in Feb 2014.
Get in touch with me if you're interested in using it. It is functional, but has not been extensively tested.

This library borrows from [Randy Zwitch's](https://github.com/randyzwitch) [RSiteCatalyst](https://github.com/randyzwitch/RSiteCatalyst) which the Adobe Analytics v1.3 API.
## Installation
RAA is in development, and is not yet on CRAN. You will need to install directly from GitHub.

First, install and load [devtools](https://www.google.com):

```
install.packages("devtools")
library(devtools)
```
And then run ```install_github``` to install _RAA_.

```
install_github("RAA","willempaling")
```

And finally you are ready to load it.

```
library(RAA)
```

You may also need to install other packages that _RAA_ depends on.

* [jsonlite](http://cran.r-project.org/web/packages/jsonlite/)
* [plyr](http://cran.r-project.org/web/packages/plyr/)
* [httr](http://cran.r-project.org/web/packages/httr/)
* [stringr](http://cran.r-project.org/web/packages/stringr/)

And for the OAUTH auth method, you'll also need:

* [httpuv](http://cran.r-project.org/web/packages/httpuv/)

For the legacy auth method (username/shared secret) you'll also need the following:

* [digest](http://cran.r-project.org/web/packages/digest/) (only required for legacy auth method)
* [base64enc](http://cran.r-project.org/web/packages/base64enc/) (only required for legacy auth method)


```
install.packages(c("jsonlite","plyr","httr","stringr","digest","base64enc,"httpuv"))
```
## Authorisation
Authorisation can be done using the legacy auth method (username:company + shared secret), or using the newer OAUTH method. Either is fine, but ultimately you should move towards using the OAUTH method, as the legacy auth method is deprecated.

##### Using OAUTH
First you will need to create an application in the [Adobe Dev Center](https://developer.omniture.com/en_US/devcenter). The application name can be whatever you want. The redirect URI should be *http://localhost:1410*.

This will provide you with a identifier and secret that you can use to access the Adobe Analytics API.

You currently need to specify your own endpoint. Once the 1.4 API is released, I'll update this to automatically retrieve your company endpoint.

```
RAA_Auth("your_identifier", 
         "your_secret", 
         endpoint.url="https://your-endpoint.omniture.com/admin/1.4/rest/")
```

##### Using legacy auth (web service credentials)
This auth method is pretty straight-forward, though much more fiddly involved under the hood, which is why it is deprecated.

You will simply need your username, and your shared secret, which you can retrieve from your account settings page in the Adobe Analytics web interface.

```
RAA_Auth("your_username:your_company", 
         "your_shared_secret", 
         endpoint.url="https://your-endpoint.omniture.com/admin/1.4/", 
         auth.method='legacy')
```

## Running Reports
Once you've authorised, reports can be queued and retrieved using the helper libraries for each report type, or by using raw JSON report definitions.

##### Running a report using a JSON definition
The following code defines a JSON report description, and runs it. As no date granularity is specified, it will return a ranked report.

```
report.desc <- '{ "reportDescription" : { 
"dateFrom" : "2014-01-01", 
"dateTo" : "2014-11-07", 
"reportSuiteID" : "your_report_suite", 
"metrics" : [ { "id" : "pageviews" } ], 
"elements" : [ { "id" : "page" } ]
} }'

report.data <- JsonQueueReport(desc)
```

This is the same report description, but with daily date granularity, which will return a trended report.

```
report.desc <- '{ "reportDescription" : { 
"dateFrom" : "2014-01-01", 
"dateTo" : "2014-11-07", 
"dateGranularity" : "day", 
"reportSuiteID" : "your_report_suite", 
"metrics" : [ { "id" : "pageviews" } ], 
"elements" : [ { "id" : "page" } ]
} }'

report.data <- JsonQueueReport(desc)
```

##### Using the helper functions
RAA has helper functions that make it easier to generate all report types (ranked, overtime, trended, pathing, fallout). These take parameters in R, convert them to JSON, then call JsonQueueReport. _RAA_ helper functions do not yet support inline segmentation or search, so if you want to use that functionality, you will need to use JsonQueueReport directly.

###### Helper Function: QueueOvertime
This function will return an overtime report. This is similar to the key metrics report, in that the only granularity allowed is time. 

QueueOvertime requires a start and end date, a reportsuite ID, and a character vector of metrics.

```
date.from <- "2014-01-01"
date.to <- "2013-01-07"
reportsuite.id <- "your_report_suite"
metrics <- c("visits","uniquevisitors","pageviews")

QueueOvertime <- function(reportsuite.id, date.from, date.to, metrics)
```

You may also wish to set any of the 5 optional named parameters.

```
date.from <- "2014-01-01"
date.to <- "2014-01-07"
reportsuite.id <- "your_report_suite"
metrics <- c("visits","uniquevisitors","pageviews")
date.granularity <- "hour"
segment.id <- "Visit_Natural_Search"
anomaly.detection <- TRUE
data.current <- TRUE
expedite <- TRUE

QueueOvertime <- function(reportsuite.id, date.from, date.to, metrics,date.granularity=date.granularity,segment.id=segment.id,anomaly.detection=anomaly.detection,data.current=data.current,expedite=expedite)
```

###### Helper Function: QueueRanked
This function will return a ranked report. This is an ordered list of elements and associated metrics with no time granularity.

QueueRanked requires a start and end date, a reportsuite ID, a character vector of elements and a character vector of metrics.

```
date.from <- "2014-01-01"
date.to <- "2014-01-07"
reportsuite.id <- "your_report_suite"
metrics <- c("visits","uniquevisitors","pageviews")
elements <- c("page","geoCountry","geoCity")

QueueRanked <- function(reportsuite.id, date.from, date.to, metrics, elements)
```

You may also wish to set any of the 6 optional named parameters. While you can specify more than one element with _selected_, at this point, the 1.4 API only supports this for the first element specified.

```
date.from <- "2014-01-01"
date.to <- "2013-01-07"
reportsuite.id <- "your_report_suite"
metrics <- c("visits","uniquevisitors","pageviews")
elements <- c("page","geoCountry","geoCity")
top <- 100
start <- 100
selected <- list(page=c("Home","Search","About"))
segment.id <- "dw:12345"
data.current <- TRUE
expedite <- TRUE

QueueRanked <- function(reportsuite.id, date.from, date.to, metrics,elements,top=top,start=start,segment.id=segment.id,data.current=data.current,expedit=expedite)
```


