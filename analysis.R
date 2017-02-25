require(sp)
require(openair)
source("R/funs.R")

# data frame of 238 sensors
stations_raw <- importMeta(source = "aurn", all = TRUE) 

# clean data 
coordinates(stations_raw) <- ~ longitude + latitude
proj4string(stations_raw) = CRS("+init=epsg:4326")
plot(stations_raw)

date_now <- (Sys.Date())

## Warning: spgeom1 and spgeom2 have different proj4 strings
zones <- dl_las()
zone_type <- c("las", "wmc")[1]
plot(zones)
res_dir <- paste0(zone_type, "/results-", date_now)
if (!file.exists(res_dir)) {
  dir.create(res_dir)
}

# loop to produce outputs
i = 1 # initiate for testing in for loop
for(i in 1:length(zones)){
  out_dir 
  
  rmarkdown::render('exploreair.Rmd', 
                    output_file =  paste0(res_dir, zones@data[i,1], ".html"))
  
}