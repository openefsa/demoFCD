library(shiny)
source("analyse.R")
source("drawMap.R")
library(gpclib)
library(mapproj)
gpclibPermit() 
mapproj::.Last.projection()

allL4 <- as.character(data$Foodex.L4[unique(data$Foodex.L4)])
                                        #install.packages("gpclib")
shinyServer(function(input, output,session) {

    updateSelectizeInput(session, 'foodex_l4', choices = allL4, server = TRUE)
    output$mapPlot <- renderPlot({
        
        plotme(getMapData(input$foodex_l4),input$foodex_l4)
        
    },width=800,height=800)
})
