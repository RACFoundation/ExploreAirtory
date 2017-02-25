#' @export
dl_las <- function(zone_type = "las"){
  if(zone_type == "wmc"){
    # ivo's code here
  } 
  if(zone_type == "las"){
    url_las <- "http://geoportal.statistics.gov.uk/datasets/3943c2114d764294a7c0079c4020d558_4.zip"
    download.file(url_las, destfile = "zones.zip")
    unzip("zones.zip")
    zones = readOGR("Local_Authority_Districts_December_2014_Ultra_Generalised_Clipped_Boundaries_in_Great_Britain.shp")
    f_to_delete <- list.files(pattern = "Local_Authority_Districts_")
    file.remove(f_to_delete)
    zones
  }
}