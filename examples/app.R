setwd("../")
devtools::document() 
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
		BioCircos(input$testInput, genomeFillColor = "Spectral", yChr = T, chrPad = 0, displayGenomeBorder = F, 
			genomeTicksLen = 3, genomeTicksTextSize = 0, genomeTicksScale = 50000000,
			genomeLabelTextSize = 18, genomeLabelDy = 0)
	})
}

shinyApp(shinyUi, shinyServer)