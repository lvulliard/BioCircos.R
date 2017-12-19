## ----eval=FALSE----------------------------------------------------------
#  install.packages('BioCircos')

## ----eval=FALSE----------------------------------------------------------
#  # You need devtools for that
#  if (!require('devtools')){install.packages('devtools')}
#  
#  devtools::install_github('lvulliard/BioCircos.R', build_vignettes = TRUE))

## ------------------------------------------------------------------------
library(BioCircos)

BioCircos()

## ------------------------------------------------------------------------
library(BioCircos)

BioCircos(genome = "hg19", yChr = FALSE, genomeFillColor = "Reds", chrPad = 0, 
	displayGenomeBorder = FALSE, genomeTicksDisplay = FALSE, genomeLabelDy = 0)

## ------------------------------------------------------------------------
library(BioCircos)

myGenome = list("A" = 10560,
        "B" = 8808,
        "C" = 12014,
        "D" = 7664,
        "E" = 9403,
        "F" = 8661)

BioCircos(genome = myGenome, genomeFillColor = c("tomato2", "darkblue"),
	genomeTicksScale = 4e+3)

## ------------------------------------------------------------------------
library(BioCircos)

tracklist = BioCircosTextTrack('myTextTrack', 'Some text', size = "2em", opacity = 0.5, x = -0.67, y = -0.5)

BioCircos(tracklist, genomeFillColor = "PuOr",
	chrPad = 0, displayGenomeBorder = FALSE, 
	genomeTicksLen = 2, genomeTicksTextSize = 0, genomeTicksScale = 1e+8,
	genomeLabelTextSize = "9pt", genomeLabelDy = 0)

## ------------------------------------------------------------------------
library(BioCircos)

tracklist = BioCircosBackgroundTrack("myBackgroundTrack", minRadius = 0.5, maxRadius = 0.8,
	borderColors = "#AAAAAA", borderSize = 0.6, fillColors = "#FFBBBB")	

BioCircos(tracklist, genomeFillColor = "PuOr",
	chrPad = 0.05, displayGenomeBorder = FALSE, 
	genomeTicksDisplay = FALSE,	genomeLabelTextSize = "9pt", genomeLabelDy = 0)

## ------------------------------------------------------------------------
library(BioCircos)

points_chromosomes = c('X', '2', '7', '13', '9') # Chromosomes on which the points should be displayed
points_coordinates = c(102621, 140253678, 98567307, 28937403, 20484611) # Chromosomes on which the points should be displayed
points_values = 0:4 # Values associated with each point, used as radial coordinate on a scale going to minRadius for the lowest value to maxRadius for the highest value

tracklist = BioCircosSNPTrack('mySNPTrack', points_chromosomes, points_coordinates, points_values,
	colors = c("tomato2", "darkblue"), minRadius = 0.5, maxRadius = 0.9)

# Background are always placed below other tracks
tracklist = tracklist + BioCircosBackgroundTrack("myBackgroundTrack", minRadius = 0.5, maxRadius = 0.9,
	borderColors = "#AAAAAA", borderSize = 0.6, fillColors = "#B3E6FF")	

BioCircos(tracklist, genomeFillColor = "PuOr",
	chrPad = 0.05, displayGenomeBorder = FALSE, yChr =  FALSE,
	genomeTicksDisplay = FALSE,	genomeLabelTextSize = 18, genomeLabelDy = 0)

## ------------------------------------------------------------------------
library(BioCircos)

arcs_chromosomes = c('X', '2', '9') # Chromosomes on which the arcs should be displayed
arcs_begin = c(1, 140253678, 20484611)
arcs_end = c(155270560, 154978472, 42512974)

tracklist = BioCircosArcTrack('myArcTrack', arcs_chromosomes, arcs_begin, arcs_end,
	minRadius = 1.18, maxRadius = 1.25)

BioCircos(tracklist, genomeFillColor = "PuOr",
	chrPad = 0.02, displayGenomeBorder = FALSE, yChr =  FALSE,
	genomeTicksDisplay = FALSE,	genomeLabelTextSize = 0)

## ------------------------------------------------------------------------
library(BioCircos)

links_chromosomes_1 = c('X', '2', '9') # Chromosomes on which the links should start
links_chromosomes_2 = c('3', '18', '9') # Chromosomes on which the links should end

links_pos_1 = c(155270560, 154978472, 42512974)
links_pos_2 = c(102621477, 140253678, 20484611)
links_labels = c("Link 1", "Link 2", "Link 3")

tracklist = BioCircosBackgroundTrack("myBackgroundTrack", minRadius = 0, maxRadius = 0.55,
	borderSize = 0, fillColors = "#EEFFEE")	

tracklist = tracklist + BioCircosLinkTrack('myLinkTrack', links_chromosomes_1, links_pos_1, links_pos_1 + 50000000,
	links_chromosomes_2, links_pos_2, links_pos_2 + 75000000,
	maxRadius = 0.55, labels = links_labels)

BioCircos(tracklist, genomeFillColor = "PuOr",
	chrPad = 0.02, displayGenomeBorder = FALSE, yChr =  FALSE,
	genomeTicksDisplay = FALSE,	genomeLabelTextSize = "8pt", genomeLabelDy = 0)

## ----sessionINFO---------------------------------------------------------
sessionInfo()

