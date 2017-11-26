#' BioCircos
#'
#' Interactive circular visualisation of genomic data using ‘htmlwidgets’ and ‘BioCircos.js’
#'
#' @import htmlwidgets
#'
#' @export
BioCircos <- function(message, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    message = message
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
