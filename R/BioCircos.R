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
#' @param tracks A list of tracks to display.
#' @param genome A list of chromosome lengths to be used as reference for the vizualization or 'hg19' to use
#'  the chromosomes 1 to 22 and the sexual chromosomes according to the hg19 reference.
#' @param yChr A logical stating if the Y chromosome should be displayed. Used only when genome is set to 'hg19'.
#' @param genomeFillColor The color to display in each chromosome. Can be a RColorBrewer palette name used to
#'  generate one color per chromosome, or a character object or vector of character objects stating RGB values in hexadecimal
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
#' @param zoom Is zooming and moving in the visualization allowed?
#' 
#' @param TEXTModuleDragEvent Are text annotations draggable?
#' 
#' @param SNPMouseOverDisplay Display the tooltip when mouse hover on a SNP point.
#' @param SNPMouseOverColor Color of the SNP point when hovered by the mouse, in hexadecimal RGB format.
#' @param SNPMouseOverCircleSize Size of the SNP point when hovered by the mouse.
#' 
#' @param SNPMouseOutDisplay Hide tooltip when mouse is not hovering a SNP point anymore.
#' @param SNPMouseOutColor Color of the SNP point when mouse is not hovering a SNP point anymore, in hexadecimal
#'  RGB format. To revert back to original color, use the value "none".
#' 
#' @param SNPMouseOverTooltipsHtml01 Label displayed in tooltip in first position, before chromosome number.
#' @param SNPMouseOverTooltipsHtml02 Label displayed in tooltip in second position, before genomic position.
#' @param SNPMouseOverTooltipsHtml03 Label displayed in tooltip in third position, before value.
#' @param SNPMouseOverTooltipsHtml04 Label displayed in tooltip in fourth position, before SNP labels if any.
#' @param SNPMouseOverTooltipsHtml05 Label displayed in tooltip in fifth position, after SNP labels if any.
#' @param SNPMouseOverTooltipsBorderWidth The thickness of the tooltip borders, with units specified (such as em or px). 
#' 
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' 
#' @param ... Ignored
#' 
#' @export
BioCircos <- function(tracklist,
  genome = "hg19", yChr = TRUE,
  genomeFillColor = "Spectral",
  chrPad = 0.04, 
  displayGenomeBorder = TRUE, genomeBorderColor = "#000", genomeBorderSize = 0.5,
  genomeTicksDisplay = TRUE, genomeTicksLen = 5, genomeTicksColor = "#000", 
  genomeTicksTextSize = 10, genomeTicksTextColor = "#000", genomeTicksScale = 30000000,
  genomeLabelDisplay = TRUE, genomeLabelTextSize = 15, genomeLabelTextColor = "#000",
  genomeLabelDx = 0.028, genomeLabelDy = "-0.55em",
  zoom = TRUE, TEXTModuleDragEvent = FALSE,
  SNPMouseOverDisplay = TRUE, SNPMouseOverColor = "#FF0000", SNPMouseOverCircleSize = 3,
  SNPMouseOverCircleOpacity = 0.9,
  SNPMouseOutDisplay = TRUE, SNPMouseOutColor = "none",
  SNPMouseOverTooltipsHtml01 = "Chromosome: ", SNPMouseOverTooltipsHtml02 = "<br/>Position: ",
  SNPMouseOverTooltipsHtml03 = "<br/>Value: ", SNPMouseOverTooltipsHtml04 = "<br/>",  SNPMouseOverTooltipsHtml05 = "",
  SNPMouseOverTooltipsBorderWidth = "1px",
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

  # If genomeFillColor is a palette, create corresponding color vector
  genomeFillColor = .BioCircosColorCheck(genomeFillColor, length(genome), "genomeFillColor")

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
    genomeLabelDy = genomeLabelDy,
    SNPMouseEvent = T,
    SNPMouseClickDisplay = F,
    SNPMouseClickColor = "red",
    SNPMouseClickCircleSize = 4,
    SNPMouseClickCircleOpacity = 1.0,
    SNPMouseClickCircleStrokeColor = "#F26223",
    SNPMouseClickCircleStrokeWidth = 0,
    SNPMouseClickTextFromData = "fourth",
    SNPMouseClickTextOpacity = 1.0,
    SNPMouseClickTextColor = "red",
    SNPMouseClickTextSize = 8,
    SNPMouseClickTextPostionX = 1.0,
    SNPMouseClickTextPostionY = 10.0,
    SNPMouseClickTextDrag = T,
    SNPMouseDownDisplay = F,
    SNPMouseDownColor = "green",
    SNPMouseDownCircleSize = 4,
    SNPMouseDownCircleOpacity = 1.0,
    SNPMouseDownCircleStrokeColor = "#F26223",
    SNPMouseDownCircleStrokeWidth = 0,
    SNPMouseEnterDisplay = F,
    SNPMouseEnterColor = "yellow",
    SNPMouseEnterCircleSize = 4,
    SNPMouseEnterCircleOpacity = 1.0,
    SNPMouseEnterCircleStrokeColor = "#F26223",
    SNPMouseEnterCircleStrokeWidth = 0,
    SNPMouseLeaveDisplay = F,
    SNPMouseLeaveColor = "pink",
    SNPMouseLeaveCircleSize = 4,
    SNPMouseLeaveCircleOpacity = 1.0,
    SNPMouseLeaveCircleStrokeColor = "#F26223",
    SNPMouseLeaveCircleStrokeWidth = 0,
    SNPMouseMoveDisplay = F,
    SNPMouseMoveColor = "red",
    SNPMouseMoveCircleSize = 2,
    SNPMouseMoveCircleOpacity = 1.0,
    SNPMouseMoveCircleStrokeColor = "#F26223",
    SNPMouseMoveCircleStrokeWidth = 0,
    SNPMouseOutDisplay = SNPMouseOutDisplay,
    SNPMouseOutAnimationTime = 500,
    SNPMouseOutColor = SNPMouseOutColor,
    SNPMouseOutCircleSize = 2,
    SNPMouseOutCircleOpacity = 1.0,
    SNPMouseOutCircleStrokeColor = "red",
    SNPMouseOutCircleStrokeWidth = 0,
    SNPMouseUpDisplay = F,
    SNPMouseUpColor = "grey",
    SNPMouseUpCircleSize = 4,
    SNPMouseUpCircleOpacity = 1.0,
    SNPMouseUpCircleStrokeColor = "#F26223",
    SNPMouseUpCircleStrokeWidth = 0,
    SNPMouseOverDisplay = SNPMouseOverDisplay,
    SNPMouseOverColor = SNPMouseOverColor,
    SNPMouseOverCircleSize = SNPMouseOverCircleSize,
    SNPMouseOverCircleOpacity = SNPMouseOverCircleOpacity,
    SNPMouseOverCircleStrokeColor = "#F26223",
    SNPMouseOverCircleStrokeWidth = 1,
    SNPMouseOverTooltipsHtml01 =  SNPMouseOverTooltipsHtml01,
    SNPMouseOverTooltipsHtml02 =  SNPMouseOverTooltipsHtml02,
    SNPMouseOverTooltipsHtml03 =  SNPMouseOverTooltipsHtml03,
    SNPMouseOverTooltipsHtml04 =  SNPMouseOverTooltipsHtml04,
    SNPMouseOverTooltipsHtml05 =  SNPMouseOverTooltipsHtml05,
    SNPMouseOverTooltipsBorderWidth = SNPMouseOverTooltipsBorderWidth,
    zoom = zoom,
    TEXTModuleDragEvent = TEXTModuleDragEvent
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

#' Create a background track to be added to a BioCircos tracklist
#'
#' Simple background to display behind another track
#' 
#' @param trackname The name of the new track.
#' 
#' @param fillColors The color of the background element, in hexadecimal RGB format.
#' @param borderColors The color of the background borders, in hexadecimal RGB format.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' @param borderSize The thickness of the background borders.
#' 
#' @param ... Ignored
#' 
#' @export
BioCircosBackgroundTrack <- function(trackname, 
  fillColors = "#EEEEFF", borderColors = "#000000",
  maxRadius = 0.9, minRadius = 0.5, borderSize = 0.3, ...){
  track1 = paste("BACKGROUND", trackname, sep="_")
  track2 = list(BgouterRadius = maxRadius, BginnerRadius = minRadius, 
    BgFillColor = fillColors,
    BgborderColor = borderColors,
    BgborderSize = borderSize)
  track = BioCircosTracklist() + list(list(track1, track2))
  return(track)
}

#' Create a Text track to be added to a BioCircos tracklist
#'
#' Simple text annotation displayed in the visualization
#' 
#' @param trackname The name of the new track.
#' 
#' @param text The text to be displayed.
#' 
#' @param x,y Coordinates of the lower left corner of the annotation, in proportion of the inner radius of the plot.
#' @param size Font size, with units specified (such as em or px).
#' @param color Font color, in hexadecimal RGB format.
#' @param weight Font weight. Can be "normal", "bold", "bolder" or "lighter".
#' @param opacity Font opacity.
#' 
#' @param ... Ignored
#' 
#' @export
BioCircosTextTrack <- function(trackname, text,
  x = -0.15, y = 0, size = "1.2em", weight = "bold", opacity = 1, color = "#000000", ...){
  track1 = paste("TEXT", trackname, sep="_")
  track2 = list(x = x,
     y = y,
     textSize = size,
     textWeight = weight,
     textColor = color,
     textOpacity = opacity,
     text = text)
  track = BioCircosTracklist() + list(list(track1, track2))
  return(track)
}

#' Create a track with SNPs to be added to a BioCircos tracklist
#'
#' SNPs are defined by genomic coordinates and associated with a numerical value
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
#' @param colors The colors for each point. Can be a RColorBrewer palette name used to
#'  generate one color per point, or a character object or vector of character objects stating RGB values in hexadecimal
#'  format or base R colors. If the vector is shorter than the number of points, values will be repeated.
#' @param labels One or multiple character objects to label each point.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' 
#' @param ... Ignored
#' 
#' @export
BioCircosSNPTrack <- function(trackname, chromosomes, positions, values,
  colors = "#40B9D4", labels = "",
  maxRadius = 0.9, minRadius = 0.5, ...){
  
  # If colors is a palette, create corresponding color vector
  colors = .BioCircosColorCheck(colors, length(positions), "colors")

  track1 = paste("SNP", trackname, sep="_")
  track2 = list(maxRadius = maxRadius, minRadius = minRadius, 
    SNPFillColor = "#9400D3",
    PointType = "circle",
    circleSize = 2,
    rectWidth = 2,
    rectHeight = 2)
  tabSNP = suppressWarnings(rbind(chromosomes, positions, values, colors, labels))
  rownames(tabSNP) = c("chr", "pos", "value", "color", "des")
  track3 = unname(alply(tabSNP, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}

#' Create a track with arcs to be added to a BioCircos tracklist
#'
#' Arcs are defined by beginning and ending genomic coordinates
#' 
#' @param trackname The name of the new track.
#' 
#' @param chromosomes A vector containing the chromosomes on which each arcs are found.
#'  Values should match the chromosome names given in the genome parameter of the BioCircos function.
#' @param starts,ends Vectors containing the coordinates on which each arcs begin or end.
#'  Values should be inferior to the chromosome lengths given in the genome parameter of the BioCircos function.
#' 
#' @param colors The colors for each arc. Can be a RColorBrewer palette name used to
#'  generate one color per arc, or a character object or vector of character objects stating RGB values in hexadecimal
#'  format or base R colors. If the vector is shorter than the number of arcs, values will be repeated.
#' @param labels One or multiple character objects to label each arc.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' 
#' @param ... Ignored
#' 
#' @export
BioCircosArcTrack <- function(trackname, chromosomes, starts, ends,
  colors = "#40B9D4", labels = "",
  maxRadius = 0.9, minRadius = 0.5, ...){
  
  # If colors is a palette, create corresponding color vector
  colors = .BioCircosColorCheck(colors, length(starts), "colors")

  track1 = paste("ARC", trackname, sep="_")
  track2 = list(outerRadius = maxRadius - 8/7, innerRadius = minRadius- 1) # In JS lib the innerRadius and outerRadius are
  # based on the inner and outer radii of the chromosome. Here we convert the arc coordinates to percentage of the space
  # inside the chromosome, based on the assumption that the inner and outer radii of the chromosome are respectively at 70
  # and 80 percents of the widget minimal dimension. The conversion to absolute values is performed on the JavaScript side. 
  tabSNP = suppressWarnings(rbind(chromosomes, starts, ends, colors, labels))
  rownames(tabSNP) = c("chr", "start", "end", "color", "des")
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

.BioCircosColorCheck <- function(colVar, colLength, varName = "Color") {
# If genomeFillColor is a string, create corresponding palette
  colorError = paste0("\'", varName, 
    "\' parameter should be either a vector of chromosome colors or the name of a RColorBrewer brewer.")
  if(class(colVar) == "character"){
    if((colVar %in% rownames(RColorBrewer::brewer.pal.info))&&(length(colVar) == 1)) { # RColorBrewer's brewer
      colVar = grDevices::colorRampPalette(RColorBrewer::brewer.pal(8, colVar))(colLength)
    }
    else if(!all(grepl("^#", colVar))){ # Not RGB values
      if(all(colVar %in% colors())){
        colVar = rgb(t(col2rgb(colVar))/255)
      }
      else{ # Unknown format
        stop(colorError)
      }
    }
  }
  else{
      stop(colorError)
  }
  return(colVar)
}