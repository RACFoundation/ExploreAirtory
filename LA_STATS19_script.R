library(knitr)
library(markdown)
library(rmarkdown)
library(dplyr)
library(jsonlite)
library(magrittr)
library(httr)
library(raster)
library(rgeos)
require(ggplot2)
require(maptools)
require(leaflet)
require(DT)
require(lubridate)
require(data.table)
require(sp)
require(tidyr)
require(waffle)
require(openair)
require(rgdal)

wd <- getwd()

LA <- read.csv("LA.csv")

# Get full catalogue
stations_raw <- catalogue()

stations_raw$EU.Site.ID<-NULL
stations_raw$EMEP.Site.ID<-NULL
stations_raw$Altitude..m.<-NULL


# # Table 1 
# Table1 <- read.csv("data/FS_Table1.csv")
# # MissingLAs <- LA[!(LA$CODE %in% Table1$ONSCode),  ]
# Table1$Fatal[is.na(Table1$Fatal)] <- 0
# Table1$Serious[is.na(Table1$Serious)] <- 0
# Table1$Slight[is.na(Table1$Slight)] <- 0
# Table1 <- (Table1 %>% gather(severity, number, 3:5))
# 
# # Table 2 (P04UK, cleaned, https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/2011censuspopulationestimatesbyfiveyearagebandsandhouseholdestimatesforlocalauthoritiesintheunitedkingdom)
# Table2 <- read.csv("data/P04UK.csv")
# Table2 <- merge(Table1, Table2)
# Table2$Rate <- (as.numeric(Table2$number)/as.numeric(Table2$Population))*10000
# 
# summary(Table2)

# clean data
stations_raw$Start.Date<-as.Date((stations_raw$Start.Date))
stations_raw$End.Date<-as.Date((stations_raw$End.Date))
stations_raw<-subset(stations_raw, !is.na(stations_raw$Latitude))
stations_raw<-subset(stations_raw, !is.na(stations_raw$Longitude))

coordinates(stations_raw) <- ~ Longitude + Latitude
proj4string(stations_raw) = CRS("+init=epsg:4326")

date <- (Sys.Date())

# gClip <- function(shp, bb){
#   if(class(bb) == "matrix") b_poly <- as(extent(as.vector(t(bb))), "SpatialPolygons")
#   else b_poly <- as(extent(bb), "SpatialPolygons")
#   gIntersection(shp, b_poly, byid = T)
# }

## Warning: spgeom1 and spgeom2 have different proj4 strings


plot(zones_clipped)
if (!file.exists(paste0(wd, "/results",date))) {
  dir.create(paste0(wd, "/results",date))
}


# loop to produce outputs

for (CODE in LA$CODE){
  rmarkdown::render('LA_STATS19.Rmd', 
                    output_file =  paste0(wd, "/results",date, "/report_", CODE, '_', date, ".html"), encoding = "UTF-8")
  # for pdf reports  
  #   rmarkdown::render(input = "LA_STATS19.Rmd", 
  #           output_format = "pdf_document",
  #           output_file = paste("report_", CODE, '_', Sys.Date(), ".pdf", sep=''))
  
}