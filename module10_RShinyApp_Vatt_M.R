## Michael Vatt
## 19 DEC 2019
## Assignment 10: Create an R Shiny App


#### This is the ui.R script ####

shinyServer(
  pageWithSidebar(
    headerPanel("My First Shiny App"),
    
    sidebarPanel("Side Bar"), 
      selectInput("Distribution", "Please Select Distribution Type",
                  choices = c("Normal", "Exponential")),
      sliderInput("Sample Size", "Please Select Sample Size: ",
                  min = 100, max = 5000, value = 1000, step = 100),
      conditionalPanel(condition = "input.Distribution == 'Normal'",
                      textInput("Mean", "Please Select the Mean", 10),
                      textInpur("sd", "Please Select Standard Deviation", 3)),
    conditionalPanel(condition = "input.Distribution == 'Exponential'",
                      textInput("Lambda", "Please Select Exponential Lambda: ", 1))
      ),
    mainPanel(
      plotOutput("myPlot")
    
    )
 )


#### This is the server.R script ####

shinyServer(
 function(input, output, session){
   
   output$myPlot <- renderPlot({
     
     distType <- input$Distribution
     size <- input$sampleSize
     
     if(distType == "Normal"){
        randomVec <- rnorm(size, mean = as.numeric(input$mean), sd = as.numeric(input$sd))
     }
     else {
        randomVec <- rexp(size, rate = 1 / as.numeric(input$lambda))  
     }
     hist(randomVec, col = "orange")
   })  
 }
  
  
)  
