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
		tracks = tracks + BioCircosTextTrack("testText", input$testInput, weight = "lighter", x = - 0.17, y = - 0.87)
		arcsEnds = round(runif(7, 50000001, 133851895))
		arcsLengths = round(runif(7, 1, 50000000))
		tracks = tracks + BioCircosArcTrack("fredTestArc", as.character(sample(1:12, 7, replace=T)), 
			starts = arcsEnds - arcsLengths, ends = arcsEnds, labels = 1:7, maxRadius = 0.97, minRadius = 0.83)
		linkPos1 = round(runif(5, 1, 50000000))
		linkPos2 = round(runif(5, 1, 50000000))
		chr1 = sample(1:22, 5, replace = T)
		chr2 = sample(1:22, 5, replace = T)
		linkPos3 = round(runif(5, 1, 50000000))
		linkPos4 = round(runif(5, 1, 50000000))
		chr3 = sample(1:22, 5, replace = T)
		chr4 = sample(1:22, 5, replace = T)
		tracks = tracks + BioCircosLinkTrack("testLink", gene1Chromosomes = chr1, 
			gene1Starts = linkPos1, gene1Ends = linkPos1+1, gene2Chromosomes = chr2, axisPadding = 6,
			color = "#EEEE55", width = "0.3em", labels = paste(chr1, chr2, sep = "*"), displayLabel = F,
			gene2Starts = linkPos2, gene2Ends = linkPos2+1, maxRadius = 0.42)
		tracks = tracks + BioCircosLinkTrack("testLink", gene1Chromosomes = chr3, 
			gene1Starts = linkPos3, gene1Ends = linkPos3+5000000, gene2Chromosomes = chr4, axisPadding = 6,
			color = "#FF6666", labels = paste(chr3, chr4, sep = "-"), displayLabel = F,
			gene2Starts = linkPos4, gene2Ends = linkPos4+2500000, maxRadius = 0.42)
		tracks = tracks + BioCircosSNPTrack("testSNP3", "7", 1, 0, minRadius = 0.3, maxRadius = 0.9, size = 6, range = c(-0.5,0.5))
		BioCircos(tracks, genomeFillColor = "Spectral", yChr = T, chrPad = 0, displayGenomeBorder = F, 
			genomeTicksLen = 3, genomeTicksTextSize = 0, genomeTicksScale = 50000000,
			genomeLabelTextSize = 18, genomeLabelDy = 0)
	})
}

shinyApp(shinyUi, shinyServer)
