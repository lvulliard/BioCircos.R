#' BioCircos
#'
#' Interactive circular visualisation of genomic data using ‘htmlwidgets’ and ‘BioCircos.js’
#'
#' @import htmlwidgets
#' @import RColorBrewer
#'
#' @export

#' BioCircos widget
#'
#' Interactive circular visualisation of genomic data using ‘htmlwidgets’ and ‘BioCircos.js’
#' 
#' @param message A message to display.
#' @param genome A list of chromosome lengths to be used as reference for the vizualization or 'hg19' to use
#'  the chromosomes 1 to 22 and the sexual chromosomes according to the hg19 reference.
#' @param yChr A logical stating if the Y chromosome should be displayed.
#' @param genomeFillColor The color to display in each chromosome. Can be a RColorBrewer palette name used to
#'  generate one color per chromosome, or a character or vector of characters stating RGB values in hexadecimal
#'  format or base R colors. If the vector is shorter than the reference genome, values will be repeated.
#'
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' 
#' @param ... Ignored
#' 
#' @export
BioCircos <- function(message, 
  genome = "hg19", yChr = TRUE,
  genomeFillColor = "Spectral",
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
        "X" = 155270560,
        "Y" = 59373566)
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
    genome = genome,
    genomeFillColor = genomeFillColor
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
