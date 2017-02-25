# Aim: load all data
library(sf)
aqma <- st_read("AQMA_WGS84.shp")
names(aqma)
summary(aqma$PM10)
