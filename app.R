#load packages
library(shiny)
library(semantic.dashboard)
library(DT)

#ui function
ui <- dashboardPage(theme = "cosmo",
    dashboardHeader(title = "Iris Dashboard"), 
    dashboardSidebar(
        sidebarMenu(
            menuItem("Correlation", tabName = "correlation", icon = icon("chart line")),
            menuItem("Data", tabName = "data", icon = icon("table"))
        )
    ), 
    dashboardBody(
        tabItems(
            tabItem("correlation", 
                    box(plotOutput("correlation_plot"), width = 8),
                    box(
                        selectInput("features", "Features:",
                                    c("Sepal.Width", "Petal.Length", 
                                      "Petal.Width")), width = 4
                    )
        ), 
        tabItem("data",
                fluidPage(
                h1("data"), 
                dataTableOutput("iristable")
                )
                )
        )
    )
)

#server function
server <- function(input, output){
    output$correlation_plot <- renderPlot({
        plot(iris$Sepal.Length, iris[[input$features]],
             xlab = "Sepal length", ylab = "Feature", )
    })
    
    output$iristable <- renderDataTable(iris)
}

#render shiny app
shinyApp(ui, server)
