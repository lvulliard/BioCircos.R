#' BioCircos 
#'
#' Interactive circular visualization of genomic data using ‘htmlwidgets’ and ‘BioCircos.js’
#'
#' @import htmlwidgets
#' @import RColorBrewer
#' @import plyr
#' @import jsonlite
#' @import grDevices
#'
#' @export

#' BioCircos widget
#'
#' Interactive circular visualization of genomic data using 'htmlwidgets' and 'BioCircos.js'
#' 
#' @param tracklist A list of tracks to display.
#' @param genome A list of chromosome lengths to be used as reference for the visualization or 'hg19' to use
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
#' @param genomeLabelDisplay,genomeLabelTextSize,genomeLabelTextColor,genomeLabelDx,genomeLabelDy,genomeLabelOrientation
#'  Should the reference genome have labels on each chromosome, in which font size and color? Moreover rotation
#'  and radius shifts for the label texts can be added, and the angle between the radius and the label changed.
#' 
#' @param zoom Is zooming and moving in the visualization allowed?
#' 
#' @param TEXTModuleDragEvent Are text annotations draggable?
#' 
#' @param SNPMouseOverDisplay Display the tooltip when mouse hover on a SNP point.
#' @param SNPMouseOverColor Color of the SNP point when hovered by the mouse, in hexadecimal RGB format.
#' @param SNPMouseOverCircleSize Size of the SNP point when hovered by the mouse.
#' @param SNPMouseOverCircleOpacity Opacity of the SNP point when hovered by the mouse.
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
#' @param ARCMouseOverDisplay Display the tooltip when mouse hover on an arc.
#' @param ARCMouseOverColor Color of the arc when hovered by the mouse, in hexadecimal RGB format.
#' @param ARCMouseOverArcOpacity Opacity of the arc when hovered by the mouse.
#' 
#' @param ARCMouseOutDisplay Hide tooltip when mouse is not hovering an arc anymore.
#' @param ARCMouseOutColor Color of the arc when mouse is not hovering an arc anymore, in hexadecimal
#'  RGB format. To revert back to original color, use the value "none".
#' 
#' @param ARCMouseOverTooltipsHtml01 Label displayed in tooltip in first position, before chromosome number.
#' @param ARCMouseOverTooltipsHtml02 Label displayed in tooltip in second position, before genomic position.
#' @param ARCMouseOverTooltipsHtml03 Label displayed in tooltip in third position, before value.
#' @param ARCMouseOverTooltipsHtml04 Label displayed in tooltip in fourth position, before ARC labels if any.
#' @param ARCMouseOverTooltipsHtml05 Label displayed in tooltip in fifth position, after ARC labels if any.
#' @param ARCMouseOverTooltipsBorderWidth The thickness of the tooltip borders, with units specified (such as em or px). 
#' 
#' @param CNVMouseOutDisplay Hide tooltip when mouse is not hovering an arc anymore.
#' @param CNVMouseOutColor Color of the line when mouse is not hovering anymore, in hexadecimal
#'  RGB format. To revert back to original color, use the value "none".
#' @param CNVMouseOutArcOpacity Opacity of the arc when not hovered by the mouse anymore.
#' @param CNVMouseOutArcStrokeColor Color of the arc's stroke when not hovered by the mouse anymore.
#' @param CNVMouseOutArcStrokeWidth Width of the arc's stroke when not hovered by the mouse anymore.
#' 
#' @param CNVMouseOverDisplay Display the tooltip when mouse hover on an arc.
#' @param CNVMouseOverColor Color of the arc when hovered by the mouse, in hexadecimal RGB format.
#' @param CNVMouseOverArcOpacity Opacity of the arc when hovered by the mouse.
#' @param CNVMouseOverArcStrokeColor Color of the arc's stroke when hovered by the mouse, in hexadecimal RGB format.
#' @param CNVMouseOverArcStrokeWidth Width of the arc's stroke when hovered by the mouse.
#' @param CNVMouseOverTooltipsHtml01 Label displayed in tooltip in first position, before chromosome number.
#' @param CNVMouseOverTooltipsHtml02 Label displayed in tooltip in second position, before starting position.
#' @param CNVMouseOverTooltipsHtml03 Label displayed in tooltip in second position, before ending position.
#' @param CNVMouseOverTooltipsHtml04 Label displayed in tooltip in third position, before value.
#' @param CNVMouseOverTooltipsHtml05 Label displayed in tooltip in third position, after value.
#' @param CNVMouseOverTooltipsBorderWidth The thickness of the tooltip borders, with units specified (such as em or px). 
#' 
#' @param LINEMouseOverDisplay Display the tooltip when mouse hover on a line.
#' @param LINEMouseOverLineOpacity Opacity of the line when hovered by the mouse, in hexadecimal RGB format.
#' @param LINEMouseOverLineStrokeColor Color of the line when hovered by the mouse, in hexadecimal RGB format.
#' @param LINEMouseOverLineStrokeWidth Width of the line when hovered by the mouse, in hexadecimal RGB format.
#' @param LINEMouseOverTooltipsHtml01 Label displayed in tooltip.
#' @param LINEMouseOverTooltipsBorderWidth The thickness of the tooltip borders, with units specified (such as em or px). 
#' 
#' @param LINEMouseOutDisplay Hide tooltip when mouse is not hovering a line anymore.
#' @param LINEMouseOutLineOpacity Opacity of the line when mouse is not hovering a link anymore.
#' @param LINEMouseOutLineStrokeColor Color of the line when mouse is not hovering anymore, in hexadecimal
#'  RGB format. To revert back to original color, use the value "none".
#' @param LINEMouseOutLineStrokeWidth Thickness of the line when mouse is not hovering a link anymore.
#' 
#' @param LINKMouseOverDisplay Display the tooltip when mouse hover on a link.
#' @param LINKMouseOverStrokeColor Color of the link when hovered.
#' @param LINKMouseOverOpacity Opacity of the link when hovered.
#' @param LINKMouseOverStrokeWidth Thickness of the link when hovered.
#' 
#' @param LINKMouseOutDisplay Hide tooltip when mouse is not hovering a link anymore.
#' @param LINKMouseOutStrokeColor Color of the link when mouse is not hovering anymore, in hexadecimal
#'  RGB format. To revert back to original color, use the value "none".
#' @param LINKMouseOutStrokeWidth Thickness of the link when mouse is not hovering a link anymore.
#' 
#' @param LINKMouseOverTooltipsHtml01 Label displayed in tooltip in first position, before label.
#' @param LINKMouseOverTooltipsHtml02 Label displayed in tooltip in second position, after label.
#' @param LINKMouseOverTooltipsBorderWidth The thickness of the tooltip borders, with units specified (such as em or px). 
#' 
#' @param BARMouseOverDisplay Display the tooltip when mouse hover on a bar.
#' @param BARMouseOverColor Color of the bar when hovered.
#' @param BARMouseOverOpacity Opacity of the bar when hovered.
#' @param BARMouseOverTooltipsHtml01 Label displayed in tooltip in first position, before chromosome number.
#' @param BARMouseOverTooltipsHtml02 Label displayed in tooltip in second position, before start position.
#' @param BARMouseOverTooltipsHtml03 Label displayed in tooltip in second position, before end position.
#' @param BARMouseOverTooltipsHtml04 Label displayed in tooltip in third position, before labels if any.
#' @param BARMouseOverTooltipsHtml05 Label displayed in tooltip in fourth position, before values.
#' @param BARMouseOverTooltipsHtml06 Label displayed in tooltip in fifth position, after values.
#' @param BARMouseOverTooltipsBorderWidth The thickness of the tooltip borders, with units specified (such as em or px). 
#' 
#' @param BARMouseOutDisplay Hide tooltip when mouse is not hovering a bar anymore.
#' @param BARMouseOutColor Color of the bar when mouse is not hovering anymore, in hexadecimal
#'  RGB format. To revert back to original color, use the value "none".
#' 
#' @param HEATMAPMouseOutDisplay Hide tooltip when mouse is not hovering a box anymore.
#' @param HEATMAPMouseOutColor Color of the box when mouse is not hovering anymore, in hexadecimal
#'  RGB format. To revert back to original color, use the value "none".
#' 
#' @param HEATMAPMouseOverDisplay Display the tooltip when mouse hover on a box.
#' @param HEATMAPMouseOverColor Color of the box when hovered.
#' @param HEATMAPMouseOverOpacity Opacity of the box when hovered.
#' @param HEATMAPMouseOverTooltipsHtml01 Label displayed in tooltip in first position, before chromosome number.
#' @param HEATMAPMouseOverTooltipsHtml02 Label displayed in tooltip in second position, before start position.
#' @param HEATMAPMouseOverTooltipsHtml03 Label displayed in tooltip in second position, before end position.
#' @param HEATMAPMouseOverTooltipsHtml04 Label displayed in tooltip in third position, before labels if any.
#' @param HEATMAPMouseOverTooltipsHtml05 Label displayed in tooltip in fourth position, before values.
#' @param HEATMAPMouseOverTooltipsHtml06 Label displayed in tooltip in fifth position, after values.
#' @param HEATMAPMouseOverTooltipsBorderWidth The thickness of the tooltip borders, with units specified (such as em or px). 
#' 
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' 
#' @param elementId the name of the HTML id to be used to contain the visualization.
#' 
#' @param ... Ignored
#' 
#' @examples
#' BioCircos(yChr = FALSE, chrPad = 0, genomeFillColor = "Blues")
#' 
#' @export
BioCircos <- function(tracklist = BioCircosTracklist(),
  genome = "hg19", yChr = TRUE,
  genomeFillColor = "Spectral",
  chrPad = 0.04, 
  displayGenomeBorder = TRUE, genomeBorderColor = "#000", genomeBorderSize = 0.5,
  genomeTicksDisplay = TRUE, genomeTicksLen = 5, genomeTicksColor = "#000", 
  genomeTicksTextSize = "0.6em", genomeTicksTextColor = "#000", genomeTicksScale = 30000000,
  genomeLabelDisplay = TRUE, genomeLabelTextSize = "10pt", genomeLabelTextColor = "#000",
  genomeLabelDx = 0.0, genomeLabelDy = 10, genomeLabelOrientation = 0,
  zoom = TRUE, TEXTModuleDragEvent = FALSE,
  SNPMouseOverDisplay = TRUE, SNPMouseOverColor = "#FF0000", SNPMouseOverCircleSize = 3,
  SNPMouseOverCircleOpacity = 0.9,
  SNPMouseOutDisplay = TRUE, SNPMouseOutColor = "none",
  SNPMouseOverTooltipsHtml01 = "Chromosome: ", SNPMouseOverTooltipsHtml02 = "<br/>Position: ",
  SNPMouseOverTooltipsHtml03 = "<br/>Value: ", SNPMouseOverTooltipsHtml04 = "<br/>",  SNPMouseOverTooltipsHtml05 = "",
  SNPMouseOverTooltipsBorderWidth = "1px",
  ARCMouseOverDisplay = TRUE, ARCMouseOverColor = "#FF0000",
  ARCMouseOverArcOpacity = 0.9,
  ARCMouseOutDisplay = TRUE, ARCMouseOutColor = "none",
  ARCMouseOverTooltipsHtml01 = "Chromosome: ", ARCMouseOverTooltipsHtml02 = "<br/>Start: ",
  ARCMouseOverTooltipsHtml03 = "<br/>End: ", ARCMouseOverTooltipsHtml04 = "<br/>",  ARCMouseOverTooltipsHtml05 = "",
  ARCMouseOverTooltipsBorderWidth = "1px",
  LINKMouseOverDisplay = TRUE, LINKMouseOverStrokeColor = "#FF00FF",
  LINKMouseOverOpacity = 0.9,
  LINKMouseOutDisplay = TRUE, LINKMouseOutStrokeColor = "none",
  LINKMouseOverTooltipsHtml01 = "Fusion: ", LINKMouseOverTooltipsHtml02 = "",
  LINKMouseOverTooltipsBorderWidth = "1px", LINKMouseOverStrokeWidth = 5, LINKMouseOutStrokeWidth = "none",
  BARMouseOutDisplay = TRUE, BARMouseOutColor = "none", BARMouseOverDisplay = TRUE, BARMouseOverColor = "#FF0000",
  BARMouseOverOpacity = 0.9,
  BARMouseOverTooltipsHtml01 = "Chromosome: ", BARMouseOverTooltipsHtml02 = "<br/>Start: ",
  BARMouseOverTooltipsHtml03 = " End: ", BARMouseOverTooltipsHtml04 = "<br/>",  BARMouseOverTooltipsHtml05 = "<br/>Value: ",
  BARMouseOverTooltipsHtml06 = "", BARMouseOverTooltipsBorderWidth = "1px",
  HEATMAPMouseOutDisplay = TRUE, HEATMAPMouseOutColor = "none", HEATMAPMouseOverDisplay = TRUE, HEATMAPMouseOverColor = "#FF0000",
  HEATMAPMouseOverOpacity = 0.9,
  HEATMAPMouseOverTooltipsHtml01 = "Chromosome: ", HEATMAPMouseOverTooltipsHtml02 = "<br/>Start: ",
  HEATMAPMouseOverTooltipsHtml03 = " End: ", HEATMAPMouseOverTooltipsHtml04 = "<br/>",  HEATMAPMouseOverTooltipsHtml05 = "<br/>Value: ",
  HEATMAPMouseOverTooltipsHtml06 = "", HEATMAPMouseOverTooltipsBorderWidth = "1px",
  LINEMouseOutDisplay = TRUE, LINEMouseOutLineOpacity = "none", LINEMouseOutLineStrokeColor = "none",
  LINEMouseOutLineStrokeWidth = "none", LINEMouseOverDisplay = T, LINEMouseOverLineOpacity = 1,
  LINEMouseOverLineStrokeColor = "#FF0000", LINEMouseOverLineStrokeWidth = "none", LINEMouseOverTooltipsHtml01 = "Line",
  LINEMouseOverTooltipsBorderWidth = 0, CNVMouseOutDisplay = TRUE, CNVMouseOutColor = "none",
  CNVMouseOutArcOpacity = 1.0, CNVMouseOutArcStrokeColor = "none", CNVMouseOutArcStrokeWidth = 0,
  CNVMouseOverDisplay = TRUE, CNVMouseOverColor = "#FF0000", CNVMouseOverArcOpacity = 0.9, CNVMouseOverArcStrokeColor = "#F26223",
  CNVMouseOverArcStrokeWidth = 3, CNVMouseOverTooltipsHtml01 = "Chromosome: ", CNVMouseOverTooltipsHtml02 = "<br>Start: ",
  CNVMouseOverTooltipsHtml03 = "<br>End: ", CNVMouseOverTooltipsHtml04 = "<br>Value: ", CNVMouseOverTooltipsHtml05 = "",
  CNVMouseOverTooltipsBorderWidth = "1px", width = NULL, height = NULL, elementId = NULL, ...) {

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
    genomeLabelOrientation = genomeLabelOrientation,
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
    SNPMouseOutCircleOpacity = "none",
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
    SNPMouseOverTooltipsHtml01 = SNPMouseOverTooltipsHtml01,
    SNPMouseOverTooltipsHtml02 = SNPMouseOverTooltipsHtml02,
    SNPMouseOverTooltipsHtml03 = SNPMouseOverTooltipsHtml03,
    SNPMouseOverTooltipsHtml04 = SNPMouseOverTooltipsHtml04,
    SNPMouseOverTooltipsHtml05 = SNPMouseOverTooltipsHtml05,
    SNPMouseOverTooltipsBorderWidth = SNPMouseOverTooltipsBorderWidth,
    zoom = zoom,
    TEXTModuleDragEvent = TEXTModuleDragEvent,
    ARCMouseEvent = T,
    ARCMouseClickDisplay = F,
    ARCMouseClickColor = "red",
    ARCMouseClickArcOpacity = 1.0,
    ARCMouseClickArcStrokeColor = "#F26223",
    ARCMouseClickArcStrokeWidth = 1,
    ARCMouseClickTextFromData = "fourth",
    ARCMouseClickTextOpacity = 1,
    ARCMouseClickTextColor = "red",
    ARCMouseClickTextSize = 8,
    ARCMouseClickTextPostionX = 0,
    ARCMouseClickTextPostionY = 0,
    ARCMouseClickTextDrag = T,
    ARCMouseDownDisplay = F,
    ARCMouseDownColor = "green",
    ARCMouseDownArcOpacity = 1.0,
    ARCMouseDownArcStrokeColor = "#F26223",
    ARCMouseDownArcStrokeWidth = 0,
    ARCMouseEnterDisplay = F,
    ARCMouseEnterColor = "yellow",
    ARCMouseEnterArcOpacity = 1.0,
    ARCMouseEnterArcStrokeColor = "#F26223",
    ARCMouseEnterArcStrokeWidth = 0,
    ARCMouseLeaveDisplay = F,
    ARCMouseLeaveColor = "pink",
    ARCMouseLeaveArcOpacity = 1.0,
    ARCMouseLeaveArcStrokeColor = "#F26223",
    ARCMouseLeaveArcStrokeWidth = 0,
    ARCMouseMoveDisplay = F,
    ARCMouseMoveColor = "red",
    ARCMouseMoveArcOpacity = 1.0,
    ARCMouseMoveArcStrokeColor = "#F26223",
    ARCMouseMoveArcStrokeWidth = 0,
    ARCMouseOutDisplay = ARCMouseOutDisplay,
    ARCMouseOutAnimationTime = 500,
    ARCMouseOutColor = ARCMouseOutColor,
    ARCMouseOutArcOpacity = "none",
    ARCMouseOutArcStrokeColor = "red",
    ARCMouseOutArcStrokeWidth = 0,
    ARCMouseUpDisplay = F,
    ARCMouseUpColor = "grey",
    ARCMouseUpArcOpacity = 1.0,
    ARCMouseUpArcStrokeColor = "#F26223",
    ARCMouseUpArcStrokeWidth = 0,
    ARCMouseOverDisplay = ARCMouseOverDisplay,
    ARCMouseOverColor = ARCMouseOverColor,
    ARCMouseOverArcOpacity = ARCMouseOverArcOpacity,
    ARCMouseOverArcStrokeColor = "#F26223",
    ARCMouseOverArcStrokeWidth = 3,
    ARCMouseOverTooltipsHtml01 =  ARCMouseOverTooltipsHtml01,
    ARCMouseOverTooltipsHtml02 =  ARCMouseOverTooltipsHtml02,
    ARCMouseOverTooltipsHtml03 =  ARCMouseOverTooltipsHtml03,
    ARCMouseOverTooltipsHtml04 =  ARCMouseOverTooltipsHtml04,
    ARCMouseOverTooltipsHtml05 =  ARCMouseOverTooltipsHtml05,
    ARCMouseOverTooltipsBorderWidth = ARCMouseOverTooltipsBorderWidth,
    HISTOGRAMMouseEvent = T,
    HISTOGRAMMouseClickDisplay = F,
    HISTOGRAMMouseClickColor = "red",
    HISTOGRAMMouseClickOpacity = 1.0,
    HISTOGRAMMouseClickStrokeColor = "none",
    HISTOGRAMMouseClickStrokeWidth = "none",
    HISTOGRAMMouseDownDisplay = F,
    HISTOGRAMMouseDownColor = "red",
    HISTOGRAMMouseDownOpacity = 1.0,
    HISTOGRAMMouseDownStrokeColor = "none",
    HISTOGRAMMouseDownStrokeWidth = "none",
    HISTOGRAMMouseEnterDisplay = F,
    HISTOGRAMMouseEnterColor = "red",
    HISTOGRAMMouseEnterOpacity = 1.0,
    HISTOGRAMMouseEnterStrokeColor = "none",
    HISTOGRAMMouseEnterStrokeWidth = "none",
    HISTOGRAMMouseLeaveDisplay = F,
    HISTOGRAMMouseLeaveColor = "red",
    HISTOGRAMMouseLeaveOpacity = 1.0,
    HISTOGRAMMouseLeaveStrokeColor = "none",
    HISTOGRAMMouseLeaveStrokeWidth = "none",
    HISTOGRAMMouseMoveDisplay = F,
    HISTOGRAMMouseMoveColor = "red",
    HISTOGRAMMouseMoveOpacity = 1.0,
    HISTOGRAMMouseMoveStrokeColor = "none",
    HISTOGRAMMouseMoveStrokeWidth = "none",
    HISTOGRAMMouseOutDisplay = BARMouseOutDisplay,
    HISTOGRAMMouseOutAnimationTime = 500,
    HISTOGRAMMouseOutColor = BARMouseOutColor,
    HISTOGRAMMouseOutOpacity = 1.0,
    HISTOGRAMMouseOutStrokeColor = "none",
    HISTOGRAMMouseOutStrokeWidth = "none",
    HISTOGRAMMouseUpDisplay = F,
    HISTOGRAMMouseUpColor = "red",
    HISTOGRAMMouseUpOpacity = 1.0,
    HISTOGRAMMouseUpStrokeColor = "none",
    HISTOGRAMMouseUpStrokeWidth = "none",
    HISTOGRAMMouseOverDisplay = BARMouseOverDisplay,
    HISTOGRAMMouseOverColor = BARMouseOverColor,
    HISTOGRAMMouseOverOpacity = BARMouseOverOpacity,
    HISTOGRAMMouseOverStrokeColor = "none",
    HISTOGRAMMouseOverStrokeWidth = "none",
    HISTOGRAMMouseOverTooltipsHtml01 = BARMouseOverTooltipsHtml01,
    HISTOGRAMMouseOverTooltipsHtml02 = BARMouseOverTooltipsHtml02,
    HISTOGRAMMouseOverTooltipsHtml03 = BARMouseOverTooltipsHtml03,
    HISTOGRAMMouseOverTooltipsHtml04 = BARMouseOverTooltipsHtml04,
    HISTOGRAMMouseOverTooltipsHtml05 = BARMouseOverTooltipsHtml05,
    HISTOGRAMMouseOverTooltipsHtml06 = BARMouseOverTooltipsHtml06,
    HISTOGRAMMouseOverTooltipsPosition = "absolute",
    HISTOGRAMMouseOverTooltipsBackgroundColor = "white",
    HISTOGRAMMouseOverTooltipsBorderStyle = "solid",
    HISTOGRAMMouseOverTooltipsBorderWidth = BARMouseOverTooltipsBorderWidth,
    HISTOGRAMMouseOverTooltipsPadding = "3px",
    HISTOGRAMMouseOverTooltipsBorderRadius = "3px",
    HISTOGRAMMouseOverTooltipsOpacity = 0.8,
    HEATMAPMouseEvent = T,
    HEATMAPMouseClickDisplay = F,
    HEATMAPMouseClickColor = "green",
    HEATMAPMouseClickOpacity = 1.0,
    HEATMAPMouseClickStrokeColor = "none",
    HEATMAPMouseClickStrokeWidth = "none",
    HEATMAPMouseDownDisplay = F,
    HEATMAPMouseDownColor = "green",
    HEATMAPMouseDownOpacity = 1.0,
    HEATMAPMouseDownStrokeColor = "none",
    HEATMAPMouseDownStrokeWidth = "none",
    HEATMAPMouseEnterDisplay = F,
    HEATMAPMouseEnterColor = "green",
    HEATMAPMouseEnterOpacity = 1.0,
    HEATMAPMouseEnterStrokeColor = "none",
    HEATMAPMouseEnterStrokeWidth = "none",
    HEATMAPMouseLeaveDisplay = F,
    HEATMAPMouseLeaveColor = "green",
    HEATMAPMouseLeaveOpacity = 1.0,
    HEATMAPMouseLeaveStrokeColor = "none",
    HEATMAPMouseLeaveStrokeWidth = "none",
    HEATMAPMouseMoveDisplay = F,
    HEATMAPMouseMoveColor = "green",
    HEATMAPMouseMoveOpacity = 1.0,
    HEATMAPMouseMoveStrokeColor = "none",
    HEATMAPMouseMoveStrokeWidth = "none",
    HEATMAPMouseOutDisplay = HEATMAPMouseOutDisplay,
    HEATMAPMouseOutAnimationTime = 500,
    HEATMAPMouseOutColor = HEATMAPMouseOutColor,
    HEATMAPMouseOutOpacity = 1.0,
    HEATMAPMouseOutStrokeColor = "none",
    HEATMAPMouseOutStrokeWidth = "none",
    HEATMAPMouseUpDisplay = F,
    HEATMAPMouseUpColor = "green",
    HEATMAPMouseUpOpacity = 1.0,
    HEATMAPMouseUpStrokeColor = "none",
    HEATMAPMouseUpStrokeWidth = "none",
    HEATMAPMouseOverDisplay = HEATMAPMouseOverDisplay,
    HEATMAPMouseOverColor = HEATMAPMouseOverColor,
    HEATMAPMouseOverOpacity = HEATMAPMouseOverOpacity,
    HEATMAPMouseOverStrokeColor = "none",
    HEATMAPMouseOverStrokeWidth = "none",
    HEATMAPMouseOverTooltipsHtml01 = HEATMAPMouseOverTooltipsHtml01,
    HEATMAPMouseOverTooltipsHtml02 = HEATMAPMouseOverTooltipsHtml02,
    HEATMAPMouseOverTooltipsHtml03 = HEATMAPMouseOverTooltipsHtml03,
    HEATMAPMouseOverTooltipsHtml04 = HEATMAPMouseOverTooltipsHtml04,
    HEATMAPMouseOverTooltipsHtml05 = HEATMAPMouseOverTooltipsHtml05,
    HEATMAPMouseOverTooltipsHtml06 = HEATMAPMouseOverTooltipsHtml06,
    HEATMAPMouseOverTooltipsPosition = "absolute",
    HEATMAPMouseOverTooltipsBackgroundColor = "white",
    HEATMAPMouseOverTooltipsBorderStyle = "solid",
    HEATMAPMouseOverTooltipsBorderWidth = HEATMAPMouseOverTooltipsBorderWidth,
    HEATMAPMouseOverTooltipsPadding = "3px",
    HEATMAPMouseOverTooltipsBorderRadius = "3px",
    HEATMAPMouseOverTooltipsOpacity = 0.8,
    LINKMouseEvent = T,
    LINKMouseClickDisplay = F,
    LINKMouseClickColor = "red",
    LINKMouseClickTextFromData = "fourth",
    LINKMouseClickTextOpacity = 1,
    LINKMouseClickTextColor = "red",
    LINKMouseClickTextSize = 8,
    LINKMouseClickTextPostionX = 0,
    LINKMouseClickTextPostionY = 0,
    LINKMouseClickTextDrag = T,
    LINKMouseDownDisplay = F,
    LINKMouseDownColor = "green",
    LINKMouseEnterDisplay = F,
    LINKMouseEnterColor = "yellow",
    LINKMouseLeaveDisplay = F,
    LINKMouseLeaveColor = "pink",
    LINKMouseMoveDisplay = F,
    LINKMouseMoveColor = "red",
    LINKMouseOutDisplay = LINKMouseOutDisplay,
    LINKMouseOutAnimationTime = 500,
    LINKMouseOutStrokeColor = LINKMouseOutStrokeColor,
    LINKMouseUpDisplay = F,
    LINKMouseUpColor = "grey",
    LINKMouseOverOpacity = LINKMouseOverOpacity,
    LINKMouseOverDisplay = LINKMouseOverDisplay,
    LINKMouseOverStrokeColor = LINKMouseOverStrokeColor,
    LINKMouseOverTooltipsHtml01 =  LINKMouseOverTooltipsHtml01,
    LINKMouseOverTooltipsHtml02 =  LINKMouseOverTooltipsHtml02,
    LINKMouseOverStrokeWidth = LINKMouseOverStrokeWidth,
    LINKMouseOutStrokeWidth = LINKMouseOutStrokeWidth,
    LINKMouseOverTooltipsBorderWidth = LINKMouseOverTooltipsBorderWidth,
    LINEMouseEvent = T,
    LINEMouseClickDisplay = F,
    LINEMouseClickLineOpacity = 1,
    LINEMouseClickLineStrokeColor = "red",
    LINEMouseClickLineStrokeWidth = "none",
    LINEMouseDownDisplay = F,
    LINEMouseDownLineOpacity = 1,
    LINEMouseDownLineStrokeColor = "red",
    LINEMouseDownLineStrokeWidth = "none",
    LINEMouseEnterDisplay = F,
    LINEMouseEnterLineOpacity = 1,
    LINEMouseEnterLineStrokeColor = "red",
    LINEMouseEnterLineStrokeWidth = "none",
    LINEMouseLeaveDisplay = F,
    LINEMouseLeaveLineOpacity = 1,
    LINEMouseLeaveLineStrokeColor = "red",
    LINEMouseLeaveLineStrokeWidth = "none",
    LINEMouseMoveDisplay = F,
    LINEMouseMoveLineOpacity = 1,
    LINEMouseMoveLineStrokeColor = "red",
    LINEMouseMoveLineStrokeWidth = "none",
    LINEMouseOutDisplay = LINEMouseOutDisplay,
    LINEMouseOutAnimationTime = 500,
    LINEMouseOutLineOpacity = LINEMouseOutLineOpacity,
    LINEMouseOutLineStrokeColor = LINEMouseOutLineStrokeColor,
    LINEMouseOutLineStrokeWidth = LINEMouseOutLineStrokeWidth,
    LINEMouseUpDisplay = F,
    LINEMouseUpLineOpacity = 1,
    LINEMouseUpLineStrokeColor = "red",
    LINEMouseUpLineStrokeWidth = "none",
    LINEMouseOverDisplay = LINEMouseOverDisplay,
    LINEMouseOverLineOpacity = LINEMouseOverLineOpacity,
    LINEMouseOverLineStrokeColor = LINEMouseOverLineStrokeColor,
    LINEMouseOverLineStrokeWidth = LINEMouseOverLineStrokeWidth,
    LINEMouseOverTooltipsHtml01 = LINEMouseOverTooltipsHtml01,
    LINEMouseOverTooltipsPosition = "absolute",
    LINEMouseOverTooltipsBackgroundColor = "white",
    LINEMouseOverTooltipsBorderStyle = "solid",
    LINEMouseOverTooltipsBorderWidth = LINEMouseOverTooltipsBorderWidth,
    LINEMouseOverTooltipsPadding = "3px",
    LINEMouseOverTooltipsBorderRadius = "3px",
    LINEMouseOverTooltipsOpacity = 0.8,
    CNVMouseEvent = T,
    CNVMouseClickDisplay = F,
    CNVMouseClickColor = "red",
    CNVMouseClickArcOpacity = 1.0,
    CNVMouseClickArcStrokeColor = "#F26223",
    CNVMouseClickArcStrokeWidth = 0,
    CNVMouseClickTextFromData = "fourth",
    CNVMouseClickTextOpacity = 1,
    CNVMouseClickTextColor = "red",
    CNVMouseClickTextSize = 8,
    CNVMouseClickTextPostionX = 0,
    CNVMouseClickTextPostionY = 0,
    CNVMouseClickTextDrag = T,
    CNVMouseDownDisplay = F,
    CNVMouseDownColor = "green",
    CNVMouseDownArcOpacity = 1.0,
    CNVMouseDownArcStrokeColor = "#F26223",
    CNVMouseDownArcStrokeWidth = 0,
    CNVMouseEnterDisplay = F,
    CNVMouseEnterColor = "yellow",
    CNVMouseEnterArcOpacity = 1.0,
    CNVMouseEnterArcStrokeColor = "#F26223",
    CNVMouseEnterArcStrokeWidth = 0,
    CNVMouseLeaveDisplay = F,
    CNVMouseLeaveColor = "pink",
    CNVMouseLeaveArcOpacity = 1.0,
    CNVMouseLeaveArcStrokeColor = "#F26223",
    CNVMouseLeaveArcStrokeWidth = 0,
    CNVMouseMoveDisplay = F,
    CNVMouseMoveColor = "red",
    CNVMouseMoveArcOpacity = 1.0,
    CNVMouseMoveArcStrokeColor = "#F26223",
    CNVMouseMoveArcStrokeWidth = 0,
    CNVMouseOutDisplay = CNVMouseOutDisplay,
    CNVMouseOutAnimationTime = 500,
    CNVMouseOutColor = CNVMouseOutColor,
    CNVMouseOutArcOpacity = CNVMouseOutArcOpacity,
    CNVMouseOutArcStrokeColor = CNVMouseOutArcStrokeColor,
    CNVMouseOutArcStrokeWidth = CNVMouseOutArcStrokeWidth,
    CNVMouseUpDisplay = F,
    CNVMouseUpColor = "grey",
    CNVMouseUpArcOpacity = 1.0,
    CNVMouseUpArcStrokeColor = "#F26223",
    CNVMouseUpArcStrokeWidth = 0,
    CNVMouseOverDisplay = CNVMouseOverDisplay,
    CNVMouseOverColor = CNVMouseOverColor,
    CNVMouseOverArcOpacity = CNVMouseOverArcOpacity,
    CNVMouseOverArcStrokeColor = CNVMouseOverArcStrokeColor,
    CNVMouseOverArcStrokeWidth = CNVMouseOverArcStrokeWidth,
    CNVMouseOverTooltipsHtml01 = CNVMouseOverTooltipsHtml01,
    CNVMouseOverTooltipsHtml02 = CNVMouseOverTooltipsHtml02,
    CNVMouseOverTooltipsHtml03 = CNVMouseOverTooltipsHtml03,
    CNVMouseOverTooltipsHtml04 = CNVMouseOverTooltipsHtml04,
    CNVMouseOverTooltipsHtml05 = CNVMouseOverTooltipsHtml05,
    CNVMouseOverTooltipsPosition = "absolute",
    CNVMouseOverTooltipsBackgroundColor = "white",
    CNVMouseOverTooltipsBorderStyle = "solid",
    CNVMouseOverTooltipsBorderWidth = CNVMouseOverTooltipsBorderWidth,
    CNVMouseOverTooltipsPadding = "3px",
    CNVMouseOverTooltipsBorderRadius = "3px",
    CNVMouseOverTooltipsOpacity = 0.8
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
#' @examples
#' BioCircos(BioCircosBackgroundTrack('bgTrack', fillColors="#FFEEEE", borderSize = 1))
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
#' @examples
#' BioCircos(BioCircosTextTrack('textTrack', 'Annotation', color = '#DD2222', x = -0.3))
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
#' @param opacities One or multiple opacity values for the points, between 0 and 1.
#' 
#' @param size The size of each point.
#' @param shape Shape of the points. Can be "circle" or "rect".
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' @param range Vector of values to be mapped to the minimum and maximum radii of the track.
#'  Default to 0, mapping the minimal and maximal values input in the values parameter.
#' 
#' @param ... Ignored
#' 
#' @examples
#' BioCircos(BioCircosSNPTrack('SNPTrack', chromosomes = 1:3, positions = 1e+7*2:4, 
#'   values = 1:3, colors = "Accent", labels = c('A', 'B', 'C')) + BioCircosBackgroundTrack('BGTrack'))
#' 
#' @export
BioCircosSNPTrack <- function(trackname, chromosomes, positions, values,
  colors = "#40B9D4", labels = "", size = 2, shape = "circle", opacities = 1,
  maxRadius = 0.9, minRadius = 0.5, range = 0, ...){
  
  # If colors is a palette, create corresponding color vector
  colors = .BioCircosColorCheck(colors, length(positions), "colors")

  track1 = paste("SNP", trackname, sep="_")
  track2 = list(maxRadius = maxRadius, minRadius = minRadius, 
    SNPFillColor = "#9400D3",
    PointType = shape,
    circleSize = size,
    rectWidth = size,
    rectHeight = size,
    range = range)
  tabSNP = suppressWarnings(rbind(unname(chromosomes), unname(positions), unname(values), unname(colors), 
    unname(labels), unname(opacities)))
  rownames(tabSNP) = c("chr", "pos", "value", "color", "des", "opacity")
  track3 = unname(alply(tabSNP, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}


#' Create a track with lines to be added to a BioCircos tracklist
#'
#' Lines are defined by genomic coordinates and values of an ordered set of points,
#'  that will define the edges of the segments.
#' 
#' @param trackname The name of the new track.
#' 
#' @param chromosomes A vector containing the chromosomes on which each vertex is found.
#'  Values should match the chromosome names given in the genome parameter of the BioCircos function.
#' @param positions A vector containing the coordinates on which each vertex are found.
#'  Values should be inferior to the chromosome lengths given in the genome parameter of the BioCircos function.
#' @param values A vector of numerical values associated with each vertex, used to determine the 
#'  radial coordinate of each vertex on the visualization.
#' 
#' @param color The color of the line in hexadecimal RGB format.
#' @param width The line width.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' @param range Vector of values to be mapped to the minimum and maximum radii of the track.
#'  Default to 0, mapping the minimal and maximal values input in the values parameter.
#' 
#' @param ... Ignored
#' 
#' @examples
#' BioCircos(BioCircosLineTrack('LnId', rep(1,30), 2e+6*(1:100), log(1:100)) 
#'   + BioCircosBackgroundTrack('BGId'))
#
#' @export
BioCircosLineTrack <- function(trackname, chromosomes, positions, values, color = "#40B9D4", 
    width = 2, maxRadius = 0.9, minRadius = 0.5, range = 0, ...){
  track1 = paste("LINE", trackname, sep="_")
  track2 = list(maxRadius = maxRadius, minRadius = minRadius, 
    LineColor = color,
    LineWidth = width,
    range = range)
  tabSNP = suppressWarnings(rbind(unname(chromosomes), unname(positions), unname(values)))
  rownames(tabSNP) = c("chr", "pos", "value")
  track3 = unname(alply(tabSNP, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}


#' Create a track with a bar plot to be added to a BioCircos tracklist
#'
#' Bins are defined by a genomic range and associated with a numerical value
#' 
#' @param trackname The name of the new track.
#' 
#' @param chromosomes A vector containing the chromosomes on which each bar is found.
#'  Values should match the chromosome names given in the genome parameter of the BioCircos function.
#' @param starts,ends Vectors containing the coordinates on which each bin begins or ends.
#' @param values A vector of numerical values associated with each bin, used to determine the 
#'  height of each bar on the track.
#' 
#' @param labels One or multiple character objects to label each bar.
#' 
#' @param range Vector of values to be mapped to the minimum and maximum radii of the track.
#'  Default to 0, mapping the minimal and maximal values input in the values parameter.
#' @param color The color for the bars, in hexadecimal RGB format.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' 
#' @param ... Ignored
#' 
#' @examples
#' BioCircos(BioCircosBarTrack('BarTrack', chromosomes = 1:3, starts = 1e+7*2:4, ends = 2.5e+7*2:4, 
#'   values = 1:3, labels = c('A ', 'B ', 'C '), range = c(0,4)) + BioCircosBackgroundTrack('BGTrack'))
#' 
#' @export
BioCircosBarTrack <- function(trackname, chromosomes, starts, ends, values,
  labels = "", maxRadius = 0.9, minRadius = 0.5, color = "#40B9D4", range = 0, ...){
  
  track1 = paste("HISTOGRAM", trackname, sep="_")
  track2 = list(maxRadius = maxRadius, minRadius = minRadius, 
    histogramFillColor = color,
    range = range)
  tabHist = suppressWarnings(rbind(unname(chromosomes), unname(starts), unname(ends), unname(labels), unname(values)))
  rownames(tabHist) = c("chr", "start", "end", "name", "value")
  track3 = unname(alply(tabHist, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}

#' Create a track with concentric arcs to be added to a BioCircos tracklist
#'
#' Arcs are defined by a genomic range and radially associated with a numerical value
#' 
#' @param trackname The name of the new track.
#' 
#' @param chromosomes A vector containing the chromosomes on which each arc is found.
#'  Values should match the chromosome names given in the genome parameter of the BioCircos function.
#' @param starts,ends Vectors containing the coordinates on which each arc begins or ends.
#' @param values A vector of numerical values associated with each bin, used to determine the 
#'  height of each bar on the track.
#' 
#' @param width The thickness of the arc
#' @param color The color for the arcs, in hexadecimal RGB format.
#' @param range Vector of values to be mapped to the minimum and maximum radii of the track.
#'  Default to 0, mapping the minimal and maximal values input in the values parameter.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' 
#' @param ... Ignored
#' 
#' @examples
#' BioCircos(BioCircosCNVTrack('BarTrack', chromosomes = 1:3, starts = 1e+7*2:4, ends = 2.5e+7*2:4, 
#'   values = 1:3, color = "#BB0000", maxRadius = 0.85, minRadius = 0.55) 
#'   + BioCircosBackgroundTrack('BGTrack'))
#' @export
BioCircosCNVTrack <- function(trackname, chromosomes, starts, ends, values,
  maxRadius = 0.9, minRadius = 0.5, width = 1, color = "#40B9D4", range = 0, ...){
  
  track1 = paste("CNV", trackname, sep="_")
  track2 = list(maxRadius = maxRadius, minRadius = minRadius, 
    CNVColor = color, CNVwidth = width, range = range)
  tabHist = suppressWarnings(rbind(unname(chromosomes), unname(starts), unname(ends), unname(values)))
  rownames(tabHist) = c("chr", "start", "end", "value")
  track3 = unname(alply(tabHist, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}

#' Create a heatmap track to be added to a BioCircos tracklist
#'
#' Heatmaps are defined by the genomic range and the color-associated numerical value
#'  of each box of the heatmap layer
#' 
#' @param trackname The name of the new track.
#' 
#' @param chromosomes A vector containing the chromosomes on which each box is found.
#'  Values should match the chromosome names given in the genome parameter of the BioCircos function.
#' @param starts,ends Vectors containing the coordinates on which each box begins or ends.
#' @param values A vector of numerical values associated with each box, used to determine the 
#'  height of each bar on the track.
#' 
#' @param labels One or multiple character objects to label each bar.
#' 
#' @param range a vector of the values to be mapped to the minimum and maximum colors of the track.
#'  Default to 0, mapping the minimal and maximal values input in the values parameter.
#' @param color a vector of the colors in hexadecimal RGB format to be mapped to the minimum and 
#'  maximum values of the track.
#'  Colors of intermediate values will be linearly interpolated between this two colors.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' 
#' @param ... Ignored
#' 
#' @examples
#' BioCircos(BioCircosHeatmapTrack('HmTrack', chromosomes = 1:3, starts = 1e+7*2:4, ends = 2.5e+7*2:4, 
#'   values = 1:3, labels = c('A ', 'B ', 'C ')))
#' 
#' @export
BioCircosHeatmapTrack <- function(trackname, chromosomes, starts, ends, values,
  labels = "", maxRadius = 0.9, minRadius = 0.5, color = c("#40B9D4", "#F8B100"), range = 0, ...){
  
  track1 = paste("HEATMAP", trackname, sep="_")
  track2 = list(outerRadius = maxRadius - 8/7, innerRadius = minRadius - 1,
       minColor = color[1], maxColor = color[2], range = range)  # In JS lib the innerRadius and outerRadius are
  # based on the inner and outer radii of the chromosome. Here we convert the arc coordinates to percentage of the space
  # inside the chromosome, based on the assumption that the inner and outer radii of the chromosome are respectively at 70
  # and 80 percents of the widget minimal dimension. The conversion to absolute values is performed on the JavaScript side. 
  tabHeat = suppressWarnings(rbind(unname(chromosomes), unname(starts), unname(ends), unname(labels), unname(values)))
  rownames(tabHeat) = c("chr", "start", "end", "name", "value")
  track3 = unname(alply(tabHeat, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}


#' Create a track with arcs to be added to a BioCircos tracklist
#'
#' Arcs are defined by beginning and ending genomic coordinates
#' 
#' @param trackname The name of the new track.
#' 
#' @param chromosomes A vector containing the chromosomes on which each arc is found.
#'  Values should match the chromosome names given in the genome parameter of the BioCircos function.
#' @param starts,ends Vectors containing the coordinates on which each arc begins or ends.
#'  Values should be inferior to the chromosome lengths given in the genome parameter of the BioCircos function.
#' 
#' @param colors The colors for each arc. Can be a RColorBrewer palette name used to
#'  generate one color per arc, or a character object or vector of character objects stating RGB values in hexadecimal
#'  format or base R colors. If the vector is shorter than the number of arcs, values will be repeated.
#' @param labels One or multiple character objects to label each arc.
#' @param opacities One or multiple opacity values for the arcs, between 0 and 1.
#' 
#' @param minRadius,maxRadius Where the track should begin and end, in proportion of the inner radius of the plot.
#' 
#' @param ... Ignored
#' 
#' @examples
#' BioCircos(BioCircosArcTrack('ArcTrack', chromosomes = 1:5, starts = 2e+7*1:5, ends = 2.5e+7*2:6))
#' 
#' @export
BioCircosArcTrack <- function(trackname, chromosomes, starts, ends,
  colors = "#40B9D4", labels = "", opacities = 1,
  maxRadius = 0.9, minRadius = 0.5, ...){
  
  # If colors is a palette, create corresponding color vector
  colors = .BioCircosColorCheck(colors, length(starts), "colors")

  track1 = paste("ARC", trackname, sep="_")
  track2 = list(outerRadius = maxRadius - 8/7, innerRadius = minRadius- 1) # In JS lib the innerRadius and outerRadius are
  # based on the inner and outer radii of the chromosome. Here we convert the arc coordinates to percentage of the space
  # inside the chromosome, based on the assumption that the inner and outer radii of the chromosome are respectively at 70
  # and 80 percents of the widget minimal dimension. The conversion to absolute values is performed on the JavaScript side. 
  tabSNP = suppressWarnings(rbind(unname(chromosomes), unname(starts), unname(ends), unname(colors), unname(labels), unname(opacities)))
  rownames(tabSNP) = c("chr", "start", "end", "color", "des", "opacity")
  track3 = unname(alply(tabSNP, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}


#' Create an inner track with links to be added to a BioCircos tracklist
#'
#' Links are defined by beginning and ending genomic coordinates of the 2 regions to linked,
#'  such as the positions linked in genomic fusions.
#' 
#' @param trackname The name of the new track.
#' 
#' @param gene1Chromosomes,gene1Starts,gene1Ends,gene1Names,gene2Chromosomes,gene2Starts,gene2Ends,gene2Names
#'  Vectors with the chromosomes, genomic coordinates of beginning and end, and names of both genes to link.
#'  Chromosomes and positions should respect the chromosome names and lengths given in the genome parameter of
#'  the BioCircos function.
#' 
#' @param color The color for the links, in hexadecimal RGB format.
#' @param width The thickness of the links.
#' 
#' @param labels A vector of character objects to label each link.
#' 
#' @param displayAxis Display additional axis (i.e. circle) around the track.
#' @param axisColor,axisWidth,axisPadding Color, thickness and padding of the additional axis.
#' 
#' @param displayLabel Display labels of the track.
#' @param labelColor,labelSize,labelPadding Color, font size and padding of the labels around the track.
#' 
#' @param maxRadius Where the track should end, in proportion of the inner radius of the plot.
#' 
#' @param ... Ignored
#' 
#' @examples
#' start_chromosomes <- 1:5
#' end_chromosomes <- 2*10:6
#' start_pos <- 2.5e+7*2:6
#' end_pos <- 2e+7*1:5
#' BioCircos(BioCircosLinkTrack('LinkTrack', start_chromosomes, start_pos, start_pos+1,
#'   end_chromosomes, end_pos, end_pos+1, color = '#FF00FF'))
#' 
#' @export
BioCircosLinkTrack <- function(trackname, gene1Chromosomes, gene1Starts, gene1Ends,
  gene2Chromosomes, gene2Starts, gene2Ends, color = "#40B9D4", labels = "",
  maxRadius = 0.4, width = "0.1em",
  gene1Names = "", gene2Names = "", displayAxis = TRUE, axisColor = "#B8B8B8", axisWidth = 0.5,
  axisPadding = 0, displayLabel = TRUE, labelColor = "#000000",
  labelSize = "1em", labelPadding = 3, ...){
  
  track1 = paste("LINK", trackname, sep="_")
  track2 = list(LinkRadius = maxRadius, LinkFillColor = color, LinkWidth = width,
  displayLinkAxis = displayAxis, LinkAxisColor = axisColor, LinkAxisWidth = axisWidth,
  LinkAxisPad = axisPadding, displayLinkLabel = displayLabel, LinkLabelColor = labelColor,
  LinkLabelSize = labelSize, LinkLabelPad = labelPadding)

  tabSNP = suppressWarnings(rbind(unname(labels), unname(gene1Chromosomes), unname(gene1Starts), unname(gene1Ends), 
    unname(gene1Names), unname(gene2Chromosomes), unname(gene2Starts), unname(gene2Ends), unname(gene2Names)))
  rownames(tabSNP) = c("fusion", "g1chr", "g1start", "g1end", "g1name", "g2chr", "g2start", "g2end", "g2name")
  track3 = unname(alply(tabSNP, 2, as.list))

  track = BioCircosTracklist() + list(list(track1, track2, track3))
  return(track)
}


#' Create a list of BioCircos tracks
#'
#' This allows the use of the '+' and '-' operator on these lists
#' 
#' @name BioCircosTracklist
#' 
#' @param x The tracklist on which other tracks should be added or removed.
#' @param ... The tracks to add (as tracklists) or to remove (as track names).
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

#' @rdname BioCircosTracklist
#' @export
"-.BioCircosTracklist" <- function(x,...) {
  indicesToDelete = list()
  for (i in 1:length(x)){
    if(paste(strsplit(x[[i]][[1]], '_')[[1]][-1], collapse = "_") %in% ...){
      indicesToDelete = append(indicesToDelete, i)
    }
  }
  y <- x
  y[unlist(indicesToDelete)] <- NULL
  return(y)
}

.BioCircosColorCheck <- function(colVar, colLength, varName = "Color") {
# If genomeFillColor is a string, create corresponding palette
  colorError = paste0("\'", varName, 
    "\' parameter should be either a vector of chromosome colors or the name of a RColorBrewer brewer.")
  if(class(colVar) == "character"){
    if(all(colVar %in% rownames(RColorBrewer::brewer.pal.info))&(length(colVar) == 1)) { # RColorBrewer's brewer
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