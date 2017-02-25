# Check that required packages are running
require(plyr)
require(sp)
require(maptools)
require(rgeos)
require(rgdal)
require(openair)
require(leaflet)

stations.df <- importMeta(source = "aurn", all = TRUE)

# turn stations into a SpatialPointsDataFrame
coordinates(stations.df) <- c("longitude", "latitude")
proj4string(stations.df) = CRS("+init=epsg:4326")

roads.line <- readOGR(".", "roads_WGS84")
proj4string(roads.line) = CRS("+init=epsg:4326")

proj4string(roads.line) <- proj4string(stations.df)

stations.df@data$nearest_line <- as.character('')

# Loop through data. For each point, get ID of nearest line and store it
for (i in 1:nrow(stations.df)){
  stations.df@data[i,"nearest_line"] <-
    roads.line[which.min(gDistance(stations.df[i,], roads.line, byid= TRUE)),]@data$line_id
}




g <- get.knnx(coordinates(roads.pt), coordinates(stations.df),k=1)

str(g)
g.df <- as.data.frame(g$nn.index)

g.df$row_num <- rownames(g.df)
g.df$cp_row_num <- g.df$V1
g.df$row_num <- as.numeric(g.df$row_num)

roads.pt_match <- as.data.frame(roads.pt)
roads.pt_match$cp_row_num <- rownames(roads.pt_match)

stations.df_match <- as.data.frame(stations.df)
stations.df_match$row_num <- as.numeric(rownames(stations.df_match))

g.df$V1 <- NULL

result <- join(g.df, roads.pt_match, by = "cp_row_num", type = "left", match = "first")
result <- join(result, stations.df_match, by = "row_num", type = "right", match = "first")

result$row_num <- NULL
result$cp_row_num <- NULL







station.data <- importAURN(site = "my1", year = 2009, pollutant = "all", hc = FALSE,
                           meta = FALSE, verbose = FALSE)
