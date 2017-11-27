setwd("../")
devtools::install() # Build library
library(BioCircos)
library(shiny)

shinyUi <- fluidPage(
	mainPanel(p("BioCircos output:"),BioCircosOutput("testBioCircos")),
	sidebarPanel(textInput("testInput", "Your input:")),	
	title = "BioCircos example"
)

shinyServer <- function(input, output) {
	output$testBioCircos <- renderBioCircos({
		BioCircos(input$testInput)
	})
}

shinyApp(shinyUi, shinyServer)