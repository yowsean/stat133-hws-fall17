#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)


# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Drawing Balls Experiment"),
  
  # Sidebar  
  sidebarLayout(
    sidebarPanel(
      sliderInput("reps",
                  label = "Number of repetitions:",
                  min = 1,
                  max = 5000,
                  value = 100),
      sliderInput("threshold",
                  label = "Threshold for choosing boxes:",
                  min = 0,
                  max = 1,
                  value = 0.5)
    ),
    
    # Show a plot of the relative frequencies
    mainPanel(
      plotOutput("freqs_plot")
    )
  )
)

# Define server logic required to draw the plot
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$freqs_plot <- renderPlot({
    box1 <- c('b', 'b', 'r')
    box2 <- c('b', 'b', 'r', 'r', 'r', 'w')
    drawn <- matrix(nrow=input$reps, ncol=4)
    
    sim <- function (box1, box2) {
      r <- runif(1)
      if (r > input$threshold) {
        sample(box1, 4, replace=TRUE)
      } else {
        sample(box2, 4, replace=FALSE)
      }
    }
    counts <- c(0,0,0,0,0)
    freqs <- matrix(nrow=input$reps, ncol=5)
    for (i in 1:input$reps) {
      drawn[i, ] <- sim(box1, box2)
      b_count <- sum(drawn[i, ] == 'b')
      counts[b_count + 1] <- counts[b_count + 1] + 1
      freqs[i, ] <- counts / i
    }
    plot(1:input$reps, freqs[, 1], type="l", col="red", xlab='reps', ylab='freqs', main='Relative frequencies of number of blue balls')
    par(new=TRUE)
    plot(1:input$reps, freqs[, 2], type="l", col="brown", ann=FALSE, axes = FALSE)
    par(new=TRUE)
    plot(1:input$reps, freqs[, 3], type="l", col="green", ann=FALSE, axes = FALSE)
    par(new=TRUE)
    plot(1:input$reps, freqs[, 4], type="l", col="blue", ann=FALSE, axes = FALSE)
    par(new=TRUE)
    plot(1:input$reps, freqs[, 5], type="l", col="pink", ann=FALSE, axes = FALSE)
    legend(1, 95, legend=c("Line 1", "Line 2"), col=c("red", "blue"), lty=1:2, cex=0.8)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

