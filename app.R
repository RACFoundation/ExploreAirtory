## app.R ##
library(shinydashboard)
library(sp)
source("R/funs.R")

ui <- shinyUI(fluidPage(
  titlePanel(title = "Welcome to the ExploreAirtory"),
  sidebarLayout(position = "right",
                sidebarPanel( "Controls"),
                mainPanel("Interactive Map", 
                          leafletOutput("map1", height = 600))
  )

))

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$map1 <- renderLeaflet({
    
    zones <- dl_las()
    leaflet() %>% addTiles() %>% addPolygons(data = zones)
  })
}

shinyApp(ui, server)