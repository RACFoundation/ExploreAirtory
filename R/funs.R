#' @export
dl_las <- function(zone_type = "las"){
  if(zone_type == "wmc"){
    url_wmc <- "http://geoportal.statistics.gov.uk/datasets/9507292be10e43c7abe9d3be36db6c41_0.zip"
    download.file(url_las, destfile = "zones.zip")
    unzip("zones.zip")
    zones = readOGR("Westminster_Parliamentary_Constituencies_December_2015_Full_Clipped_Boundaries_in_Great_Britain.shp")
    f_to_delete <- list.files(pattern = "Westminster_Parliamentary_Constituencies_")
    file.remove(f_to_delete)
    zones
  } 
  if(zone_type == "las"){
    url_las <- "http://geoportal.statistics.gov.uk/datasets/686603e943f948acaa13fb5d2b0f1275_0.zip"
    download.file(url_las, destfile = "zones.zip")
    unzip("zones.zip")
    zones = readOGR("Local_Authority_Districts_December_2016_Full_Clipped_Boundaries_in_Great_Britain.shp")
    f_to_delete <- list.files(pattern = "Local_Authority_Districts_")
    file.remove(f_to_delete)
    zones
  }
}