#' @export
dl_zones <- function(x){
  if(x == "wmc"){
    url_zone <- "http://geoportal.statistics.gov.uk/datasets/9507292be10e43c7abe9d3be36db6c41_2.zip"
    download.file(url_zone, destfile = "zones.zip")
    unzip("zones.zip")
    zones = readOGR("Westminster_Parliamentary_Constituencies_December_2015_Generalised_Clipped_Boundaries_in_Great_Britain.shp")
    f_to_delete <- list.files(pattern = "Westminster_Parliamentary_Constituencies_")
    file.remove(f_to_delete)
    zones
  }
  if(x == "las"){
    url_zone <- "http://geoportal.statistics.gov.uk/datasets/686603e943f948acaa13fb5d2b0f1275_2.zip"
    download.file(url_zone, destfile = "zones.zip")
    unzip("zones.zip")
    zones = readOGR("Local_Authority_Districts_December_2016_Generalised_Clipped_Boundaries_in_Great_Britain.shp")
    f_to_delete <- list.files(pattern = "Local_Authority_Districts_")
    file.remove(f_to_delete)
    zones
  }
}