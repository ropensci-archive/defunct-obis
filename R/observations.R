
# Kate: I'm writing the first iteration of a function for querying observations from OBIS. I'm starting with the URL in slide #30 from the email. 
# We'll make this function more complex once we figure out all the arguments this specific URL (or REST method can take). 
# For now, let's just pass species names and get some data back.


# Here is the URL: 
http://www.iobis.org/geoserver/OBIS/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=OBIS:points_ex
&outputFormat=csv&VIEWPARAMS=where:tname='Kogia breviceps'

# We'll rename the function later. To something unique, perhaps a short prefix for all functions in this package so they don't conflict with others that might get loaded at the same time.

# Note all the comments below (or immediately above the function) with #' and an @ signs in front of them are doc strings.
# We will use the document(".") function in the devtools package to turn all of this into manual files (or help files when you search with ?function_name)
# Some of the patterns might seem obvious. The first line is the title. After a blank like is the package description. 
# Then, every argument the function takes (whatever we define) is described with an  @param.
# Functions have to be exported if they are to be accessible by name. Otherwise they are only available internally to the package. 
# Finally we add some keywords and an example.

# THe @import tag means pull in specific functions from other packages so we can use them here.
#  We can import entire packages with @import package_name or 
#  @importFrom package_name functions


# ----- The above comments wont actually be in the package once it's ready. ---------------

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
args <- as.list(compact(c(service = service, version = version, 
	request = request, typeName = typeName, 
	outputFormat = outputFormat, VIEWPARAMS = VIEWPARAMS)))
data <- GET(base_url, query = args, foptions)
results <- content(data, as = "text")
read.csv(textConnection(results))
}

# Since we haven't packaged the library yet,
# we do have to load the functions separately
library(httr)
library(assertthat)
library(plyr)

# Now run this
x <- obs(species = 'Kogia breviceps')
# Now just type x or edit(x) to see in spreadsheet view
