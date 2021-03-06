% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_date_cause.R
\name{find_date_cause}
\alias{find_date_cause}
\alias{find_start_date}
\alias{find_end_date}
\alias{constrain_dates}
\alias{assert_positive_timespan}
\title{Find the first date beyond a cutoff in several columns}
\usage{
find_date_cause(
  x,
  ...,
  period_start = NULL,
  period_end = NULL,
  datecol = "start_date",
  datereason = "start_date_reason",
  na_fill = "start"
)

find_start_date(
  x,
  ...,
  period_start = NULL,
  period_end = NULL,
  datecol = "start_date",
  datereason = "start_date_reason"
)

find_end_date(
  x,
  ...,
  period_start = NULL,
  period_end = NULL,
  datecol = "end_date",
  datereason = "end_date_reason"
)

constrain_dates(i, period_start, period_end, boundary = "both")

assert_positive_timespan(x, date_start, date_end)
}
\arguments{
\item{x}{a data frame}

\item{...}{an ordered series of date columns (i.e. the most important date
to be considered first).}

\item{period_start, period_end}{for the find_ functions, this should be the
name of a column in \code{x} that contains the start/end of the recall period.
For \code{constrain_dates}, this should be a vector of dates.}

\item{datecol}{the name of the new column to contain the dates}

\item{datereason}{the name of the column to contain the name of the column
from which the date came.}

\item{na_fill}{one of either "before" or "after" indicating that the new
column should only contain dates before or after the cutoff date.}

\item{i}{a vector of dates}

\item{boundary}{one of "both", "start", or "end". Dates outside of the
boundary will be set to NA.}

\item{date_start, date_end}{column name of a date vector}
}
\description{
This function will find the first date in an orderd series of columns that
is either before or after a cutoff date, inclusive.
}
\examples{
d <- data.frame(
  s1 = c(as.Date("2013-01-01") + 0:10, as.Date(c("2012-01-01", "2014-01-01"))),
  s2 = c(as.Date("2013-02-01") + 0:10, as.Date(c("2012-01-01", "2014-01-01"))),
  s3 = c(as.Date("2013-01-10") - 0:10, as.Date(c("2012-01-01", "2014-01-01"))),
  ps = as.Date("2012-12-31"),
  pe = as.Date("2013-01-09")
)
print(dd <- find_date_cause(d, s1, s2, s3, period_start = ps, period_end = pe))
print(bb <- find_date_cause(d, s1, s2, s3, period_start = ps, period_end = pe,
                            na_fill = "end", 
                            datecol = "enddate",
                            datereason = "endcause"))
find_date_cause(d, s3, s2, s1, period_start = ps, period_end = pe)

# works
assert_positive_timespan(dd, start_date, pe)

# returns a warning because the last date isn't later than the start_date
assert_positive_timespan(dd, start_date, s2)


with(d, constrain_dates(s1, ps, pe))
with(d, constrain_dates(s2, ps, pe))
with(d, constrain_dates(s3, ps, pe))

}
