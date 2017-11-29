setwd("../")
devtools::document() 
devtools::install() # Build library
library(BioCircos)
library(shiny)

shinyUi <- fluidPage(
	mainPanel(p("BioCircos output:"),BioCircosOutput("testBioCircos", height = 600)),
	sidebarPanel(textInput("testInput", "Your input:")),	
	title = "BioCircos example"
)

shinyServer <- function(input, output) {
	output$testBioCircos <- renderBioCircos({
		tracks = BioCircosSNPTrack("testTrack1", as.character(rep(1:10,10)), round(runif(100, 1, 135534747)), 
			runif(100, 0, 10), colors = "Spectral")
		tracks = tracks + BioCircosSNPTrack("testTrack2", as.character(rep(1:15,5)), round(runif(75, 1, 102531392)), 
			runif(75, 2, 12), colors = c("#FF0000", "#DD1111", "#BB2222", "#993333"))
		BioCircos(input$testInput, tracks, genomeFillColor = "Spectral", yChr = T, chrPad = 0, displayGenomeBorder = F, 
			genomeTicksLen = 3, genomeTicksTextSize = 0, genomeTicksScale = 50000000,
			genomeLabelTextSize = 18, genomeLabelDy = 0)
	})
}

shinyApp(shinyUi, shinyServer)