#' @export
dl_las <- function(zone_type = "las"){
  if(zone_type == "wmc"){
    url_wmc <- "http://geoportal.statistics.gov.uk/datasets/9507292be10e43c7abe9d3be36db6c41_3.zip"
    download.file(url_las, destfile = "zones.zip")
    unzip("zones.zip")
    zones = readOGR("Westminster_Parliamentary_Constituencies_December_2015_Super_Generalised_Clipped_Boundaries_in_Great_Britain.shp")
    f_to_delete <- list.files(pattern = "Westminster_Parliamentary_Constituencies_")
    file.remove(f_to_delete)
    zones
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