#http://www.iobis.org/geoserver/wms?LAYERS=OBIS:dist_sp,OBIS:country&STYLES=&FORMAT=image/png
#&VIEWPARAMS=where:scientific='Paragorgia arborea';table:dist_sp_5deg;count_column:nincl
#&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&SRS=EPSG:4326
#&BBOX=-180,-90,180,90&WIDTH=480&HEIGHT=320


# ----- The above comments wont actually be in the package once it's ready. ---------------

#' OBIS map
#'
#' A longer description
#' @param species The species name for which we require data
#' @param foptions  Additional arugments we wil never use except for debugging
#' @export
#' @keywords map grids
#" @import httr assertthat
#" @importFrom plyr compact
#' @examples \dontrun{
#' # obs(species = "Paragorgia arborea")
#'}
obisMap <- function(species = NULL, foptions = list()) {
  # This tells the function to make sure species is not blank. 
  # The next line will stop the function if it is ever FALSE
  assert_that(!is.null(species))
  # We declare the following options to pass to the API
  base_url <- "http://www.iobis.org/geoserver/wms"
  LAYERS <- "OBIS:dist_sp,OBIS:country"
  service <- "WMS"
  version <- "1.1.1"
  request <- "GetMap"
  srs <- "EPSG:4326"
  BBOX <- c(-180, -90, 180, 90)
  width <- 480
  height <- 320
  Format <- "image/png"
  VIEWPARAMS <- paste0("where:scientific=", "\'" , species, "\'")
  args <- as.list(compact(c(service = service, version = version, 
                            request = request, LAYERS=LAYERS, srs=srs, BBOX=BBOX,
                            width = width, height = height,
                            Format = Format, VIEWPARAMS = VIEWPARAMS)))
  data <- GET(base_url, query = args, foptions)
  results <- content(data, as = "raw") 
  results <- readPNG(results)
  plot(0:1, 0:1, type = "n")
  rasterImage(results, 0, 0, 1, 1)
}

#Install packages
library(httr)
library(assertthat)
library(plyr)
library(png)
library(raster)

#run
obisMap(species = 'Paragorgia arborea')

