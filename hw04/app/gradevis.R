# ===================================================================
# HW04 Grade Visualizer Shiny App
# Description: Shiny App for visualizing grades
# Inputs: cleaned score data, variables of interest
# Output: various plots for different variables
# Author: Yowsean Li
# Date: 11-13-2017
# ===================================================================
library(shiny)
library(ggplot2)

# Define UI ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Grade Visualizer"),
  
  # Sidebar layout ----
  sidebarLayout(
    
    # Sidebar panel conditioned on tab ----
    sidebarPanel(
      conditionalPanel(condition="input.tabselected=='Barchart'",
                       h4("Grades Distribution"),
                       tableOutput("gdist")
      ),
      conditionalPanel(condition="input.tabselected=='Histogram'",
                       selectInput("xvar", "X-axis variable",
                                   c("HW1","HW2","HW3","HW4","HW5",
                                     "HW6","HW7","HW8","HW9","ATT",
                                     "QZ1","QZ2","QZ3","QZ4","EX1",
                                     "EX2","Test1","Test2",
                                     "Homework","Quiz","Lab",
                                     "Overall")),
                       sliderInput("bin", "Bin Width:",
                                   value = 10,
                                   min = 1,
                                   max = 10)
      ),
      conditionalPanel(condition="input.tabselected=='Scatterplot'",
                       selectInput("xvar2", "X-axis variable",
                                   c("HW1","HW2","HW3","HW4","HW5",
                                     "HW6","HW7","HW8","HW9","ATT",
                                     "QZ1","QZ2","QZ3","QZ4","EX1",
                                     "EX2","Test1","Test2",
                                     "Homework","Quiz","Lab",
                                     "Overall")),
                       selectInput("yvar2", "Y-axis variable",
                                   c("HW1","HW2","HW3","HW4","HW5",
                                     "HW6","HW7","HW8","HW9","ATT",
                                     "QZ1","QZ2","QZ3","QZ4","EX1",
                                     "EX2","Test1","Test2",
                                     "Homework","Quiz","Lab",
                                     "Overall")),
                       sliderInput("opacity", "Opacity",
                                   value = 0.5,
                                   min = 0,
                                   max = 1),
                       radioButtons("line", "Show line",
                                    c("none", "lm", "loess"))
      )
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Tabset w/ barchart, histogram, scatterplot ----
      tabsetPanel(
        tabPanel("Barchart",
                 plotOutput("gbar")
        ),
        tabPanel("Histogram",
                 plotOutput("hist"),
                 h5("Summary Statistics"),
                 verbatimTextOutput("summary")
        ),
        tabPanel("Scatterplot",
                 plotOutput("scatter"),
                 h5("Correlation:"),
                 verbatimTextOutput("corr")
        ),
        id = "tabselected"
      )
    )
  )
)

# Define server logic for grade distribution app ----
server <- function(input, output) {
  grade_data <- reactive({
    read.csv('../data/cleandata/cleanscores.csv')
  })
  
  # Table 
  output$gdist <- renderTable({
    dat <- grade_data()
    tbl <- as.data.frame(table(dat$Grade))
    tbl$Prop <- tbl$Freq/sum(tbl$Freq)
    colnames(tbl)[1] <- 'Grade'
    tbl$Grade  <- factor(tbl$Grade,
                         levels = c("A+","A", "A-",
                                    "B+","B", "B-",
                                    "C+","C", "C-",
                                    "D", "F"))
    tbl[order(tbl$Grade),]
  })
  
  # Barchart of grades
  output$gbar <- renderPlot({
    dat <- grade_data()
    tbl <- as.data.frame(table(dat$Grade))
    colnames(tbl)[1] <- 'Grade'
    tbl$Grade  <- factor(tbl$Grade,
                         levels = c("A+","A", "A-",
                                    "B+","B", "B-",
                                    "C+","C", "C-",
                                    "D", "F"))
    tbl <- tbl[order(tbl$Grade),]
    ggplot(tbl, aes(x=Grade, y=Freq)) +
      geom_bar(stat='identity', alpha="0.75", fill = "#2196F3") +
      xlab('Grade') +
      scale_y_continuous(name="Frequency", breaks = seq(0, 55, 5), limits=c(0, 55)) +
      theme_minimal()
  })
  
  # Histogram for selected variable
  output$hist <- renderPlot({
    dat <- grade_data()
    ggplot(dat, aes_string(x=input$xvar)) +
      geom_histogram(binwidth = input$bin, fill="#9E9E9E", col="white") +
      scale_x_continuous(name=input$xvar, breaks = seq(0, 110, input$bin), limits=c(0, 110)) +
      scale_y_continuous(name="count", breaks = seq(0, 130, 20), limits=c(0, 130)) +
      theme_minimal()
  })
  
  # Summary of selected variable
  output$summary <- renderPrint({
    source("../code/functions.R")
    dat <- grade_data()
    print_stats(summary_stats(dat[,input$xvar]))
  })
  
  # Scatterplot of 2 variables
  output$scatter <- renderPlot({
    dat <- grade_data()
    ggplot(dat, aes_string(x=input$xvar2, y=input$yvar2)) +
      geom_point(alpha=input$opacity, size=3) +
      geom_smooth(method=input$line) +
      scale_x_continuous(name=input$xvar2, breaks = seq(0, 100, 10), limits=c(0, 100)) +
      scale_y_continuous(name=input$yvar2, breaks = seq(0, 100, 10), limits=c(0, 100)) +
      theme_minimal()
  })
  
  # Correlation coefficient of 2 variables
  output$corr <- renderText({
    dat <- grade_data()
    cor(dat[,input$xvar2], dat[,input$yvar2])
  })
}

# Run the application 
shinyApp(ui = ui, server = server)