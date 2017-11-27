#' BioCircos
#'
#' Interactive circular visualisation of genomic data using ‘htmlwidgets’ and ‘BioCircos.js’
#'
#' @import htmlwidgets
#'
#' @export
BioCircos <- function(message, 
  genome = "hg19", sex = "M", 
  width = NULL, height = NULL, elementId = NULL) {

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

  # forward options using x
  x = list(
    message = message,
    genome = genome
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
