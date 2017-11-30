setwd("../")
devtools::document() 
devtools::install() # Build library
library(BioCircos)
library(shiny)

shinyUi <- fluidPage(
	mainPanel(p("BioCircos output:"),BioCircosOutput("testBioCircos", height = 600)),
	sidebarPanel(textInput("testInput", "Your input:", "Patient #61")),	
	title = "BioCircos example"
)

shinyServer <- function(input, output) {
	output$testBioCircos <- renderBioCircos({
		tracks = BioCircosSNPTrack("testTrack1", as.character(rep(1:10,10)), round(runif(100, 1, 135534747)), 
			runif(100, 0, 10), colors = "Spectral", minRadius = 0.3, maxRadius = 0.45)
		tracks = tracks + BioCircosSNPTrack("testTrack2", as.character(rep(1:15,5)), round(runif(75, 1, 102531392)), 
			runif(75, 2, 12), colors = c("#FF0000", "#DD1111", "#BB2222", "#993333"), maxRadius = 0.8)
		tracks = tracks + BioCircosBackgroundTrack("testBGtrack1", minRadius = 0.3, maxRadius = 0.45,
			borderColors = "#FFFFFF", borderSize = 0.6)		
		tracks = tracks + BioCircosBackgroundTrack("testBGtrack2", borderColors = "#FFFFFF", fillColor = "#FFEEEE",
			borderSize = 0.6, maxRadius = 0.8)
		tracks = tracks + BioCircosTextTrack("testText", input$testInput, weight = "lighter")
		arcsEnds = round(runif(7, 50000001, 133851895))
		arcsLengths = round(runif(7, 1, 50000000))
		tracks = tracks + BioCircosArcTrack("fredTestArc", as.character(sample(1:12, 7, replace=T)), 
			starts = arcsEnds - arcsLengths, ends = arcsEnds, labels = 1:7, maxRadius = 0.97, minRadius = 0.83)
		BioCircos(tracks, genomeFillColor = "Spectral", yChr = T, chrPad = 0, displayGenomeBorder = F, 
			genomeTicksLen = 3, genomeTicksTextSize = 0, genomeTicksScale = 50000000,
			genomeLabelTextSize = 18, genomeLabelDy = 0)
	})
}

shinyApp(shinyUi, shinyServer)
