#' @noRd
#   obisMap <- function(genus,species) {
#     data <- content(GET(paste("http://www.iobis.org/geoserver/wms?LAYERS=OBIS:dist_sp,OBIS:country&STYLES=&FORMAT=image/png%20&VIEWPARAMS=where:scientific=%27",genus,"%20",species,"%27;table:dist_sp_5deg;count_column:nincl%20&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&SRS=EPSG:4326%20&BBOX=-180,-90,180,90&WIDTH=480&HEIGHT=320",sep="")))
#     plot(0:1, 0:1, type = "n", xlab = "", ylab = "")
#     
#     rasterImage(data, 0, 0, 1, 1)
#   }

#run

# obisMap(genus = 'Paragorgia',species = 'arborea')
