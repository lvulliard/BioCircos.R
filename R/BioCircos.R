#' BioCircos
#'
#' Interactive circular visualisation of genomic data using ‘htmlwidgets’ and ‘BioCircos.js’
#'
#' @import htmlwidgets
#' @import RColorBrewer
#' @import plyr
#' @import jsonlite
#'
#' @export

#' BioCircos widget
#'
#' Interactive circular visualisation of genomic data using ‘htmlwidgets’ and ‘BioCircos.js’
#' 
#' @param message A message to display.
#' @param tracks A list of tracks to display.
#' @param genome A list of chromosome lengths to be used as reference for the vizualization or 'hg19' to use
#'  the chromosomes 1 to 22 and the sexual chromosomes according to the hg19 reference.
#' @param yChr A logical stating if the Y chromosome should be displayed. Used only when genome is set to 'hg19'.
#' @param genomeFillColor The color to display in each chromosome. Can be a RColorBrewer palette name used to
#'  generate one color per chromosome, or a character or vector of characters stating RGB values in hexadecimal
#'  format or base R colors. If the vector is shorter than the reference genome, values will be repeated.
#' @param chrPad Distance between chromosomes.
#' 
#' @param displayGenomeBorder,genomeBorderColor,genomeBorderSize Should the reference genome have borders?
#'  If yes specify the color, in RGB hexadecimal format, and the thickness.
#'
#' @param genomeTicksDisplay,genomeTicksLen,genomeTicksColor,genomeTicksTextSize,genomeTicksTextColor,genomeTicksScale
#'  Should the refence genome have ticks, of which length, color (in hexadecimal RGB format), with labels in which font
#' size and color, and spaced by how many bases?
#' @param genomeLabelDisplay,genomeLabelTextSize,genomeLabelTextColor,genomeLabelDx,genomeLabelDy
#'  Should the reference genome have labels on each chromosome, in which font size and color? Moreover rotation
#'  and radius shifts for the label texts can be added
#' 
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' 
#' @param ... Ignored
#' 
#' @export
BioCircos <- function(message, tracklist,
  genome = "hg19", yChr = TRUE,
  genomeFillColor = "Spectral",
  chrPad = 0.04, 
  displayGenomeBorder = TRUE, genomeBorderColor = "#000", genomeBorderSize = 0.5,
  genomeTicksDisplay = TRUE, genomeTicksLen = 5, genomeTicksColor = "#000", 
  genomeTicksTextSize = 10, genomeTicksTextColor = "#000", genomeTicksScale = 30000000,
  genomeLabelDisplay = TRUE, genomeLabelTextSize = 15, genomeLabelTextColor = "#000",
  genomeLabelDx = 0.028, genomeLabelDy = "-0.55em",
  width = NULL, height = NULL, elementId = NULL, ...) {

  # If genome is a string, convert to corresponding chromosome lengths
  if(class(genome) == "character"){
    if(genome == "hg19"){
      genome = list("1" = 249250621, #Hg19
        "2" = 243199373,
        "3" = 198022430,
        "4" = 191154276,
        "5" = 180915260,
        "6" = 171115067,
        "7" = 159138663,
        "8" = 146364022,
        "9" = 141213431,
        "10" = 135534747,
        "11" = 135006516,
        "12" = 133851895,
        "13" = 115169878,
        "14" = 107349540,
        "15" = 102531392,
        "16" = 90354753,
        "17" = 81195210,
        "18" = 78077248,
        "19" = 59128983,
        "20" = 63025520,
        "21" = 48129895,
        "22" = 51304566,
        "X" = 155270560)

      if(yChr){ genome$"Y" = 59373566 }
    }
    else{
      stop("\'genome\' parameter should be either a list of chromosome lengths or \'hg19\'.")
    }
  }

  # If genomeFillColor is a string, create corresponding palette
  genomeFillColorError = "\'genomeFillColor\' parameter should be either a vector of chromosome colors or the name of a RColorBrewer brewer."
  if(class(genomeFillColor) == "character"){
    if((genomeFillColor %in% rownames(RColorBrewer::brewer.pal.info))&&(length(genomeFillColor) == 1)) { # RColorBrewer's brewer
      genomeFillColor = grDevices::colorRampPalette(RColorBrewer::brewer.pal(8, genomeFillColor))(length(genome))
    }
    else if(!all(grepl("^#", genomeFillColor))){ # Not RGB values
      if(all(genomeFillColor %in% colors())){
        genomeFillColor = rgb(t(col2rgb(genomeFillColor))/255)
      }
      else{ # Unknown format
        stop(genomeFillColorError)
      }
    }
  }
  else{
      stop(genomeFillColorError)
  }

  # forward options using x
  x = list(
    message = message,
    tracklist = tracklist,
    genome = genome,
    genomeFillColor = genomeFillColor,
    chrPad = chrPad, 
    displayGenomeBorder = displayGenomeBorder, 
    genomeBorderColor = genomeBorderColor, 
    genomeBorderSize = genomeBorderSize,
    genomeTicksDisplay = genomeTicksDisplay, 
    genomeTicksLen = genomeTicksLen, 
    genomeTicksColor = genomeTicksColor,
    genomeTicksTextSize = genomeTicksTextSize, 
    genomeTicksTextColor = genomeTicksTextColor, 
    genomeTicksScale = genomeTicksScale,
    genomeLabelDisplay = genomeLabelDisplay, 
    genomeLabelTextSize = genomeLabelTextSize, 
    genomeLabelTextColor = genomeLabelTextColor,
    genomeLabelDx = genomeLabelDx, 
    genomeLabelDy = genomeLabelDy 
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'BioCircos',
    x,
    width = width,
    height = height,
    package = 'BioCircos',
    elementId = elementId
  )
}

#' Shiny bindings for BioCircos
#'
#' Output and render functions for using BioCircos within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a BioCircos
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name BioCircos-shiny
#'
#' @export
BioCircosOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'BioCircos', width, height, package = 'BioCircos')
}

#' @rdname BioCircos-shiny
#' @export
renderBioCircos <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, BioCircosOutput, env, quoted = TRUE)
}

#' Create a track with SNPs to be added to a BioCircos tracklist
#'
#' SNPs are defined by genomic coordinates and associated with a numerical value
#' 
#' @param tracklist The list of tracks of your BioCircos visualization.
#' 
#' @param trackname The name of the new track.
#' 
#' @param chromosomes A vector containing the chromosomes on which each SNP are found.
#'  Values should match the chromosome names given in the genome parameter of the BioCircos function.
#' @param positions A vector containing the coordinates on which each SNP are found.
#'  Values should be inferior to the chromosome lengths given in the genome parameter of the BioCircos function.
#' @param values A vector of numerical values associated with each SNPs, used to determine the 
#'  radial coordinates of each point on the visualization.
#' 
#' @export
BioCircosSNPTrack <- function(trackname, chromosomes, positions, values){
  track1 = paste("SNP", trackname, sep="_")
  track2 = list(maxRadius = 120, minRadius = 100, 
    SNPFillColor = "#9400D3",
    PointType = "circle",
    circleSize = 2,
    rectWidth = 2,
    rectHeight = 2)
  tabSNP = rbind(chromosomes, positions, values, "#40B9D4", "rs603424")
  rownames(tabSNP) = c("chr", "pos", "value", "color", "des")
  track3 = unname(alply(tabSNP, 2, as.list))
  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}

#' Create a list of BioCircos tracks
#'
#' This allows the use of the '+' operator on these lists
#' 
#' @name BioCircosTracklist
#' 
#' @export
BioCircosTracklist <- function(){
  x = list()
  class(x) <- c("BioCircosTracklist")
    return(x)
}

#' @rdname BioCircosTracklist
#' @export
"+.BioCircosTracklist" <- function(x,...) {
  x <- append(x,...)
  if(class(x) != "BioCircosTracklist"){
    class(x) <- c("BioCircosTracklist")
  }
  return(x)
}