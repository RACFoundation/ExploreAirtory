require(sp)
require(openair)
source("R/funs.R")

# data frame of 238 sensors
stations_raw <- importMeta(source = "aurn", all = TRUE)

# clean data 
coordinates(stations_raw) <- ~ longitude + latitude
plot(stations_raw)

date_now <- (Sys.Date())

## Warning: spgeom1 and spgeom2 have different proj4 strings
zones <- dl_las()
proj4string(stations_raw) = proj4string(zones)
zone_type <- c("las", "wmc")[1]
plot(zones)
res_dir <- paste0(zone_type, "/results-", date_now)
if (!file.exists(res_dir)) {
  dir.create(res_dir)
}

# variables to add to zones data
zones$n_sensors = NA # how many sensors per zone?
zones$nox = NA # average nox levels

# loop to produce outputs
i = 1 # initiate for testing in for loop
# for(i in 1:length(zones)){
for(i in 1:9){ # for testing
  res_dir_zone = file.path(res_dir, zones@data[i,1])
  dir.create(res_dir_zone)
  
  # preprocess data
  stns_in_zone = stations_raw[zones[i,],]
  if(length(stns_in_zone) == 0)
    next() else
      stns_in_zone = stns_in_zone[1,] # assumes only one for now...
  
  nox = importAURN(site = stns_in_zone$code, year = 2009, pollutant = "nox", hc = FALSE,
             meta = FALSE, verbose = FALSE)
  write.csv(nox, paste0(res_dir_zone, "/nox.csv"))
  
  # generate data
  zones$n_sensors[i] = length(stns_in_zone)
  zones$nox[i] = mean(nox$nox, na.rm = T)
  
  # generate report
  report_file = file.path(res_dir_zone, "report.html")
  rmarkdown::render('exploreair.Rmd', output_file =  report_file)
  
}
