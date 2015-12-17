library(shiny)
                                        # Define UI for application that draws a histogram
shinyUI(fluidPage(

                                        # Application title
    titlePanel("Food consumption in EU"),

                                        # Sidebar with a slider input for the number of bins
    sidebarLayout(
      
        selectizeInput("foodex_l4",
                       "Foodex L4:",
                       choices=NULL),

                                        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("mapPlot")
        )
    )))
