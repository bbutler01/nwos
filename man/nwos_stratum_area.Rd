% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nwos_stratum_area.R
\name{nwos_stratum_area}
\alias{nwos_stratum_area}
\title{NWOS Stratum Area}
\usage{
nwos_stratum_area(stratum, point.count, state.area)
}
\arguments{
\item{stratum}{vector indicating inclusion (1) and exclusion (0) in the stratum of interest. NA's are allowed.}

\item{point.count}{vector of the number of sample points associated with each observation. Default is point.count = 1.}

\item{state.area}{total land area in the state of interest.}
}
\value{
Area (of forestland) in the stratum.
}
\description{
This function estimates NWOS stratum areas.
}
\examples{
wi <- tbl_df(read.csv("data/wi.csv")) \%>\% mutate(ROW_NAME = row.names(wi), AC_WOOD = ACRES_FOREST, FFO = if_else(LAND_USE == 1 & OWN_CD == 45 & AC_WOOD >= 1, 1, 0))
WI_FFO_AREA <- nwos_stratum_area(stratum = wi$FFO, point.count = wi$POINT_COUNT, state.area = 33898733)
WI_FFO_AREA
}
\references{
Butler, B.J. In review. Weighting for the US Forest Service, National Woodland Owner Survey. U.S. Department of Agriculture, Forest Service, Northern Research Station. Newotwn Square, PA.
}
\keyword{nwos}
