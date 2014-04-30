#' OBIS observations
#'
#' A longer description
#' @param species The species name for which we require data
#' @param foptions  Additional arugments we wil never use except for debugging
#' @export
#' @keywords data observations
#" @import httr assertthat
#" @importFrom plyr compact
#' @examples \dontrun{
#' # obs(species = "Kogia breviceps")
#'}
obs <- function(species = NULL, foptions = list()) {
# This tells the function to make sure species is not blank. 
# The next line will stop the function if it is ever FALSE
assert_that(!is.null(species))
# We declare the following options to pass to the API
base_url <- "http://www.iobis.org/geoserver/OBIS/ows"
service <- "WFS"
version <- "1.0.0"
request <- "GetFeature"
typeName <- "OBIS:points_ex"
outputFormat <- "csv"
VIEWPARAMS <- paste0("where:tname=", "\'" ,species, "\'")
# Compact removes anything from the list if it's NULL
args <- as.list(compact(c(service = service, version = version, 
	request = request, typeName = typeName, 
	outputFormat = outputFormat, VIEWPARAMS = VIEWPARAMS)))
# Using the GET protocol, we pass these arguments to the API
data <- GET(base_url, query = args, foptions)
# We don't parse the results in the first go, just get it back as is
results <- content(data, as = "text")
# Then we coerce into a data.frame
# This step is slow but we'll have to optimise it. 
# Perhaps request a better format that csv from the server
read.csv(textConnection(results))
}
