require(sp)
require(openair)

wd <- getwd()

LA <- read.csv("LA.csv")

# data frame of 238 sensors
stations_raw <- importMeta(source = "aurn", all = TRUE) 

# clean data 
coordinates(stations_raw) <- ~ longitude + latitude
proj4string(stations_raw) = CRS("+init=epsg:4326")
plot(stations_raw)

date_now <- (Sys.Date())

## Warning: spgeom1 and spgeom2 have different proj4 strings

plot(zones_clipped)
if (!file.exists(paste0(wd, "/results-", date_now))) {
  dir.create(paste0(wd, "/results-", date_now))
}

# loop to produce outputs
for(CODE in LA$CODE){
  rmarkdown::render('LA_STATS19.Rmd', 
                    output_file =  paste0(wd, "/results", date_now, "/report_", CODE, '_', date_now, ".html"), encoding = "UTF-8")
  # for pdf reports  
  #   rmarkdown::render(input = "LA_STATS19.Rmd", 
  #           output_format = "pdf_document",
  #           output_file = paste("report_", CODE, '_', Sys.Date(), ".pdf", sep=''))
  
}